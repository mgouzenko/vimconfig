" Miscellaneous settings {{{
" Pick up hidden tag files
set tags+=.tags
set autoindent
set tabstop=8
set softtabstop=4
set expandtab
set shiftwidth=4
set nocompatible
set backspace=2
set number
set relativenumber
set encoding=utf-8

" Set grep program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" Highlight the current line.
set cursorline

" Turn on tab completion for commands
set wildmode=longest,list,full
set wildmenu

" Dynamic searching
set incsearch

" Highlight when searching
set hlsearch

" Scrolling
"Don't wrap lines
set nowrap
set sidescrolloff=15
set sidescroll=1

" Start scrolling when we're 8 lines away from margins
set scrolloff=8

" Folding
set foldlevelstart=100
set foldmethod=indent

" Allows variable fold settings for specific files
set modelines=1

" Column on the 81st line - helps for observing style conventions
au FileType python,java,c,vim,text set colorcolumn=81
au FileType c setlocal softtabstop=8 shiftwidth=8
au FileType java setlocal softtabstop=4 shiftwidth=4

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
" Insert mode remapping {{{
inoremap jk <Esc>
inoremap jj <Esc>

" Emacs-style ctrl-a and ctrl-e to get to the beginning and end of line.
inoremap <c-a> <Esc>^i
inoremap <c-e> <Esc>A
" }}}

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

" Ctrl-left, Ctrl-right cycle through tabs. You need to configure your
" terminal to send the <ESC>B and <ESC>F escape sequences.
nnoremap <silent> <ESC>B :tabprevious<CR>
nnoremap <silent> <ESC>F :tabnext<CR>

" Map f to quickly jump to a line in normal mode using EasyMotion
nmap F <Plug>(easymotion-overwin-line)
nmap f <Plug>(easymotion-bd-w)

" Lowercase t toggles the tagbar in normal mode
nnoremap <silent> t :Tagbar<CR>

" OLD: Hitting enter jumps to the first tag found, if there IS one.
" nnoremap <silent><C-Return> :silent! execute "normal \<lt>c-]>" <CR>
" nnoremap <silent><C-bs> :silent! execute "normal \<lt>c-t>" <CR>
"
" NEW: Hitting enter invokes YCM GoTo. Backspace goes back to the last
" location. Locations can be navigated with C-i and C-o as well.
" nnoremap <silent><Return> :YcmCompleter GoTo <cr>

" Backspace goes backwards in the jumplist
nnoremap <bs> <C-o>

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

" s to save the current session as default
nnoremap <silent> s :SaveSession default<CR>

let mapleader=","

" Quickly edit vimrc
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader><cr> o<esc>

" Quickly source "vimrc
nnoremap <silent> <leader>lv :source $MYVIMRC<cr>

" Open Nerdtree
nnoremap <silent> <leader>n :NERDTree<cr>

" Toggle between things like True/False with Radev's switch plugin
nnoremap <silent> <leader>s :Switch<cr>

" Move visually (instead of by line number)
nnoremap j gj
nnoremap k gk

" Go to the next marker with ctrl-right. This is hacky as hell and depends on
" the sequence sent to vim by the terminal for ctrl-right. Need to fix this
" later.
nmap F ']

" As above, but for ctrl-left.
nmap B '[

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

" When going into insert mode, clear search
autocmd InsertEnter * :let b:_search=@/|let @/=''
autocmd InsertLeave * :let @/=get(b:,'_search','')

" Pop open location list with spacebar
nnoremap <silent> <Space> :call ToggleLocationList()<CR>

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
endfunction

function! AdjustWhitespaceExit()
	match ExtraWhitespace /\s\+$/
endfunction

au InsertEnter * call AdjustWhitespaceEnter()
au InsertLeave * call AdjustWhitespaceExit()

" }}}
" Plugin Settings {{{

" neodark {{{
let g:neodark#solid_vertsplit = 1
" }}}
"
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
" Set 'textwidth' to 80 characters.
au FileType text,python,c setlocal textwidth=80
" }}}

" formatoptions {{{
" Autoformat text
au FileType text setlocal formatoptions+=tn
au FileType python,c,java setlocal formatoptions=qrjcb
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
" let g:airline_theme="xtermlight"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Necessary for airline
set laststatus=2
" }}}

