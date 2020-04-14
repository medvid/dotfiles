#!/usr/bin/env bash

LINK="ln -nsvrf"
COPY="cp -rv"
REMOVE="rm -rf"
MOVE="mv -v"

# suffix for backups
DATE=`date +%Y-%m-%d-%H-%M-%S`

red='\e[0;31m'
green='\e[0;32m'
reset='\e[0m'

message() {
  msg=$1

  echo -e "${green}$msg${reset}"
}

error() {
  msg=$1

  echo -e "${red}$msg${reset}"
}

mkdir_parent() {
  dest=$1

  mkdir -p $(dirname $dest)
}

remove_guarded() {
  dest=$1
  dest_backup=$dest-$DATE

  [[ $skip -eq 1 ]] && return 1

  if [[ -h $dest ]] || [[ $force -eq 1 ]]
  then
    echo "Removing $1..."
    $REMOVE $dest
  fi

  while [[ -e $dest ]]
  do
    read -p "File or directory $dest exists, [b]ackup/[r]emove/[s]kip? " -n 1 -r
    echo
    case $REPLY in
      [bB]|'' )
        $MOVE $dest $dest_backup
        ;;
      [rRdD] )
        echo "Removing $1..."
        $REMOVE $dest
        ;;
      [sScCnN] )
        echo "Skipping installation..."
        return 1
        ;;
      * )
        echo "Invalid option"
        ;;
    esac
  done
}

install_symlink() {
  link_dest=${2:-.$1}
  link_src=$ROOTDIR/$1

  remove_guarded $link_dest
  [[ $? -eq 1 ]] && return 1

  mkdir_parent $link_dest

  $LINK $link_src $link_dest
}

install_copy() {
  copy_dest=.$1
  copy_src=$ROOTDIR/$1

  mkdir_parent $copy_dest

  $COPY $copy_src $copy_dest
}

# defaults
skip=0
force=0

# parse options
for opt do
  optarg=`expr "x$opt" : 'x[^=]*=\(.*\)'`
  case "$opt" in
  -s|--skip)
    skip=1
    ;;
  --no-skip)
    skip=0
    ;;
  -f|--force)
    force=1
    ;;
  --no-force)
    force=0
    ;;
  esac
done

pushd `dirname $0` > /dev/null
ROOTDIR=`pwd`
popd > /dev/null

pushd $HOME > /dev/null

message "bin"
install_symlink bin bin

message "git"
install_symlink gitconfig

message "mpv"
install_symlink config/mpv/mpv.conf
install_symlink config/mpv/input.conf

message "tmux"
install_symlink tmux.conf

message "vim"
install_symlink vim
$LINK $HOME/.vim $HOME/.config/nvim

message "zsh"
install_symlink zim
install_symlink zimrc
install_symlink zlogin
install_symlink zshenv
install_symlink zshrc
if ! [[ -f ~/.zim/zimfw.zsh ]]; then
    curl -f -L https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh -o ~/.zim/zimfw.zsh
    zsh -c "source ~/.zim/zimfw.zsh install"
    echo "*.zwc" > "$ROOTDIR/.git/modules/zim/modules/zsh-autosuggestions/info/exclude"
fi

popd  > /dev/null

# vim: ts=2 et
