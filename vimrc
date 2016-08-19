" Miscellaneous settings {{{
" Pick up hidden tag files
set tags+=.tags
set autoindent
set tabstop=4
set noexpandtab
set shiftwidth=4
set nocompatible
set backspace=2
set number
set encoding=utf-8

" Highlight the current line.
set cursorline

" Turn on tab completion for commands
set wildmode=longest,list,full
set wildmenu

" Dynamic searching
set incsearch

" Highlight when searching
set hlsearch

" Folding
set foldlevelstart=100
set foldmethod=indent

" Allows variable fold settings for specific files
set modelines=1

" Column on the 81st line - helps for observing style conventions
au FileType python,java,c,vim set colorcolumn=81

" Enable syntax highlighting
syntax enable

set background=light
colorscheme desertEx

" When editing a file, always jump to the last known cursor position.  Don't do
" it when the position is invalid or when inside an event handler (happens when
" dropping a file on gvim). Also don't do it when the mark is in the first line.
" that is the default position when opening a file.
autocmd BufReadPost *
   \ if line("'\"") > 1 && line("'\"") <= line("$") |
   \   exe "normal! g`\"" |
   \ endif

"Fix up the ctags file on writes. This only appends to the file, so it's quick
autocmd BufWritePost *
      \ if filereadable('.tags') |
      \   call system('ctags -f .tags -a '.expand('%')) |
      \ endif
" }}}
" Key Mapping {{{
inoremap jj <Esc>

" Ctrl-left, Ctrl-right cycle through tabs. You need to configure your
" terminal to send the <ESC>B and <ESC>F escape sequences.
nnoremap <silent> <ESC>B :tabprevious<CR>
nnoremap <silent> <ESC>F :tabnext<CR>

" Lowercase t toggles the tagbar in normal mode
nnoremap <silent> t :Tagbar<CR>

" Hitting enter jumps to the first tag found, if there IS one.
nnoremap <silent><Return> :silent! execute "normal \<lt>c-]>" <CR>
nnoremap <silent><bs> :silent! execute "normal \<lt>c-t>" <CR>

" Ctrl-hjkl resizes windows
nnoremap <silent><C-j> :resize +3<CR>
nnoremap <silent><C-k> :resize -3<CR>
nnoremap <silent><C-h> :vertical resize -3<CR>
nnoremap <silent><C-l> :vertical resize +3<CR>

" Use arrow keys to navigate window splits
nnoremap <silent> <Right> :wincmd l <CR>
nnoremap <silent> <Left> :wincmd h <CR>
noremap <silent> <Up> :wincmd k <CR>
noremap <silent> <Down> :wincmd j <CR>

" < and > move around function arguments.
nnoremap <silent> > :SidewaysRight <CR>
nnoremap <silent> < :SidewaysLeft <CR>

let mapleader=","

" Quickly edit vimrc
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>

" Quickly source "vimrc
nnoremap <silent> <leader>lv :source $MYVIMRC<cr>

" Open Nerdtree
nnoremap <silent> <leader>n :NERDTree<cr>

" Wrap word in quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" Toggle between things like True/False with Radev's switch plugin
nnoremap <silent> <leader>s :Switch<cr>

" Not sure what this does
" nnoremap <leader>s :mksession<CR>

" Move visually (instead of by line number)
nnoremap j gj
nnoremap k gk

" Mark navigation mapping
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "mm",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "m<Space>",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  ")",
        \ 'GotoPrevLineByPos'  :  "(",
        \ 'GotoNextSpotByPos'  :  "]`",
        \ 'GotoPrevSpotByPos'  :  "[`",
        \ 'GotoNextMarker'     :  "]-",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListBufferMarks'    :  "m/",
        \ 'ListBufferMarkers'  :  "m?"
        \ }

" Use space to eliminate highlighting after search
nnoremap <silent> <Space> :noh \| :lcl <CR>

