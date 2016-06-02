#!/bin/sh
#simple telegram installer

if [ $# -eq 1 ]; then
    if echo $1 | egrep '^(--manual|-m|--auto|-a)$' >>/dev/null 2>/dev/null; then
        PAR="$1";
        FILE="null";
    else
        PAR="null";
        FILE="$1";
    fi
else
    PAR="$1";
    FILE="$2";
fi
bs=$(basename "$0");
dir=/usr/local/bin;
clear;

echo "\n******************************************************";
echo "\n  Welcome into Simple Telegram Installer";
echo "  This script will help you to install Telegram for\n  Linux easily. For more details about installation modes,\n  please refer to README.md file or\n  https://github.com/alexandercerutti/Simple-Telegram-Installer.\n  Thank you.\n"
#using /bin/echo to not use Dash's echo command. This lets me style the text
/bin/echo -e "  To link a file, abort this actual session by answering\n  'no' (n) to the following question and then pass a filename or path to the script\n  like this:\n\n\t$ \e[1m./installtelegram.sh --auto yourfile.tar.xz.\e[0m";
echo "\n******************************************************\n";
echo -n "  Are you ready to begin the installation? The next step\n  will depend by arguments. [y/n] >> ";
read m;

case $PAR in
    --auto|-a)
        # Seeks for sources sequentially and automatically
        if [ ! -z "$FILE" ] && [ -f $FILE ]; then
            echo -n "  STI will install telegram from the pointed archive.\n"
            METHOD="args";
#        elif [ -f telegram.tar.xz ]; then
#            echo "\n  telegram.tar.xz has been found in the script folder.\n  STI will install from this source."
#            FILE=telegram.tar.xz;
#            METHOD="file";
        elif [ -d telegram ] || [ -d Telegram ]; then
            echo "\n  telegram folder has been found in the script folder.\n  STI will install from this source."
            METHOD="folder";
        else
            echo "\n  STI will provide to download telegram. Please, make sure to be connected to internet."
            METHOD="dw"
        fi
        ;;
    --manual|-m)
        # Let's choose the source!
        if [ ! -z "$FILE" ] && [ -f $FILE ]; then
            echo -n "  STI will install telegram from the pointed archive.\n"
            METHOD="args";
        else
            echo -n "  You have chosen to check manual ways to install Telegram.\n  Write the name written in brackets to choose.\n  You can also abort by typing \"abort\"\n";
            echo "  - Specify path to an archive o the archive name itself. (args)"
#            if [ -f telegram.tar.xz ]; then
#                echo "  - Install from archive in script directory. (file)"
#            fi
        ### *)
            if [ -d telegram ] || [ -d Telegram ]; then
                echo "  - Install from extracted folder in script directory. (folder)"
            fi
            if dpkg -l | grep snapd >>/dev/null 2>/dev/null; then
                echo "  - Download the last version from snap. (snap)"
            fi
                echo "  - Download the last version from the web. (dw)"
            echo -n ">> ";
            read METHOD;
        fi
        ;;
    *)
        # checks the folder and the download.
        if [ ! -z "$FILE" ] && [ -f $FILE ]; then
            echo -n "  STI will install telegram from the pointed archive.\n"
            METHOD="args";
        else
            if [ -d telegram ] || [ -d Telegram ]; then
                METHOD="folder";
            else
                METHOD="dw";
            fi
        fi
        ;;
esac
case $m in
    [yY]|[sS])
    # Downloading or seeking for the the file / folder
        case $METHOD in
            args)

                # somewhere in your pc
                # checks if $FILE len is gt 0, if the file exists and its integrity: it must be a tar.xz.
                if [ ! -z "$FILE" ] && [ -f $FILE ] && tar tf $FILE >>/dev/null 2>/dev/null; then
                    tar xfJ $FILE;
                else
                    # if $FILE was not filled by script args (automatically "null"), printed phrases must be different;
                    if [ "$FILE" = "null" ]; then
                        echo -n "  After the input, the script will be rebooted. To abort, type: 'abort'.\n";
                        echo -n "  Please, insert here file name and/or its path. Else, abort. >> ";

                    else
                        echo -n "  !!! File not found or unreachable. Please, insert file name and/or its path. The script will be rebooted. Write \"abort\" to abort. >> ";
                    fi
                    read FILE;
                    if [ "$FILE" = "abort" ] || [ -z "$FILE" ]; then
                        echo -n "\nAborted.\n";
                        exit;
                    else
                        ./$bs --auto $FILE
                        exit;
                    fi;
                fi
            ;;
#            file)
                # already downloaded
                # control if telegram folder already existing and removing it.
#                if [ -d "$dir/telegram" ]; then
#                    rm -rf $dir/telegram;
#                fi
#                if [ -f telegram.tar.xz ]; then
#                    tar xfJ telegram.tar.xz;
#                else
#                    echo "  telegram.tar.xz archive not found or unreachable. The program will be aborted."
#                    exit;
#                fi
#            ;;
            folder)
                if [ ! -d telegram ] && [ ! -d Telegram ]; then
                    echo "  Telegram and telegram folder not found. The program will be aborted."
                    exit;
                fi
            ;;
            snap)
            if dpkg -l | grep snapd >>/dev/null 2>/dev/null; then
                sudo snap install telegram-sergiusens
            else
                echo "  Snap is not installed. The program will be aborted".
                exit;
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
                echo -n "  Would you delete the specified or downloaded archive (telegram.tar.xz)? [y/n] ";
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
        echo "\n  Thank you to have used Simple Telegram Installer.\n\n\n";
        ;;
    *)
        echo "  Okay, see you!";
        ;;
esac
