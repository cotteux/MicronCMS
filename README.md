# MicronCMS
Base on the Collection of various pages from NomadNet_pages.

This script emulate a frame website with header, menu and footer.
Page files can be written in micron and python.
Come with status.mu example of a python dynamic page.

Come with a Messages Board and some small python games in the folder Games.

To add new games just copy the .mu file in Games and it's appear in Games Menu.

This repository contains a cms that can be hosted on a NomadNet Node.
Copy All in the .nomadnet/storage/page

pip3 install pyyaml

chmod -Rf +x *

Change config folder in index.mu
Configure config.yaml

Don't forget to start the python3 messageboard.py if you want people to send you message.
and update messageboard.mu message_board_peer = '' with the one give it to you by messageboard.py

Coming soon more modules and options.

Demo on Nomadnet : 3e05f77a9f0dbfc124f230862153c9f9/page/index.mu