" }}}
" Highlighting {{{
" Highlight extra white space with green and overlength lines with red.
" highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
highlight ExtraWhitespace ctermbg=darkgreen ctermfg=white guibg=#FFD9D9

" Adjust the definition of what it means to be trailing white space
" Make it so that when you're writing, the whitespace at the end is
" not considered trailing.
" match OverLength /\%>80v.\+/

function! AdjustWhitespaceEnter()
	match ExtraWhitespace /\s\+\%#\@<!$/
	" call matchadd('OverLength', '\%>80v.\+')
endfunction

function! AdjustWhitespaceExit()
	match ExtraWhitespace /\s\+$/
	" call matchadd('OverLength', '\%>80v.\+')
endfunction

au InsertEnter * call AdjustWhitespaceEnter()
au InsertLeave * call AdjustWhitespaceExit()

" }}}
" Plugin Settings {{{
" vim-autotag {{{
" Have vim-autotag look for a .tags file instead of a tags file.
let g:autotagTagsFile=".tags"
" }}}

" NerdTree {{{
" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
	if exists("t:NERDTreeBufName")
		if bufwinnr(t:NERDTreeBufName) != -1
			if winnr("$") == 1
				q
			endif
		endif
	endif
endfunction

"Function to close vim if Nerd Tree is the only thing left open
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
" }}}

" textwidth {{{
" For all text files set 'textwidth' to 80 characters.
au FileType text setlocal textwidth=80
au FileType python setlocal textwidth=80
" }}}

" formatoptions {{{
" Autoformat text
au FileType text setlocal formatoptions+=an

au FileType python setlocal formatoptions=qrjcb
" }}}

" UltiSnips {{{
" Trigger configuration.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}

" Airline {{{
let g:airline_theme="xtermlight"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Necessary for airline
set laststatus=2
" }}}

" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height=3
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler = "g++"
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"
" }}}

" YouCompleteMe {{{
" Automatically close the function preview window
let g:ycm_autoclose_preview_window_after_completion = 1

" allow ycm to play nicely with syntastic
let g:ycm_show_diagnostics_ui = 0
" }}}

" vim-notes {{{
let g:notes_directories = ['~/google_drive/notes']
" }}}

" Vundle {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()

" Cool statusbar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Plugin to generate bash prompt line
Bundle 'edkolev/promptline.vim'

" Automatic ctags cleanup on file writes. This plugin searches parent
" directories for any .tags files and removes stale tags.
Plugin 'craigemery/vim-autotag'

" Scroll through color schemes
Plugin 'ScrollColors'

" Syntax checking
Plugin 'scrooloose/syntastic'

" Convenient completion for XML/HTML
Plugin 'othree/xml.vim'

" Press t to toggle tagbar.
Plugin 'majutsushi/tagbar'

" gc to toggle comments
Plugin 'tomtom/tcomment_vim'

" Browse the file system
Plugin 'scrooloose/nerdtree'

" Track the engine.
Plugin 'SirVer/ultisnips'

" Fuzzy search
Plugin 'kien/ctrlp.vim'

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Autocompletion
Plugin 'Valloric/YouCompleteMe'

" Notes
Plugin 'xolox/vim-notes'

" Vim misc required by vim notes
Plugin 'xolox/vim-misc'

" Git plugin
Plugin 'tpope/vim-fugitive'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" Skeltons for common filetypes
Plugin 'noahfrederick/vim-skeleton'

" Toggle between things like True/False
Plugin 'AndrewRadev/switch.vim'

" Navigate markers easily
Plugin 'kshenoy/vim-signature'

" PEP8 indentation for python
Plugin 'hynek/vim-python-pep8-indent'

" Better handling of (), [], etc
Plugin 'jiangmiao/auto-pairs'

" Move function arguments around easily.
Plugin 'AndrewRadev/sideways.vim'

" All of your Plugins must be added before the following line
call vundle#end()

filetype plugin indent on
" }}}
" }}}
" vim:foldmethod=marker:foldlevel=0
