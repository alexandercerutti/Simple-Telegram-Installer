Telegram-Installer
======
Telegram installer for linux, by eXander

####Description

To the actual version 0.9.33, Telegram provides just two executable files (Telegram itself and its updater) and no installer, like many other softwares. I decided to create this installer in bash for Linux to download, extract and find Telegram (if you already downloaded it). You can try to make the software finding the already downloaded version by typing the name of the _archive_ (.tar.xz) straight after the script name, like this:

        ./installTelegram.sh telegram.tar.xz

If file control fails (not passed as argument or not found), it automatically searches the folders _telegram_ and _Telegram_ in the same path of the script. Else it tries to download and extract it.
Once found the extracted folder, it will move it automatically to **/usr/local/bin/** or **/opt/**.
Another function is about the software indexing. On Linux, it is made by **.desktop** files. In fact, I pushed also a ready version of **telegram.desktop** that will be edited if the script cannot find /usr/local/bin/. This file is moved to **/usr/share/applications/**.

With everything else, I've uploaded also a 128x128 icon for the index of the program, so when you'll search Telegram inside the index (like Ubuntu menu), you'll see it.

Last two things and I'll not annoy you anymore.
- Tested on Ubuntu 15.10: the script will restart _lightdm_ once finished.
- You may need to change script permissions before starting it. Please, locate inside script folder and do

        chmod 777 installTelegram.sh

Thank you for using my script!
