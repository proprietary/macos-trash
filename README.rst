``trash`` for macOS
~~~~~~~~~~~~~~~~~~~~

This is a simple utility to send files to macOS's Trash from the command line.

This works on macOS Sonoma 14.5 (June 2024).

Download and install binary release
---------------------------------------

.. code-block:: bash

  curl -fSLO https://github.com/proprietary/macos-trash/releases/download/v1.0.0/trash
  sudo install ./trash /usr/local/bin

Usage
-------

.. code-block:: bash

   cd /tmp
   echo "hello world" > hello-world.txt
   trash hello-world.txt

This works on directories or regular files. I suggest using
``trash`` anywhere you would have used ``rm(1)``.

Currently, this command line tool cannot restore files. You will have
to open Trash in Finder and restore it from the GUI.

Building manually
-------------------

Build
=====

.. code-block:: bash

  xcode-select --install
  git clone https://github.com/proprietary/macos-trash
  cd macos-trash
  make
  make test
  sudo make install

Verify installation
===================

.. code-block:: bash

  trash --version


License
--------

Apache-2.0
