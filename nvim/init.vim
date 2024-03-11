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
" Git integration
Plug 'tpope/vim-fugitive'
" Git signs
Plug 'lewis6991/gitsigns.nvim'
" Lualine is a fancy and blazingly fast statusbar
Plug 'nvim-lualine/lualine.nvim'
" DevIcons for lualine
Plug 'nvim-tree/nvim-web-devicons'

" ------- Optional --------
" Starting page
Plug 'mhinz/vim-startify'

" ------- I dont know --------
" Syntax highlight
" Plug 'sheerun/vim-polyglot'
" Commenting
" Plug 'scrooloose/nerdcommenter'
" Tabular
" Plug 'godlygeek/tabular'

call plug#end()

" --------------------------------------------------
" PUGINS configuration
" --------------------------------------------------

" Transparent background color
let g:dracula_colorterm = 0

" Color scheme
colorscheme dracula
set background=dark

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
     \]

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
nnoremap <space>g  :<C-u>Git<cr>
nnoremap <space>gp  :<C-u>Git push<cr>
nnoremap <space>gc  :<C-u>Git checkout

" Show Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" Tmux mapping
let g:tmux_navigator_no_mappings = 1
noremap <silent> <C-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <C-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <C-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <C-l> :<C-U>TmuxNavigateRight<cr>

" Enable LuaLine
lua<<EOF
  require('lualine').setup { }
  require('gitsigns').setup {
    on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
  }
EOF
