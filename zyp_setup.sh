#!/usr/bin/env bash

bold="\e[1;36m"
close="\e[0m"

function inscursor {
cd ~/Downloads
git clone https://github.com/douglascomim/MacOSMOD.git

if [ ! -d ~/.icons ]; then
mkdir ~/.icons
fi

mv ~/Downloads/MacOSMOD/ ~/.icons/
cd
}

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

function inspyenv {
# install pyenv
if [ ! -d ~/.pyenv ]; then

sudo zypper install gcc automake bzip2 libbz2-devel xz xz-devel openssl-devel ncurses-devel readline-devel zlib-devel tk-devel libffi-devel sqlite3-devel

curl https://pyenv.run | bash
echo "" >> ~/.zshrc
echo "# pyenv configuration" >> ~/.zshrc
echo 'export PATH="/home/quinton/.pyenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
fi
}

function zypinstall {
# apt apps that need to be installed
AppList=(tlp tlp-rdw tree neofetch neovim zsh git curl powertop wget)

for app in "${AppList[@]}"
do
echo "Installing ${app}"
sudo zypper install -y $app
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
    statements=("Zypper Setup Commands:" "${bold}inscursor${close} -- Installs macosx cursor theme" "${bold}insmenlo${close} -- installs menlo font" "${bold}zypinstall${close} -- Installs full opensuse setup (pyenv, zsh, etc.)" "${bold}inspyenv${close} -- Installs Pyenv and adds to .zshrc" "${bold}zshcustom${close} -- Install all the zsh autosuggestion and syntax highlighting")
    for items in "${statements[@]}"
    do
    echo -e $items
    done
    echo ""
}

"$@"
