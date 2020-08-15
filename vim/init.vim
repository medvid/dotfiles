if &compatible
  set nocompatible
endif

" Load external plugins
if exists('*minpac#init')
  " minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Additional plugins here.
  call minpac#add('tpope/vim-sensible')
  call minpac#add('scrooloose/nerdtree')
  call minpac#add('tomasr/molokai')
  call minpac#add('altercation/vim-colors-solarized')
  call minpac#add('gruvbox-community/gruvbox')
  call minpac#add('ctrlpvim/ctrlp.vim')
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('mbbill/undotree')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('bagrat/vim-buffet')
  call minpac#add('mattn/webapi-vim')
  call minpac#add('mattn/vim-gist')
endif

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()

" Disable startup message
set shortmess+=atI

set number
set wildmenu
set wildmode=longest:full,full

set list listchars=tab:>-,trail:·

" Insert space characters whenever the tab key is pressed
set expandtab

" Set the number of space characters that will be inserted when the tab key is pressed
set tabstop=4

" Set the number of space characters inserted for indentation
set shiftwidth=4


" Disable automatic comment insertion
" https://vi.stackexchange.com/a/17739
autocmd BufEnter * set fo-=c fo-=r fo-=o

" Set colorscheme
if $TERM == 'linux'
  let g:gruvbox_termcolors=16
  colorscheme gruvbox
else
  set t_Co=256
  if filereadable('/etc/exherbo-release')
    set background=dark
  else
    set background=light
  endif
  colorscheme solarized
endif

" Set keyboard mappings
silent! nnoremap <F2> :CtrlPBuffer<CR>
silent! nnoremap <F3> :NERDTreeFind<CR>
silent! nnoremap <F4> :NERDTreeToggle<CR>
let g:NERDTreeMapActivateNode="<F3>"
silent! nnoremap <S-u> :UndotreeToggle<CR>

" Configure plugins
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

" https://stackoverflow.com/questions/5601749/how-to-filter-out-files-by-extension-in-nerdtree
let NERDTreeIgnore = ['\.pyc$', '\.o$']
