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

" Coc completion and others
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Snippets
Plug 'honza/vim-snippets'
" Commenting
Plug 'scrooloose/nerdcommenter'
" Syntax highlight
Plug 'sheerun/vim-polyglot'
" Git integration
Plug 'tpope/vim-fugitive'
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Sync Tmux and Nvim line
Plug 'edkolev/tmuxline.vim'
" Starting page
Plug 'mhinz/vim-startify'
" Tabular
Plug 'godlygeek/tabular'
" Cheat.sh
Plug 'dbeniamine/cheat.sh-vim'
" Devicons
Plug 'ryanoasis/vim-devicons'
" Surounding brackets
Plug 'tpope/vim-surround'
" UndoTreee
Plug 'mbbill/undotree'
" Indentation lines
Plug 'Yggdroot/indentline'
" Color schemes
Plug 'arcticicestudio/nord-vim'
Plug 'lifepillar/vim-solarized8'

call plug#end()

" --------------------------------------------------
" PUGINS configuration
" --------------------------------------------------

" Color scheme
colorscheme solarized8
set background=light

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
      \ '~/Developer/Work/CEZ/',
      \ '~/Developer/Work/CEZ/Portaly/Sharedesk/sharedesk-fe',
      \ '~/Developer/Work/CEZ/Infra/ServiceCatalog/service-portal-fe',
      \ '~/Developer/Work/CEZ/Digihub/IoT Dashboard/iot-dashboard-fe',
      \]

" Recomended by coc
set nobackup
set nowritebackup

" CoC plugins
"   List of available extensions:
"     https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-git',
      \ 'coc-css',
      \ 'coc-cssmodules',
      \ 'coc-swagger',
      \ 'coc-lists',
      \ 'coc-html',
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-prettier',
      \ 'coc-explorer',
      \ 'coc-highlight',
      \ 'coc-java',
      \ 'coc-markdownlint',
      \ 'coc-python',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-sql',
      \ 'coc-fzf-preview',
      \ 'coc-xml',
      \ 'coc-yaml',
      \ 'coc-yank',
      \ 'coc-jest',
      \ 'coc-emmet',
      \ 'coc-terminal',
      \ '@yaegassy/coc-ansible'
      \]


"Coc configuration
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" Use if you want to have colorfull FZF preview
let g:fzf_preview_command = 'bat --theme="Solarized (light)" --color=always --plain {-1}'

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

" " Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd :CocCommand fzf-preview.CocDefinition<cr>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr :CocCommand fzf-preview.CocReferences<cr>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Use <C-l> for trigger snippet expand.
imap <c-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <c-j> <Plug>(coc-snippets-select)
" Remap keys for applying codeAction to the current buffer.
nmap <space>a <Plug>(coc-codeaction)

" Format prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <leader>f  :CocCommand prettier.formatFile<CR>

" Open coc explorer
nmap <space>e :CocCommand explorer<CR>

" Run tests
nmap <space>t :CocCommand jest.fileTest<CR>
nmap <space>ta :CocCommand jest.projectTest<CR>

" Open FZF-preview
nmap <space>o :CocCommand fzf-preview.ProjectFiles<cr>
nmap <space>b :CocCommand fzf-preview.Buffers<cr>
nmap <space>d :CocCommand fzf-preview.CocDiagnostics<cr>

" CocList
nnoremap <silent><nowait> <space>c  :<C-u>CocList<cr>
nnoremap <silent><nowait> <space>p  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>l  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -A snippets<cr>
nnoremap <silent><nowait> <space>y  :<C-u>CocList -A --normal yank<cr>

" Git commands
nnoremap <space>g  :<C-u>Git<cr>
nnoremap <space>gp  :<C-u>Git push<cr>
nnoremap <space>gc  :<C-u>Git checkout 
nnoremap <silent><nowait> <leader>gi  :<C-u>CocCommand git.chunkInfo<cr>
nnoremap <silent><nowait> <leader>gr  :<C-u>CocCommand git.chunkUndo<cr>
nnoremap <silent><nowait> <leader>gs  :<C-u>CocCommand git.chunkStage<cr>

" Colors
nmap <leader>pc :call CocAction('pickColor')<CR>
nmap <leader>pcp :call CocAction('colorPresentation')<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Preview of symbol
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

" Show current file in Chrome. Works only in MacOS. Used for Markdown preview.
nmap <leader>mp :!open -a "Google Chrome.app" %<cr>

" Show Undotree
nnoremap <silent><nowait> <space>u :Und (light)"otreeToggle<CR>
