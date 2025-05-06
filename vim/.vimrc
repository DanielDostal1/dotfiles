" Line numbers
set number
set relativenumber

" Tabs and indentation
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

" Wrapping
set nowrap

" Swap and backup files
set noswapfile
set nobackup
" set undodir=~/.vim/undodir
" set undofile

" Search settings
set ignorecase
set nohlsearch
set incsearch

" Terminal colors
set termguicolors

" Scrolling and signs
set scrolloff=8
set signcolumn=yes
set isfname+=@-@

" Split behavior
set splitright

" Set leader key
let mapleader = " "

" Disable spacebar default behavior in normal and visual mode
nnoremap <silent> <Space> <Nop>
vnoremap <silent> <Space> <Nop>

" Disable <C-M> as enter (C-M is the same as Enter, so this will effectively disable Enter)
nnoremap <silent> <C-M> <Nop>

" Move selected lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep cursor at position when appending bottom line
nnoremap J mzJ`z

" Keep cursor in the middle during half page jumping
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Keep cursor in the middle during search
nnoremap n nzzzv
nnoremap N Nzzzv

" Yank into system clipboard (requires +clipboard Vim build)
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" Paste from system clipboard
nnoremap <leader>pp "+p
vnoremap <leader>pp "+p
nnoremap <leader>PP "+P

" Delete into void register
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap x "_x

" Rename all instances of a word
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Window management
nnoremap <leader>v <C-w>v
nnoremap <leader>h <C-w>s
nnoremap <leader>se <C-w>=

" Resize with arrows
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

" Tabs
nnoremap <leader>to :tabnew<CR>
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tp :tabp<CR>

" Toggle line wrapping
nnoremap <leader>lw :set wrap!<CR>

" Stay in indent mode
vnoremap < <gv
vnoremap > >gv
