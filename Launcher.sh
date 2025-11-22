#!/bin/bash
#Made with love by MrNugget (aka Fouta4XD)
#This was completely made in the notepad app, so expect bugs (I did my best)
#This is version 0.2 alpha

credits () {
  echo "-------Credits-------"
  echo "This shell script was made by MrNugget"
  echo "Ninecraft itself wasn't made by me but by many people,"
  echo "I only made this script to help people download it."
  echo "Click enter to come back."
  read key
  clear
  menu
}


DeskEntry () {
 cd
 cd Desktop
 clear
 echo "Are you on (1) Arm64/Arm or (2) X86/X86_64?"
 read arch2
 if [ $arch2 == 1 ]; then
   echo cd >> Ninecraft.sh
   echo cd Ninecraft >> Ninecraft.sh
   echo ./build-arm/ninecraft/ninecraft >> Ninecraft.sh
 else
   echo cd >> Ninecraft.sh
   echo cd Ninecraft >> Ninecraft.sh
   echo ./build-i686/ninecraft/ninecraft >> Ninecraft.sh
 fi
 chmod +x Ninecraft.sh
 
}

installSuccess () {
  echo "Ninecraft was completely installed, do you wish do have the app on your desktop?"
  echo "(y/n)"
  read entry
  if [ $entry == y ]; then
    DeskEntry
  else
    cd
    cd Ninecraft
    echo "Loading Ninecraft..." 
    ./build-arm/ninecraft/ninecraft
  fi
}

skipDep () {
  echo "-------Choose your architecture-------"
    echo "Your architecture is: $(uname -m), select the one in the list that matches it."
    echo "(1) Aarch64/ARM64 (2)ARM (3)x86_64 (4)x86"
    read architecture
if ! [ $architecture == 1 ] && ! [ $architecture == 2 ] && ! [ $architecture == 3 ] && ! [ $architecture == 4 ]; then
  clear
  skipDep
fi
clear
makeBuild
}

getApk () {
  clear
  echo "-------Ninecraft installer for Ubuntu/Debian-------"
  echo "Ninecraft was successfully downloaded! Download a mcpe v0.1.0 to v0.11.1 apk and provide the path to it."
  echo "Link to get the apk: https://archive.org/details/MCPEAlpha"
  read pathAPK
  echo "Input apk directory(path):"
  cd
  cd Ninecraft
  ./tools/extract.sh $pathAPK
  clear
  installSuccess
}

makeBuild () {
  if [ $architecture == 1 ] || [ $architecture == 2 ]; then
    git clone --recursive http://github.com/MCPI-Revival/Ninecraft.git
    mv Ninecraft /home/$USER
    cd
    cd Ninecraft
    make build-arm
  else
    git clone --recursive http://github.com/MCPI-Revival/Ninecraft.git
    mv Ninecraft /home/$USER
    cd
    cd Ninecraft
    make build-i686
 fi
 getApk
}


downloadDebUntu () {
  clear
  echo "-------Ninecraft Installer for linux-------"
  echo "Do you want to start the downloading process? (y/n)"
  read DebYes
if [ $DebYes == y ] || [ $DebYes == Y ]; then
 echo "Downloading compiling dependencies..."
if [ $OS == 1 ]; then
  if [ $architecture == 1 ]; then
    sudo dpkg --add-architecture armhf
    sudo apt update
    sudo apt install git make cmake gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf libopenal-dev:armhf libx11-dev:armhf libxrandr-dev:armhf libxinerama-dev:armhf libxcursor-dev:armhf libxi-dev:armhf libgl-dev:armhf zenity unzip python3-jinja2
    clear
    echo "Dependencies downloaded, downloading Ninecraft itself."
    makeBuild
  elif [ $architecture == 2 ]; then
    sudo apt update
    sudo apt install git make cmake gcc g++ libopenal-dev libx11-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev libgl-dev zenity unzip python3-jinja2
    clear
    echo "Dependencies downloaded, downloading Ninecraft itself."
    makeBuild  
  elif [ $architecture == 3 ]; then
    sudo dpkg --add-architecture i386
    sudo apt update
    sudo apt install git make cmake gcc g++ gcc-multilib g++-multilib libopenal-dev:i386 libx11-dev:i386 libxrandr-dev:i386 libxinerama-dev:i386 libxcursor-dev:i386 libxi-dev:i386 libgl-dev:i386 zenity unzip python3-jinja2
    clear
    echo "Dependencies downloaded, downloading Ninecraft itself."  
    makeBuild
  elif [ $architecture == 4 ]; then
    sudo apt update
    sudo apt install git make cmake gcc g++ libopenal-dev libx11-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev libgl-dev zenity unzip python3-jinja2
    clear
    echo "Dependencies downloaded, downloading Ninecraft itself."
    makeBuild
  fi  
fi
else
  clear
  menu
fi 
}

