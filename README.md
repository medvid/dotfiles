# dotfiles

    cd $HOME && sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply medvid


## macOS

    sudo port selfupdate
    sudo port install neovim nodejs16 npm8 fd jq ripgrep tmux
    Install dot_local/share/fonts/Ubuntu Mono*.ttf using FontBook

## Ubuntu

    sudo apt update
    sudo apt install curl fd-find git jq ripgrep tmux vim zsh
    chsh -s /bin/zsh
    curl -fsSLO https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz
    sudo tar -C /opt -xvf nvim-linux64.tar.gz
    rm nvim-linux64.tar.gz
    sudo mv /opt/nvim-linux64 /opt/nvim
    git clone https://github.com/0xcomposure/monokai-gnome-terminal
    cd monokai-gnome-terminal
    ./install.sh

## Fedora

    sudo dnf update
    sudo dnf install curl fd-find git jq ripgrep tmux vim zsh gcc-c++ libstdc++-devel neovim neovim-qt nodejs python3-pip
    sudo usermod --shell /bin/zsh $USER
    git clone https://github.com/0xcomposure/monokai-gnome-terminal
    cd monokai-gnome-terminal
    ./install.sh

## openSUSE

    sudo zypper refresh
    sudo zypper install curl git jq ripgrep tmux vim zsh gcc-c++ libstdc++-devel neovim nodejs python3-neovim
    sudo vim /etc/zshrc
    # comment out lines 66,67 (autoload -U compinit; compinit)
    systemctl --user daemon-reload
    systemctl --user enable ssh-agent
    systemctl --user start ssh-agent

## Windows

    Install Python3
    Install https://scoop.sh/
    scoop install neovim win32yank gcc rust nodejs
    Install dot_local/share/fonts/Caskaydia*.ttf

## Common

    sudo npm install -g neovim tree-sitter-cli
    python3 -m pip install pynvim
