#!/bin/sh
#simple telegram installer
FILE="$2";
PAR="$1";
bs=$(basename "$0");
dir=/usr/local/bin;

clear;
echo "\n******************************************************";
echo "\n  Welcome into Simple Telegram Installer";
echo "  This program can both download Telegram and read it\n  from an archive (tar.xz format).\n"
#using /bin/echo to not use Dash's echo command. This lets me style the text
/bin/echo -e "  To link a file, abort this actual session by answering\n  'no' to the following question and then start the program\n  again like this:\n\n\t$ \e[1m./installtelegram.sh yourfile.tar.xz.\e[0m";
echo "\n******************************************************\n";

echo -n "  Are you ready to begin the installation? The next step\n  will depend by arguments. [y/n] >> ";
read m;

case $PAR in
    --auto)
        # Cerca sequenzialmente in maniera automatica
        if [ ! -z "$FILE" ] && [ -f $FILE ]; then
            echo -n "  STI will install telegram from the archive passed as argument.\n"
            METHOD="args";
        elif [ -f telegram.tar.xz ]; then
            echo "\n  telegram.tar.xz has been found in the script folder.\n  STI will install from this souce."
            FILE=telegram.tar.xz;
            METHOD="file";
        elif [ -d telegram ] || [ -d Telegram ]; then
            echo "\n  telegram folder has been found in the script folder.\n  STI will install from this source."
            METHOD="folder";
        else
            echo "\n  STI will provide to download telegram. Please, make sure to be connected to internet."
            METHOD="dw"
        fi
        ;;
    --manual)
        echo -n "  You have chosen to check manual ways to install Telegram.\n  Write the name written in brackets to choose.\n  You can also abort by typing \"abort\"\n";
        # Fa scegliere la sorgente
        if [ ! -z "$FILE" ] && [ -f $FILE ]; then
            echo "  - Pass an archive as parameter to the script. (args)"
        fi
        if [ -f telegram.tar.xz ]; then
            echo "  - Install from archive in script directory. (file)"
        fi
        if [ -d telegram ] || [ -d Telegram ]; then
            echo "  - Install from extracted folder in script directory. (folder)"
        fi
        if dpkg -l | grep snapd >>/dev/null 2>/dev/null; then
            echo "  - Download the last version from snap. (snap)"
        fi
            echo "  - Download the last version from the web. (dw)"
        echo -n ">> ";
        read METHOD;
        ;;
    -f)
        METHOD="args"
        ;;
    *)
        # checks the folder and the download.
        if [ -d telegram ] || [ -d Telegram ]; then
            METHOD="folder";
        else
            METHOD="dw";
        fi
        ;;
esac
case $m in
    [yY]|[sS])
    # Downloading or seeking for the the file / folder
    case $METHOD in
        args)
            # somewhere in your pc
            if [ ! -z "$FILE" ] && [ -f $FILE ]; then
                tar xfJ $FILE;
            else
                echo -n "File not found or unreachable. Insert a path or file. The script will be restarted. Write \"abort\" to abort.";
                read $FILE;
                if [ $FILE == "abort" ]; then
                    exit;
                else
                    ./$bs --auto
                    exit;
                fi;
            fi
        ;;
        file)
            # already downloaded
            # control if telegram folder already existing and removing it.
            if [ -d "$dir/telegram" ]; then
                rm -rf $dir/telegram;
            fi
            if [ -f telegram.tar.xz ]; then
                tar xfJ telegram.tar.xz;
            else
                echo "telegram.tar.xz archive not found or unreachable. The program will be aborted."
                exit;
            fi
        ;;
        folder)
            if [ ! -d telegram ] && [ ! -d Telegram ]; then
                echo "Telegram and telegram folder not found. The program will be aborted."
                exit;
            fi
        ;;
        snap)
        if dpkg -l | grep snapd >>/dev/null 2>/dev/null; then
            echo "  At the actual version, snap version have some limitations. Want me to continue anyway? Else the program will be aborted.";
            read m;
            if echo m | grep "^[yYsS]" >>/dev/null 2>/dev/null; then
                sudo install telegram-sergiusens
            fi
        else
            echo "  Snap is not installed. The program will be aborted".
        fi
        ;;
        abort)
            exit;;
        *)
            echo "  I'm downloading Telegram... Download speed may vary depending by your connection speed.\n  DO NOT DELETE ANY NEW FILE ON DESKTOP. Press CTRL-Z to abort.\n";
            echo "\n  Please, stand behind the yellow line.";
            #using /bin/echo to not use Dash's echo command. This lets me style the text
            /bin/echo -e "\e[93m. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .\e[0m";
            /bin/echo -e "\e[103m\t\t\t\t\t\t\t\t\t\t \e[0m \n";
            sudo wget --progress=bar http://tdesktop.com/linux -O telegram.tar.xz --no-check-certificate;
            tar xfJ telegram.tar.xz;
        ;;
    esac
    if [ $METHOD != "snap" ]; then
        #Renaming the folder to lower case.
        if [ -d Telegram ]; then
            sudo mv Telegram telegram;
        fi
        #Moving the icon
        if [ -f "telegram128.png" ]; then
            sudo cp telegram128.png telegram/;
        else
            echo "telegram128.png is missing. You will not see any icon.";
        fi
        #Valid folder control (for /usr/local/bin)
        if [ ! -d $dir ]; then
            echo "There's a problem with the folder: /usr/local/bin/ seems not to exists. Your application will be located in /opt/";
            dir=/opt;
        fi
        #removing older telegram folder in $dir.
        if [ -d $dir/telegram ]; then
            sudo rm -rf $dir/telegram;
        fi
        #coping the new folder and deleting it from the download place.
        sudo cp -af telegram $dir/;
        sudo rm -rf telegram;
        #creating index file
        if [ ! -f "/usr/share/applications/telegram.desktop" ]; then
            echo "  Creating and moving telegram.desktop file...";
            printf "%s\n" "[Desktop Entry]" "Encoding=UTF-8" "Name=Telegram" "Exec=$dir/telegram/Telegram" "Icon=$dir/telegram/telegram128.png" "Type=Application" "Categories=Network" "Comment=Telegram" "[Desktop Action Gallery]" "Exec=$dir/telegram/Telegram" "Name=Telegram" >| telegram.desktop;
            mv telegram.desktop /usr/share/applications/;
        else
            echo "  telegram.desktop already existing! The file doesn't need to be replaced.";
        fi

        #Waste deletion control
        if [ -f telegram.tar.xz ]; then
            echo -n "  Would you delete the downloaded file (telegram.tar.xz)? [y/n] ";
            read m;
            if echo $m | grep "^[yYsS]" >>/dev/null 2>/dev/null; then
                rm -rf telegram.tar.xz;
            fi
        fi
        if [ -d Telegram ] || [ -d telegram ]; then
            echo -n "  Would you delete the telegram folder? [y/n] ";
            read m;
            if echo $m | grep "^[yYsS]" >>/dev/null 2>/dev/null; then
                rm -rf telegram;
                rm -rf Telegram;
            fi
        fi
    fi
    echo "  Ending...\n  Thank you to have used Simple Telegram Installer.\n\n\n";
    ;;
    *)
        echo "  Okay, see you!";
        ;;
esac
