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

" Jenkinsfiles are groovy type
autocmd BufRead,BufNewFile Jenkinsfile* set filetype=groovy

" Set mapleader to comma
let mapleader = ','

" --------------------------------------------------
" PUGINS
" --------------------------------------------------

call plug#begin('~/.vim/plugged')

  " Telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

  " LSP
  Plug 'j-hui/fidget.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'

  " Formatter 
  Plug 'mhartington/formatter.nvim'

  " Color schemes
  Plug 'dracula/vim', { 'as': 'dracula' }
  " Git integration with gitsigns
  Plug 'tpope/vim-fugitive'
  Plug 'lewis6991/gitsigns.nvim'
  " Lualine is a fancy and blazingly fast statusbar with devicons
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  " Tmux navigation
  Plug 'christoomey/vim-tmux-navigator'

  " ------- Optional --------
  " UndoTreee
  Plug 'mbbill/undotree'

call plug#end()

" --------------------------------------------------
" PUGINS configuration
" --------------------------------------------------

" Transparent background color
let g:dracula_colorterm = 0

" Color scheme
colorscheme dracula
set background=dark

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

" Show current file in Chrome. Works only in MacOS. Used for Markdown preview.
nmap <leader>mp :!open -a "Google Chrome.app" %<cr>

" Git commands
nnoremap <space>g   :<C-u>Git<cr>
nnoremap <leader>gp  :<C-u>Git push<cr>
nnoremap <leader>gc  :<C-u>Git checkout

" Show Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" Tmux mapping
let g:tmux_navigator_no_mappings = 1
noremap <silent> <C-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <C-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <C-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <C-l> :<C-U>TmuxNavigateRight<cr>

" Telescope mapping
nnoremap <space>o  <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>of <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>og <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>ob <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>oh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>

" Formatter
nnoremap <silent> <leader>f :Format<CR>
nnoremap <silent> <leader>F :FormatWrite<CR>


lua<<EOF
  --  Enable LuaLine
  require('lualine').setup { }

  --  Enable Fidget
  require("fidget").setup { }

  require('plugins.lsp')
  require('plugins.formatter')
  require('plugins.gitsigns')

  -- Leave buffer after select
  local autocmd = vim.api.nvim_create_autocmd
  autocmd({ "BufLeave" }, { pattern = { "*" }, command = "if &buftype == 'quickfix'|q|endif" })
EOF
