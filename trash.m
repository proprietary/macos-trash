#include <AppKit/AppKit.h>
#include <CoreFoundation/CoreFoundation.h>
#include <Foundation/Foundation.h>

#include <stdlib.h>
#include <unistd.h>

#define VERSION "1.0.0"

void printUsage() {
  printf("Usage: trash [-v|--version] [-h|--help] <file1> [<file2> ...]\n");
  printf("Move files to the trash.\n\n");
  printf("Options:\n");
  printf("  -v, --version    Display the version number and exit.\n");
  printf("  -h, --help       Display this help message and exit.\n");
}

NSString *currentWorkingDirectory() {
  char cwd[1024];
  if (getcwd(cwd, sizeof(cwd)) != NULL) {
    return [NSString stringWithUTF8String:cwd];
  } else {
    exit(1);
    return nil;
  }
}

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSArray *args = [[NSProcessInfo processInfo] arguments];
    NSMutableArray *filePaths = [NSMutableArray arrayWithArray:args];
    [filePaths removeObjectAtIndex:0];

    if ([filePaths containsObject:@"-v"] || [filePaths containsObject:@"--version"]) {
      printf("trash version %s\n", VERSION);
      return 0;
    }

    if ([filePaths containsObject:@"-h"] || [filePaths containsObject:@"--help"] ||
        [filePaths count] == 0) {
      printUsage();
      return 0;
    }

    NSWorkspace *workspace = [NSWorkspace sharedWorkspace];

    NSString *cwd = currentWorkingDirectory();

    NSMutableArray *fileURLs = [NSMutableArray array];
    for (NSString *path in filePaths) {
      NSString *absolutePath = [path stringByStandardizingPath];
      if ([path hasPrefix:@"~"]) {
        absolutePath = [absolutePath stringByExpandingTildeInPath];
      } else if (![path hasPrefix:@"/"]) {
        absolutePath = [[[NSFileManager defaultManager] currentDirectoryPath]
            stringByAppendingPathComponent:path];
      } else {
        absolutePath = [cwd stringByAppendingPathComponent:path];
      }
      NSURL *fileURL = [NSURL fileURLWithPath:absolutePath];
      [fileURLs addObject:fileURL];
    }

    __block BOOL completed = NO;

    [workspace recycleURLs:fileURLs
         completionHandler:^(NSDictionary<NSURL *, NSURL *> *newURLs, NSError *error) {
           completed = YES;
           CFRunLoopStop(CFRunLoopGetCurrent());
         }];

    while (!completed) {
      CFRunLoopRun();
    }
  }

  return 0;
}