" Syntastic {{{
let g:syntastic_java_javac_classpath = '
            \/home/mgouzenko/Documents/graphics/pa5_release/src:
            \/home/mgouzenko/Documents/graphics/pa5_release/lib/joml-1.9.2.jar:
            \/home/mgouzenko/Documents/graphics/pa5_release/lib/PNGDecoder.jar:
            \/home/mgouzenko/Documents/graphics/pa5_release/lib/pngj-2.1.1.jar:
            \/home/mgouzenko/Documents/graphics/pa5_release/lib/lwjgl/*.jar:
            \/home/mgouzenko/Documents/graphics/pa5_release/lib/ejml-v0.30-libs/*.jar'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}

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

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_config.py'
" }}}

" vim-notes {{{
let g:notes_directories = ['~/google_drive/notes']
" }}}

" VimWiki {{{
let g:vimwiki_list = [ {'path': '~/google_drive/vimwiki' } ]
" }}}

" JavaComplete {{{
autocmd FileType java setlocal omnifunc=javacomplete#Complete
" }}}

" Vim rooter {{{
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['Rakefile', '.git/', 'build.xml', 'cscope.out']
" }}}

" vim-session {{{
" let g:session_autoload = 'yes'
" let g:session_autosave = 'yes'
let g:session_autoload = 'no'
" }}}

" Rainbow parentheses {{{
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['red',         'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['gray',        'firebrick3']
    \ ]
" au Syntax * RainbowParenthesesLoadBraces
" }}}

" IndentLine {{{
let g:indentLine_char = '│'
" }}}

" Vundle {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()

Plugin 'jwilm/i3-vim-focus'


" Colorschemes
Plugin 'KeitaNakamura/neodark.vim'
Plugin 'tomasr/molokai'
Plugin 'godlygeek/csapprox'

Plugin 'mgouzenko/codesearch_selector.vim'

" Allow cscope searches from inside Vim.
Plugin 'vim-scripts/cscope.vim'

" Navigate Vimium-style
Plugin 'easymotion/vim-easymotion'

" Run YcmGenerateConfig from root of project to create a .ycm_extra_config.py
" for C-family projects.
Plugin 'rdnetto/YCM-Generator'

" Highlighting for GLSL, OpenGL's shading language
Plugin 'tikhomirov/vim-glsl'

" Make parentheses different colors to distinguish them
Plugin 'kien/rainbow_parentheses.vim'

" Session management with :SaveSession and :OpenSession
Plugin 'xolox/vim-session'

" Change root to project root when editing file in vim.
Plugin 'airblade/vim-rooter'

" Java completion, integrates directly with omnibar for tab completion. Can
" make opening java files a little slow.
Plugin 'artur-shaik/vim-javacomplete2'

" Liquid templating for Jekyll
Plugin 'tpope/vim-liquid'

" statusbar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Automatic ctags cleanup on file writes. This plugin searches parent
" directories for any .tags files and removes stale tags.
"
" haven't used this for a while - may remove soon.
Plugin 'craigemery/vim-autotag'

" Scroll through color schemes
Plugin 'ScrollColors'

" Syntax checking - can cause open to be slow, especially for java
Plugin 'scrooloose/syntastic'

" Convenient completion for XML/HTML
Plugin 'othree/xml.vim'

" Press t to toggle tagbar.
Plugin 'majutsushi/tagbar'

" gc to toggle comments
Plugin 'tomtom/tcomment_vim'

" Browse the file system
Plugin 'scrooloose/nerdtree'

" Fuzzy search
Plugin 'kien/ctrlp.vim'

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Snippets are separated from the engine.
Plugin 'honza/vim-snippets'

" Autocompletion
Plugin 'Valloric/YouCompleteMe'

" Snippet expansion.
Plugin 'SirVer/ultisnips'

" Notes
" Plugin 'xolox/vim-notes'

" vim wiki
Plugin 'vimwiki/vimwiki'

" Vim misc required by vim notes and vim-session
Plugin 'xolox/vim-misc'

" Git plugin
Plugin 'tpope/vim-fugitive'

" Skeltons for common filetypes
Plugin 'noahfrederick/vim-skeleton'

" Toggle between things like True/False
Plugin 'AndrewRadev/switch.vim'

" Go between one liners and multi liners - gS and gJ
Plugin 'AndrewRadev/splitjoin.vim'

" Navigate markers easily
Plugin 'kshenoy/vim-signature'

" PEP8 indentation for python
Plugin 'hynek/vim-python-pep8-indent'

" Better handling of (), [], etc
Plugin 'jiangmiao/auto-pairs'

" Move function arguments around easily.
Plugin 'AndrewRadev/sideways.vim'

" Highlight code visually and surround it with S
Plugin 'tpope/vim-surround'

" Highlight string replacement as you type.
Plugin 'osyo-manga/vim-over'

" Displays vertical lines at each indentation level for code indented w/ spaces
Plugin 'Yggdroot/indentLine'

" All Plugins must be added before the following line.
call vundle#end()

filetype plugin indent on
" }}}
" }}}
" colorscheme {{{
" set background=light
" colorscheme desertEx
" colorscheme molokai
" colorscheme transparent
colorscheme neodark
" }}}
" vim:foldmethod=marker:foldlevel=0
