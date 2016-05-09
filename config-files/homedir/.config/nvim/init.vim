" Section Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" Colorscheme
    Plug 'tomasr/molokai'
    Plug 'altercation/vim-colors-solarized'
" Utilities
    " File navigation
        Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file finder, mapped to <leader>t
        Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }  " File explorer
        " Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons' " Plugins for NERDTree
    " Typing
        Plug 'Raimondi/delimitMate' " Automatic closing of quotes, parenthesis, brackets, etc.
        Plug 'tpope/vim-commentary' " Comment stuff out
        Plug 'tpope/vim-surround' " Mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
    " Integration with external tools
        Plug 'tpope/vim-fugitive' " Amazing git wrapper for vim
        " Plug 'benmills/vimux' " Tmux integration
        " Plug 'tpope/vim-dispatch' " Asynchronous build and test dispatcher
    " UI
        Plug 'vim-airline/vim-airline' " Fancy statusline
        Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline
        Plug 'myusuf3/numbers.vim' " Relative line numbering in normal mode, absolute in insert mode
    " Buffer navigation
        Plug 'mbbill/undotree' " Navigate in the undo tree
        Plug 'easymotion/vim-easymotion' " Quickly move to a position in the file by hitting target key
        Plug 'terryma/vim-multiple-cursors' " Editing the buffer at several places
        Plug 'tpope/vim-unimpaired' " Mappings which are simply short normal mode aliases for commonly used commands
    " Code analysis
        Plug 'benekastah/neomake' " Neovim replacement for syntastic using neovim's job control functonality
        Plug 'majutsushi/tagbar' " Analyse tags in the current file (Classes, methods, ...) and display them for quick navigation
        Plug 'tpope/vim-sleuth' " Detect indent style (tabs vs. spaces)
        "Plug 'editorconfig/editorconfig-vim' " .editorconfig support
    " Tab, completion and snippets
        Plug 'MarcWeber/vim-addon-mw-utils' " Interpret a file by function and cache file automatically - Required by snipmate
        Plug 'tomtom/tlib_vim' " Utility functions for vim - Required by snipmate
        Plug 'garbas/vim-snipmate' " Snippet manager
        Plug 'ervandew/supertab' " Perform all your vim insert mode completions with Tab
    " Other utils
        Plug 'mtth/scratch.vim' " Scratchpad in vim
        Plug 'sickill/vim-pasta' " Context-aware pasting (Keeps indentation)
        Plug 'tpope/vim-repeat' " Enables repeating other supported plugins with the . command
" language-specific plugins
    " Web
        " HTML
            Plug 'gregsexton/MatchTag', { 'for': 'html' } " Match tags in html, similar to paren support
            Plug 'othree/html5.vim', { 'for': 'html' } " html5 support
            Plug 'tpope/vim-ragtag' " Endings for html, xml, etc. - ehances surround
        " JS
            Plug 'pangloss/vim-javascript', { 'for': 'javascript' } " JavaScript support
            Plug 'othree/yajs.vim', { 'for': 'javascript' } " JavaScript syntax plugin
        " CSS / SASS / SCSS
            Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' } " sass scss syntax support
            Plug 'hail2u/vim-css3-syntax', { 'for': 'css' } " CSS3 syntax support
            Plug 'ap/vim-css-color', { 'for': ['css','stylus','scss'] } " Set the background of hex color values to the color
    " Markdown
        Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] } " Markdown support
        Plug 'tpope/vim-markdown', { 'for': 'markdown' } " Markdown support
    " JSON
        Plug 'elzr/vim-json', { 'for': 'json' } " JSON support
    " Python
        Plug 'klen/python-mode', { 'for': 'python' }  " Python syntax, indentation, documentation, code checking ...


call plug#end()

" }}}

" Section General {{{

set nocompatible " Not compatible with vi

set autoread " Detect when a file is changed But do not reload it automatically

set backspace=indent,eol,start " Make backspace behave in a sane manner

let mapleader = ',' " Set a map leader for more key combos

set history=1000 " Change commands history to 1000
set textwidth=120 " Automatic text wrapping when line too long

" Tab control
    let tabsize = 4
    " The visible width of tabs
        execute "set tabstop=".tabsize
    " Edit as if the tabs are tabsize characters wide
        execute "set softtabstop=".tabsize
    " Number of spaces to use for indent and unindent
        execute "set shiftwidth=".tabsize
    set smarttab " Tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set shiftround " Round indent to a multiple of 'shiftwidth'
    set completeopt+=longest
    set expandtab " Replace tab characters by spaces

" Make sure the mouse is usable in vim
    if has('mouse')
        set mouse=a
    endif

set clipboard=unnamed " Share vim clipboard with the system clipboard (X clipboard)

set ttyfast " Faster redrawing

set diffopt+=vertical " Default split for vimdiff is vertical

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " Highlight Git merge conflicts

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp " Location of vim backup files
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp " Location of vim swap files

set laststatus=2 " Show the status line all the time

set undofile " Persistent undos accros sessions

" }}}

" Section AutoGroups {{{

augroup configgroup
autocmd!

" Automatically resize panes on resize
    autocmd VimResized * exe 'normal! \<c-w>='
    autocmd BufWritePost .vimrc source %
    autocmd BufWritePost .vimrc.local source %

autocmd FocusLost * silent! wa " Save all files on focus lost, ignoring warnings about untitled buffers

autocmd FileType qf wincmd J " Make quickfix windows take all the lower section of the screen when there are multiple windows open

