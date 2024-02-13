" Vim settings
set nocompatible               " Use Vim settings, not Vi
set backspace=indent,eol,start
 
" Appearance
syntax enable                  " Enable syntax highlighting
set number                     " Show line numbers
set cursorline                 " Highlight current line
set showmode                   " Show current mode (e.g., insert, command)
set ruler                      " Display the ruler
set colorcolumn=150            " Let's see when lines are too long
set completeopt="menu"         " Show a menu
set list                       " See spaces
 
" Indentation and formatting
set tabstop=4                  " Use 4 spaces for tab
set shiftwidth=4               " Use 4 spaces for indentation
set expandtab                  " Use spaces instead of tabs
set nowrap
 
" Color
colorscheme darkblue           " Good default
silent! colorscheme saturnite  " I usually have it, but not always

" Color for tmux, make sure tmux conf is also set
if !has('gui_running') && &term =~ '\%(screen\|tmux\)'
   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors              " For saturnite or others
 
" Search
set ignorecase                 " Ignore case when searching
set smartcase                  " Use case-sensitive search if query contains uppercase
 
" Split windows
set splitright                 " Split windows vertically to the right
set splitbelow                 " Split windows horizontally at the bottom
 
" mouse for vimspector
set mouse=a
 
" open in new buffer
" set switchbuf+=newtab
 
" vimspector
let g:vimspector_enable_mappings='HUMAN'
" YouCompleteMe
let g:ycm_server_keep_logfiles=1
let g:ycm_server_log_level='debug'
" default to /opt/llvm-10...
let g:ycm_clangd_binary_path='/opt/llvm-10/bin/clangd'
" ... but try using the system clangd
if filereadable('/etc/oracle-release')
              \ && executable('/usr/bin/clangd')
    let g:ycm_clangd_binary_path='/usr/bin/clangd'
endif
 
let g:ycm_clangd_args=[
                      \ '-background-index',
                      \ '-completion-style=bundled',
                      \ '-j=16',
                      \ '-header-insertion=iwyu',
                      \ '--query-driver=/usr/**/*,/opt/**/*',
                      \ '--suggest-missing-includes'
                      \ ]
let g:ycm_auto_trigger=1
let g:ycm_goto_buffer_command='split-or-existing-window'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_show_diagnostics_ui=1
let g:ycm_seed_identifiers_with_syntax=0
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_confirm_extra_conf=0
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_always_populate_location_list=1
let g:ycm_show_detailed_diag_in_popup=1
let g:ycm_update_diagnostics_in_insert_mode=1
let g:ycm_disable_tern=1
let g:ycm_max_diagnostics_to_display=100
let g:ycm_add_preview_to_completeopt = 'popup'
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_collect_identifiers_from_tags_files=1
 
" Mappings
 
" some basics - leader is, by default `\`
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>n :set invnumber<CR>
nnoremap <leader>z :set invwrap<CR>
nnoremap <leader>f :let @/='\<<C-R><C-W>\>'<CR>:set hlsearch<CR>
" ycm
nnoremap <leader>ygt :YcmCompleter GetType<CR>
nnoremap <leader>ygd :vertical YcmCompleter GoTo<CR>
nnoremap <leader>ygr :vertical YcmCompleter GoToReferences<CR>
nmap <leader>yf <Plug>(YCMFindSymbolInWorkspace)
nmap <leader>yfd <Plug>(YCMFindSymbolInDocument)
" fzf
nnoremap <leader>zf :GFiles!<CR>
 
" need to disable while we load plugins
filetype off
"Vundle plugins
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'puremourning/YouCompleteMe'
Plugin 'puremourning/vimspector'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" other internal plugins
" ...
call vundle#end()
filetype plugin indent on
 
" Commands
" add a command to be able to use git grep with fzf https://github.com/junegunn/fzf.vim?tab=readme-ov-file#example-git-grep-wrapper command! -bang -nargs=* GGrep
 \ call fzf#vim#grep(
 \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
 \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
 
nnoremap <leader>zG :GGrep<CR>
