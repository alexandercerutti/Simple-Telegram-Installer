Simple Telegram Installer
======
A simple Telegram installer for linux

####Description

At the current version (0.9.33), Telegram provides only two executable files (Telegram itself and its updater) and no installer like many other linux softwares. So, I decided to create this installer in bash for Linux to download, extract and find Telegram (if you already downloaded it). To let the script search the already downloaded version, just type the name of the _archive_ (.tar.xz) straight after the script name, like this:

        ./installTelegram.sh telegram.tar.xz

If file control fails (not passed as argument and/or not found), the script looks for _telegram_ and _Telegram_ folders in its path. Otherwise, it tries to download and extract Telegram archive.
Once found the extracted folder, the script will move it to **/usr/local/bin/** or **/opt/** (if the first cannot be found).

####Indexing
On Linux, software indexing it done with **.desktop** files. In fact, I pushed also a ready version of **telegram.desktop** that will be edited if the script cannot find /usr/local/bin/ folder. This file is moved to **/usr/share/applications/**.

With everything else, I've uploaded also a 128x128 icon for the index of the program, so when you'll search Telegram inside the index (like Ubuntu menu), you'll see it.

Last two things and I'll not annoy you anymore :smile:.
- Tested on Ubuntu 15.10: the script will restart _lightdm_ once finished.
- You may need to change script permissions before starting it. Please, move to the script folder and type in terminal window:

        chmod 777 installTelegram.sh

Thank you for using my script!

######Script screenshot:

![screen](http://i.imgur.com/mBmej8y.png)