" Markdown
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'json=javascript', 'stylus', 'html']
    autocmd BufNewFile,BufRead,BufWrite *.md syntax match Comment /\%^---\_.\{-}---$/

autocmd BufWritePre * :%s/\s\+$//e " Remove trailing whitespaces before saving
autocmd! BufWritePost * Neomake " Neomake after saving

augroup END

" }}}

" Section User Interface {{{

" Code folding settings
set foldmethod=syntax " Fold based on indent
set foldnestmax=10 " Deepest fold is 10 levels
set nofoldenable " Don't fold by default
set foldlevel=1


set wildmenu " Enhanced command line completion
set hidden " Current buffer can be put into background
set showcmd " Show incomplete commands
set noshowmode " Don't show current mode, disabled for PowerLine
set wildmode=list:longest " Complete files like a shell
set scrolloff=3 " Lines of text around cursor
set shell=$SHELL

set title " Set terminal title

" Searching
    set ignorecase " Case insensitive searching
    set smartcase " Case-sensitive if expresson contains a capital letter
    set hlsearch " Highlight search results
    set incsearch " Set incremental search. Start highlighting while typing
    set nolazyredraw " Don't redraw while executing macros

set magic " Set magic on, for regex

set showmatch " Show matching braces
set mat=2 " How many tenths of a second to blink

syntax on " Switch syntax highlighting on

set encoding=utf8 " Encoding
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors"

set number " Show line numbers

set wrap "turn on line wrapping
set wrapmargin=8 " Wrap lines when coming within n characters from side
set linebreak " Set soft wrapping
set showbreak=… " Show ellipsis at breaking

set autoindent " Automatically set indent of new line
set smartindent " Add extra indent level when needed

" }}}

" Section Mappings {{{

noremap <space> :set hlsearch! hlsearch?<cr> " Clear highlighted search

nmap <leader>s :set invspell spelllang=en<cr> " Toggle spell checking

" Toggle invisible characters
    set invlist
    set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
    highlight SpecialKey ctermbg=none " Make the highlighting of tabs less annoying
    set showbreak=↪
    nmap <leader>l :set list!<cr>

" Keeping selected block selected after indentation
    vmap < <gv
    vmap > >gv

" One angle bracket is enough to indent
    nmap < <<
    nmap > >>

vnoremap . :normal .<cr> " Enable . command in visual mode

" Move to adjacent window, or create a new one if it does not exist
    map <silent> <S-h> :call WinMove('h')<cr>
    map <silent> <S-j> :call WinMove('j')<cr>
    map <silent> <S-k> :call WinMove('k')<cr>
    map <silent> <S-l> :call WinMove('l')<cr>

" Scroll the viewport faster
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>

" Moving up and down in wrapped lines
    nnoremap <silent> j gj
    nnoremap <silent> k gk
    nnoremap <silent> ^ g^
    nnoremap <silent> $ g$

nnoremap <leader>/ "fyiw :/<c-r>f<cr> " Search for word under the cursor

" }}}

" Section Functions {{{

" Window movement shortcuts. Move to the window in the direction shown, or create a new window
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

" Smart tab completion
function! Smart_TabComplete()
    let line = getline('.')                         " Current line

    let substr = strpart(line, -1, col('.')+1)      " From the start of the current
                                                    " line to one character right of the cursor
    let substr = matchstr(substr, '[^ \t]*$')       " Word till cursor
    if (strlen(substr)==0)                          " nothing to match on empty string
        return '\<tab>'
    endif
    let has_period = match(substr, '\.') != -1      " Position of period, if any
    let has_slash = match(substr, '\/') != -1       " position of slash, if any
    if (!has_period && !has_slash)
        return '\<C-X>\<C-P>'                         " Existing text matching
    elseif ( has_slash )
        return '\<C-X>\<C-F>'                         " File matching
    else
        return '\<C-X>\<C-O>'                         " Plugin matching
    endif
endfunction

" Delete whitespaces at the end of every line of the current file
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

" Hilight all the occurences of the word under the cursor in the current file
function! HiInterestingWord(n)
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

nnoremap <silent> <leader>u :call HtmlUnEscape()<cr>

" }}}

" Section Plugins {{{

" Colorscheme
    colorscheme molokai

" NERDTree
	let g:NERDTreeQuitOnOpen=0 " Close NERDTree after a file is opened
	let NERDTreeShowHidden=1 " Show hidden files in NERDTree
	nmap <silent> <leader>k :NERDTreeToggle<cr> " Toggle NERDTree
	nmap <silent> <leader>y :NERDTreeFind<cr> " Expand to the path of the file in the current buffer

" CtrlP
	let g:ctrlp_map='<leader>p'
	let g:ctrlp_dotfiles=1
	let g:ctrlp_working_path_mode = 'ra'
	let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Tagbar
    nmap <leader>t :Tagbar<CR>

" Fugitive
	nmap <silent> <leader>gs :Gstatus<cr>
	nmap <silent><leader>gd :Gdiff<cr>

" Airline
	" let g:airline_powerline_fonts=1
    let g:airline_left_sep = ' '
	let g:airline_right_sep=' '
	let g:airline_theme='molokai'

" SuperTab
let g:SuperTabCrMapping = 0

" Easymotion search
	map  / <Plug>(easymotion-sn)
	map  n <Plug>(easymotion-next)
	map  N <Plug>(easymotion-prev)

" Vim-json
    let g:vim_json_syntax_conceal = 0 " Don't hide quotes in json files

" Python mode
    let g:pymode_doc_bind = "<leader>h"

" }}}


" vim:foldmethod=marker:foldlevel=0
