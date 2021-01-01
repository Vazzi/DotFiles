set nocompatible

set hidden " Required to keep multiple buffers open multiple buffers
filetype off
syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

set conceallevel=0 " To see `` in markdown files

" To use mouse
set mouse=a

" Set backup directory
set backupdir=~/.local/share/nvim/swap

" Reload file if it was changed
set autoread

" Set backspace behavior
set backspace=indent,eol,start

" Indentation
set smartindent

" Tabs
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

" Make files should use tabs instead of spaces
autocmd FileType make setlocal noexpandtab

" Set mapleader to comma
let mapleader = ','

" Cursor
set cursorline

" Searching
set incsearch
set ignorecase
set smartcase

" Show vertical line on 120 column
set colorcolumn=121

" Always show the bar on right (sign column)
set signcolumn=yes

" Display ruler on the right side of the status line at the bottom of the window
set ruler

" Set relative numbers with current line number on cursor line
set relativenumber
set number

" Switch to absolute numbers in Insert mode
autocmd InsertEnter * set number norelativenumber
" Switch back to relative numbers in Normal mode
autocmd InsertLeave * set number relativenumber

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
" Keys helper
Plug 'liuchengxu/vim-which-key'
" Starting page
Plug 'mhinz/vim-startify'
" Devicons
Plug 'ryanoasis/vim-devicons'
" Color schemes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'reedes/vim-colors-pencil'

call plug#end()

" --------------------------------------------------
" PUGINS configuration
" --------------------------------------------------

" Color scheme
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark='medium'

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

" Recomended by coc
set nobackup
set nowritebackup

" CoC plugins
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-git',
      \ 'coc-css',
      \ 'coc-cssmodules',
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
      \ 'coc-stylelintplus',
      \ 'coc-stylelint',
      \ 'coc-snippets',
      \ 'coc-sql',
      \ 'coc-fzf-preview',
      \ 'coc-xml',
      \ 'coc-yaml',
      \ 'coc-yank',
      \ 'coc-jest'
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
" let g:fzf_preview_command = 'bat --theme=gruvbox --color=always --plain {-1}'

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
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Use <C-l> for trigger snippet expand.
imap <c-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <c-j> <Plug>(coc-snippets-select)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Format prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <leader>f  :CocCommand prettier.formatFile<CR>
nmap <leader>fe  :CocCommand eslint.executeAutofix<CR>

" Open coc explorer
nmap <space>e :CocCommand explorer<CR>

" Open FZF
nmap <space>p :CocCommand fzf-preview.ProjectFiles<cr>
nmap <leader>b :CocCommand fzf-preview.Buffers<cr>
nmap <leader>gs :CocCommand fzf-preview.GitStatus<cr>
nmap <leader>ga :CocCommand fzf-preview.GitActions<cr>
nmap <leader>ff :Files<cr>
nmap <leader>ag :Ag<cr>

" CocList
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>

" Colors
nmap <leader>pc :call CocAction('pickColor')<CR>
nmap <leader>pcp :call CocAction('colorPresentation')<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Show yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" Which key configuration
nnoremap <silent> <space> :WhichKey '<Space>'<CR>
nnoremap <silent> <leader> :WhichKey '<leader>'<CR>

" By default timeoutlen is 1000 ms
set timeoutlen=200
