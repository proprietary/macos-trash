``trash`` for macOS
~~~~~~~~~~~~~~~~~~~~

This is a simple utility to send files to macOS's Trash from the command line.

This works on macOS Sonoma 14.5 (June 2024).

Build and install
------------------

.. code-block:: bash

  xcode-select --install
  git clone https://github.com/proprietary/macos-trash
  cd macos-trash
  make
  make test
  sudo make install

Verify installation
-------------------

.. code-block:: bash

  trash --version

Usage
-------

.. code-block:: bash

   cd /tmp
   echo "hello world" > hello-world.txt
   trash hello-world.txt

Currently, this command line tool cannot restore files. You will have to open Trash in Finder and restore it from the GUI. I suggest using `trash` instead of `rm`.

License
--------

Apache-2.0
