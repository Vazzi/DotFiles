syntax on
syntax enable
filetype off
set nocompatible
set hidden " Required to keep multiple buffers open multiple buffers
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set conceallevel=0 " To see `` in markdown files
set mouse=a
set backupdir=~/.local/share/nvim/swap
set autoread
set backspace=indent,eol,start
set smartindent
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set scrolloff=4
set nohlsearch
set cursorline
set colorcolumn=121 " Show vertical line on 120 column
set signcolumn=yes
set relativenumber
set nu

" Display ruler on the right side of the status line at the bottom of the window
set ruler

set incsearch
set ignorecase
set smartcase

" Make files should use tabs instead of spaces
autocmd FileType make setlocal noexpandtab

" Set mapleader to comma
let mapleader = ','

" --------------------------------------------------
" PUGINS
" --------------------------------------------------

call plug#begin('~/.vim/plugged')

" Tmux navigation
Plug 'christoomey/vim-tmux-navigator'
" Color schemes
Plug 'dracula/vim', { 'as': 'dracula' }
" UndoTreee
Plug 'mbbill/undotree'

" Commenting
Plug 'scrooloose/nerdcommenter'
" Syntax highlight
Plug 'sheerun/vim-polyglot'
" Git integration
Plug 'tpope/vim-fugitive'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Starting page
Plug 'mhinz/vim-startify'
" Tabular
Plug 'godlygeek/tabular'
" Devicons
Plug 'ryanoasis/vim-devicons'
" Surounding brackets
Plug 'tpope/vim-surround'
" Indentation lines
Plug 'Yggdroot/indentline'

call plug#end()

" --------------------------------------------------
" PUGINS configuration
" --------------------------------------------------

" Color scheme
colorscheme dracula
set background=dark

" Airline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" NERD Commenter configuration
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Startify config
let g:startify_change_to_vcs_root = 1
let s:startify_ascii_header = [
      \ ' /$$   /$$                     /$$    /$$ /$$$$$$ /$$      /$$',
      \ '| $$$ | $$                    | $$   | $$|_  $$_/| $$$    /$$$',
      \ '| $$$$| $$  /$$$$$$   /$$$$$$ | $$   | $$  | $$  | $$$$  /$$$$',
      \ '| $$ $$ $$ /$$__  $$ /$$__  $$|  $$ / $$/  | $$  | $$ $$/$$ $$',
      \ '| $$  $$$$| $$$$$$$$| $$  \ $$ \  $$ $$/   | $$  | $$  $$$| $$',
      \ '| $$\  $$$| $$_____/| $$  | $$  \  $$$/    | $$  | $$\  $ | $$',
      \ '| $$ \  $$|  $$$$$$$|  $$$$$$/   \  $/    /$$$$$$| $$ \/  | $$',
      \ '|__/  \__/ \_______/ \______/     \_/    |______/|__/     |__/',
      \ '',
      \]
let g:startify_custom_header = map(s:startify_ascii_header +
        \ startify#fortune#quote(), '"   ".v:val')
let g:startify_bookmarks = [
      \ '~/Developer/',
      \ '~/Developer/Typescript/',
      \ '~/Developer/Work/'
      \]

" Recomended by coc
set nobackup
set nowritebackup

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" --------------------------------------------------
" MAPPING
" --------------------------------------------------

" Bind copy to clipboard
map <leader>cp "+y

" Remove trailing spaces
nmap <leader><space> :%s/\s\+$<cr>

" Better indenting of code block
vnoremap < <gv
vnoremap > >gv

" Moving selected lines up or down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Reload config file
nmap <leader>r :source ~/.config/nvim/init.vim<CR>

" Git commands
nnoremap <space>g  :<C-u>Git<cr>
nnoremap <space>gp  :<C-u>Git push<cr>
nnoremap <space>gc  :<C-u>Git checkout 

" Show current file in Chrome. Works only in MacOS. Used for Markdown preview.
nmap <leader>mp :!open -a "Google Chrome.app" %<cr>

" Show Undotree
nnoremap <silent><nowait> <space>u :Und (light)"otreeToggle<CR>

" Tmux mapping
let g:tmux_navigator_no_mappings = 1
noremap <silent> <C-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <C-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <C-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <C-l> :<C-U>TmuxNavigateRight<cr>
