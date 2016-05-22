Simple Telegram Installer
======
A simple Telegram installer for linux.

####Description

At the current version (0.9.49), Telegram provides only two executable files (Telegram itself and its updater) and no installer like many other linux softwares. So, I decided to create this installer in bash for Linux to download, extract and find Telegram (if you already downloaded it).
This script offers five ways to install Telegram: auto-detection, manual-detection, file, folder, download.

#####Auto-detection
Auto-detection will try automatically to retrieve Telegram (in order) from _**script argument**_, _**telegram.tar.xz archive**_, _**extracted folder**_ , _**download from the web**_. Auto-detection has **--auto** suffix.

The _script argument_ is an archive (.tar.xz) placed somewhere in your pc. To start with it, you will need to start the script like this:

        ./installTelegram.sh --auto <path-to-archive>.tar.xz

The _telegram.tar.xz archive_ is an archive already downloaded by telegram by the website of via the script.
The _extracted folder_ is a folder extracted from telegram.tar.xz, called **telegram** or **Telegram**.
_download from the web_, will download telegram from the official website.

#####Manual-detection
Manual-detection will lists you all the available ways to install Telegram (like auto-detection method). Manual-detection has **--manual** suffix.

        ./installTelegram.sh --manual

This parameter let you also to install Telegram via _**snap**_, the newer Ubuntu _packet manager_, unavailable way in auto-detection mode. This voice will appear only if snap is installed.
As in auto-detection mode, _script argument_ is an archive (tar.xz) placed somewhere in your pc. To start with it, you will need to start the script like this:

        ./installTelegram.sh --manual <path-to-archive>.tar.xz

Passing a file-argument to **--manual**, will still display also the other ways to install Telegram.
If an option is not available, it will be not displayed. Each option has a 'keyword' with which you can start each of them.
For the other ways, please see _auto-detection_ options.


#####File
File is a shoutcut to **--auto** _script argument_. It has the suffix **-f**;


#####Folder and download
If none of the previous args are passed to the script, the script itself will scan its folder searching telegram folder (_extracted folder_). Else it will download and process the archive from Telegram official website (tdesktop.com/linux);


Once found the extracted folder, the script will move it to **/usr/local/bin/** or **/opt/** (if the first cannot be found).
On Linux, software indexing is done with **.desktop** files. The script will create and move the file _telegram.desktop_ to **/usr/share/applications/**.

I also uploaded a 128x128 icon for Telegram inside the search menu (like Ubuntu's one).

The last thing and I'll not annoy you anymore. :smile: You may need to change script permissions before starting it. Please, move to the script folder and type in terminal window:

        chmod 777 installTelegram.sh

Thank you for using my script!

######Script screenshot:

![screen](http://i.imgur.com/mBmej8y.png)
