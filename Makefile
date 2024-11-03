vimfiles:
	wget -q https://github.com/tpope/vim-commentary/raw/master/plugin/commentary.vim -O dot_vim/plugin/commentary.vim
	wget -q https://github.com/tpope/vim-sensible/raw/master/plugin/sensible.vim -O dot_vim/plugin/sensible.vim
	wget -q https://github.com/tpope/vim-vinegar/raw/master/plugin/vinegar.vim -O dot_vim/plugin/vinegar.vim
	wget -q https://github.com/itchyny/lightline.vim/raw/master/plugin/lightline.vim -O dot_vim/plugin/lightline.vim
	wget -q https://github.com/itchyny/lightline.vim/raw/master/autoload/lightline.vim -O dot_vim/autoload/lightline.vim
	wget -q https://github.com/itchyny/lightline.vim/raw/master/autoload/lightline/colorscheme.vim -O dot_vim/autoload/lightline/colorscheme.vim
	wget -q https://github.com/itchyny/lightline.vim/raw/master/autoload/lightline/colortable.vim -O dot_vim/autoload/lightline/colortable.vim
	wget -q https://github.com/itchyny/lightline.vim/raw/master/autoload/lightline/tab.vim -O dot_vim/autoload/lightline/tab.vim
	wget -q https://github.com/itchyny/lightline.vim/raw/master/autoload/lightline/colorscheme/default.vim -O dot_vim/autoload/lightline/colorscheme/default.vim
	wget -q https://github.com/itchyny/lightline.vim/raw/master/autoload/lightline/colorscheme/powerline.vim -O dot_vim/autoload/lightline/colorscheme/powerline.vim
	wget -q https://github.com/tomasr/molokai/raw/master/colors/molokai.vim -O dot_vim/colors/molokai.vim

zimfw:
	wget -q https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh -I dot_zim/zimfw.zsh

.PHONY: vimfiles zimfw