downloadArch () {
  clear
  echo "-------Ninecraft Installer for ArchLinux (Not officialy tested)-------"
  echo "Do you want to start the download process? (y/n)"
  read ArchYes
  if [ $ArchYes == y ] || [ $ArchYes == Y ]; then
  echo "Downloading compiling dependencies..."
  if [ $OS == 2]; then
    if [ $architecture == 2]; then
      sudo pacman -Syu
      sudo pacman -S git make cmake gcc openal libx11 libxrandr libxinerama libxcursor libxi libglvnd zenity unzip python-jinja
      clear
      echo "Dependencies downloaded, downloading Ninecraft itself."
      makeBuild
    elif [ $architecture == 3]; then
      sudo pacman -Syu
      sudo pacman -S git make cmake gcc gcc-multilib lib32-openal lib32-libx11 lib32-libxrandr lib32-libxinerama lib32-libxcursor lib32-libxi lib32-libglvnd zenity unzip python-jinja
      clear
      echo "Dependencies downloaded, downloading Ninecraft itself."
      makeBuild
    fi
  fi
  else
    clear
    menu
  fi 
}

chooseOS () {
echo "-------Select your linux distribution--------"
echo "(1) piOS/Debian/Ubuntu (2) ArchLinux/Arch-based"
read OS
clear
if [ $OS != "1" ] && [ $OS != "2" ]; then
    clear
    chooseOS
else
    echo "-------Choose your architecture-------"
    echo "Your architecture is: $(uname -m), select the one in the list that matches it."
    echo "(1) Aarch64/ARM64 (2)ARM (3)x86_64 (4)x86"
    read architecture
if ! [ $architecture == 1 ] && ! [ $architecture == 2 ] && ! [ $architecture == 3 ] && ! [ $architecture == 4 ]; then
  clear
  menu
fi
fi

if [ $OS ==  1 ]; then
  downloadDebUntu
else
  downloadArch
fi
}

#Asks user input
menu () {
echo "-------Ninecraft Launcher v0.2 alpha-------"
echo "(1) Install (2) Run (3) Advanced (4) Quit"
read menuChoice
if [ $menuChoice == 1 ]; then
  clear
  chooseOS
elif [ $menuChoice == 2 ]; then
  cd
  cd Ninecraft
  echo "Loading Ninecraft..." 
  if [ $architecture == 1 ] || [ $architecture == 2 ]; then
   ./build-arm/ninecraft/ninecraft
  else
   ./build-i686/ninecraft/ninecraft
  fi

elif [ $menuChoice == 3 ]; then
  clear
  echo "-------Advanced options-------"
  echo "(1) Skip dependencies and run straight to Ninecraft installation"
  echo "(2) Skip both dependencies downloading and file downloading + compiling"
  echo "(3) Create desktop entry"
  echo "(4) Credits"
  echo "(5) Quit to menu"
  read Advanced1
  if [ $Advanced1 == 1 ]; then
    clear
    skipDep
  elif [ $Advanced1 == 3 ]; then
    DeskEntry
    clear
    menu
  elif [ $Advanced1 == 2 ]; then
    clear
    getApk
  elif [ $Advanced1 == 4 ]; then
    clear
    credits
  else
   clear
   menu
fi

elif [ $menuChoice == 4 ]; then
  exit 1
 
else
  clear
  menu
fi
}

menu
