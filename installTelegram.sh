#!/bin/sh
#telegram installer
FILE="$1";
dir=/usr/local/bin;
clear; #cleans the console
echo "\n******************************************************";
echo "\n  Welcome into Simple Telegram Installer";
echo "  This program can both download Telegram and read it\n  from an archive (tar.xz format).\n"
#using /bin/echo to not use Dash's echo command. This lets me style the text
/bin/echo -e "  To link a file, abort this actual session by answering\n  'no' to the following question and then start the program\n  again like this:\n\n\t$ \e[1m./installtelegram.sh yourfile.tar.xz.\e[0m";
echo "\n******************************************************\n";
echo -n "  Are you ready to begin the installation? [y/n] >> ";
read m;
case $m in
    [yY]|[sS])
    # Downloading or seeking for the the file / folder
    if [ -z "$FILE" -o ! -f $FILE ]; then
        if [ ! -d telegram -a ! -d Telegram ]; then
            echo "  I'm downloading Telegram... Download speed may vary depending by your connection speed.\n  DO NOT DELETE ANY NEW FILE ON DESKTOP. Press CTRL-Z to abort.\n";
            echo "\n  Please, stand behind the yellow line.";
            #using /bin/echo to not use Dash's echo command. This lets me style the text
            /bin/echo -e "\e[93m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .\e[0m";
            /bin/echo -e "\e[103m\t\t\t\t\t\t\t\t\t\t \e[0m \n";
            sudo wget --progress=bar http://tdesktop.com/linux -O telegram.tar.xz --no-check-certificate;
        fi
    fi
    if [ ! -d telegram -a ! -d Telegram ]; then
        tar xvfJ telegram.tar.xz
        if [ -d Telegram ]; then
            sudo mv Telegram telegram;
        fi
    fi
    if [ -f "telegram128.png" ]; then
        sudo cp telegram128.png telegram/;
    else
        echo "telegram128.png is missing. You will not see any icon.";
    fi
    if [ ! -d $dir ]; then
        dir=/opt;
        echo "There's a problem with the folder: /usr/local/bin/ seems not to exists. Your application will be located in /opt/";
    fi
    sudo mv -i telegram $dir/;

    #creating index file
    if [ ! -f "/usr/share/applications/telegram.desktop" ]; then
        echo "Creating and moving telegram.desktop file...";
        printf "%s\n" "[Desktop Entry]" "Encoding=UTF-8" "Name=Telegram" "Exec=$dir/telegram/Telegram" "Icon=$dir/telegram/telegram128.png" "Type=Application" "Categories=Network" "Comment=Telegram" "[Desktop Action Gallery]" "Exec=$dir/telegram/Telegram" "Name=Telegram" >| telegram.desktop;
        mv telegram.desktop /usr/share/applications/;
    else
        echo "telegram.desktop already existing! The file doesn't need to be replaced.";
    fi

    echo -n "Want to delete following 3 files? telegram.tar.xz, telegram icon, telegram index file [y/n]";
    read m;
    if echo $m | grep "^[yYsS]"; then
        rm -rf telegram.tar.xz;
        rm telegram128.png;
    fi

    echo "Ending...\nThank you to have used Simple Telegram Installer.";
    ;;
*)
    echo "Okay, see you!";
    ;;
esac
