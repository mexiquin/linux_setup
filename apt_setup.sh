#!/usr/bin/env bash

bold="\e[1;36m"
close="\e[0m"

# install the san francisco fonts
function inssanfran {
cd ~/Downloads
git clone "https://github.com/AppleDesignResources/SanFranciscoFont.git"
if [ ! -d ~/.fonts ]; then
mkdir ~/.fonts
fi
mv ~/Downloads/SanFranciscoFont/ ~/.fonts
cd
}
# install the mac cursor to .icons
function inscursor {
cd ~/Downloads
git clone https://github.com/douglascomim/MacOSMOD.git

if [ ! -d ~/.icons ]; then
mkdir ~/.icons
fi

mv ~/Downloads/MacOSMOD/ ~/.icons/
cd
}

# install zsh plugins (zsh autosuggestions and zsh syntax highlighting
function zshcustom {
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo -e "Dont forget to add:\n${bold}zsh-syntax-highlighting zsh-autosuggestions${close}\nto zshrc"
}

function insmenlo {
cd ~/Downloads
git clone "https://github.com/abertsch/Menlo-for-Powerline.git"
if [ ! -d ~/.fonts ]; then
mkdir .fonts
fi
mv ~/Downloads/Menlo-for-Powerline/ ~/.fonts/
cd
}

# pyenv setup (install zsh first
function inspyenv {
# install pyenv
if [ ! -d ~/.pyenv ]; then
sudo apt install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
curl https://pyenv.run | bash
echo "" >> ~/.zshrc
echo "# pyenv configuration" >> ~/.zshrc
echo 'export PATH="/home/quinton/.pyenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
fi
}

# full debian-based linux setup
function debinstall {
# apt apps that need to be installed
AppList=(tlp tlp-rdw tree neofetch neovim zsh git curl powertop wget)

sudo apt update && sudo apt upgrade -y

for app in "${AppList[@]}"
do
echo "Installing ${app}"
sudo apt install $app -y
done

# change terminal colors with gogh
bash -c  "$(wget -qO- https://git.io/vQgMr)" 

# install oh my zsh
if [ ! -d ~/.oh-my-zsh ]; then
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
}

function help {
    echo ""
    statements=("Apt Setup Commands:" "${bold}inscursor${close} -- Installs macosx cursor theme" "${bold}insmenlo${close} -- installs menlo font" "${bold}debinstall${close} -- Installs full debian setup (pyenv, zsh, etc.)" "${bold}inspyenv${close} -- Installs Pyenv and adds to .zshrc" "${bold}zshcustom${close} -- Install all the zsh autosuggestion and syntax highlighting" "${bold}inssanfran${close} -- Install the San Francisco font")
    for items in "${statements[@]}"
    do
    echo -e $items
    done
    echo ""
}

"$@"
