"my functions

        "executes shell cmd and redirects output to a new tab
        "focus is given to the new tab
        "if the new tab alreay exists (recognized by name and at the side of current
        "tab), it is reused
        "only outputs at once when command returs
            "threfore no user input possible
        fu! RedirStdoutNewTabSingle(cmd)
            let a:newt= expand('%:p') . ".out.tmp"
            tabnext
            if expand('%:p') != a:newt
                tabprevious
                exe "tabnew" . a:newt
            else
                %d
            en
            exe "silent r !" . a:cmd
            set nomodified
        endf
        "command! -nargs=+ -complete=command TabMessage cal TabMessage(<q-args>)

        "map on all modes
        fu! MapAll(keys, rhs)
            exe 'noremap' a:keys a:rhs
            exe 'noremap!' a:keys '<ESC>'.a:rhs
        endf

        "map on all modes in current buffer
        fu! MapAllBuff(keys, rhs)
            exe 'noremap <buffer>' a:keys a:rhs
            exe 'noremap! <buffer>' a:keys '<ESC>'.a:rhs
        endf

        "open new Guake tab in cur dir
        fu! GuakeNewTabHere()
            exe ':sil ! guake -n ' . expand("%:p:h") . ' && guake -r ' . expand("%:p:h:t") . ' && guake -t'
        endf

        "run cmd in guake tab.
        "if done once already, reuses same tab for other cmds
        "this tab is named GVIM
        "number of this tab is stored in g:guakeTab
        "if the tab gets closed, there is currently no way simple to detect it, and this method breaks
        let g:guakeTab = ""
        fu! GuakeSingleTabCmdHere(cmd)
            if g:guakeTab == ""
                sil ! guake -n ~; guake -r "GVIM"
                    "create new tab
                let g:guakeTab = substitute( system('guake -g 2>/dev/null'), '[\n\r]', '', 'g' )
                    "store its number
            en
            exe 'sil ! guake -s ' . g:guakeTab . ' && guake -e cd ' . expand("%:p:h") . ' && guake -e ' . a:cmd . ' && guake -t'
                "execute command on the new tab
        endf

        fu! EchoReadable()
            if ! filereadable(expand('%:p'))
                ec expand('%:p')
                bd expand('%:p')
            en
        endf

"#plugins

    "#vundle
    
      "plugin manager

      "use this! easy plugin updating via git!

      "view all avaliable bundles (searches github?):

          "Bundles
      
      "#install plugin
      
          "add:
            
              "`Bundle 'gitrepouser/reponame'`
          
          "to `.vimrc` and run:
          
              "`BundleInstall`
      
      "update all installed plugins:
      
          "BundleInstall!

      "remove a plugin

      "required:
      filetype off

      set rtp+=~/.vim/bundle/vundle/
      cal vundle#rc()

      "let Vundle manage Vundle:

            Bundle 'gmarik/vundle'

    "#fugitive

        "git vim interface

        Bundle 'tpope/vim-fugitive'

    "#easymotion.

        "to understand this, do <leader><leader>w ...

        Bundle 'Lokaltog/vim-easymotion'

    Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

    "Bundle 'tpope/vim-rails.git'
        
    "#nerdcommenter
    
        "does the right type of comment for each recognized language

        Bundle 'scrooloose/nerdcommenter'

        "toogle comment on current/selected lines:

            "<leader>c<space>

    "#nerdtree

        Bundle 'scrooloose/nerdtree'
        "let NERDTreeKeepTreeInNewTab=0
        "let loaded_nerd_tree=1  "stop opening nerd tree.

        "delete all bookmarks: ``rm ~/.NERDtreebookmarks``

    "#vim-session

        "allows me to load last session automatically...

        Bundle 'xolox/vim-session'
        let g:session_default_to_last = 1
        let g:session_autosave = 'yes'
        let g:session_autoload = 'yes'

    "#neocomplcache
    
        "hardcore autocompletion. VERY GOOD PLUGIN!!!

        Bundle 'Shougo/neocomplcache'
        let g:neocomplcache_enable_at_startup             = 1
        let g:neocomplcache_enable_camel_case_completion  = 1
        let g:neocomplcache_enable_smart_case             = 1
        let g:neocomplcache_enable_underbar_completion    = 1
        let g:neocomplcache_min_syntax_length             = 3
        let g:neocomplcache_enable_auto_delimiter         = 1

        "AutoComplPop like behavior.
        let g:neocomplcache_enable_auto_select = 0

        "SuperTab like snippets behavior.
        imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)": pumvisible() ? "\<C-n>": "\<TAB>"

        "Plugin key-mappings.
        imap <C-k>     <Plug>(neocomplcache_snippets_expand)
        smap <C-k>     <Plug>(neocomplcache_snippets_expand)
        inoremap <expr><C-g>     neocomplcache#undo_completion()
        inoremap <expr><C-l>     neocomplcache#complete_common_string()


        "<cr>: close popup
        "<s-CR>: close popup and save indent.
        inoremap <expr><cr>  pumvisible() ? neocomplcache#close_popup() : "\<cr>"
        inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup() "\<cr>": "\<cr>"
        "<TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>": "\<TAB>"

        "<C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        inoremap <expr><C-e>  neocomplcache#cancel_popup()

        "Enable omni completion.
        au FileType css setlocal omnifunc=csscomplete#CompleteCSS
        au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        au FileType python setlocal omnifunc=pythoncomplete#Complete
        au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        "Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
            let g:neocomplcache_omni_patterns = {}
        en
        let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
        "au FileType ruby setlocal omnifunc=rubycomplete#Complete
        let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
        let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

        "For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        en

    "#vim-markdown
        "syntax highlight
        "code folding
        Bundle 'plasticboy/vim-markdown'

    "#msanders/snipmate.vim
        "allow you to define snippets: inster pieces of code, and then jump to
        "the point you want with tab. Also allows to force several placeholders
        "to be equal.
        Bundle 'msanders/snipmate.vim'

    "#vim-scripts repos
        Bundle 'L9'
        Bundle 'FuzzyFinder'

    "vim latex
        "Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
        "Bundle 'jcf/vim-latex'
        "could not install with vundle or vim. next best option then
        "set runtimepath+=$HOME/.vim/plugin/vim-latex

    "tpope/vim-surround
        "https://github.com/tpope/vim-surround
        "Intelligent ''', '"', and html tags conversion
        "ds": delete surrouding
        "cs"' : change double to single quotes on cur word
        "cs'<q : change apostrophe quote to xml <q html elemtn
        "cst" : change tag to "
        "ysiw] : add surrounding ] to word
        "ysiw[ : add surrounding space + ] to word
        "ysiw<em : add surrounding <em> to word
        "ysiwtem : idem
        "ysiw\tabuar{lc : latex envs
        "< ( { [ work multiline, ' " ` dont
        "linewise visual mode + S<p class="important">: surround lines with p.

        Bundle 'tpope/vim-surround'

    "vim-vis
        "visual block only replace
        "select then :B s/a/b/g. replace acts only on selected block
        Bundle 'taku-o/vim-vis'

    "rope-vim
        "python refactoring
        Bundle 'klen/rope-vim'

    "conque-term
        "- runs terminal inside vim
        "- hit esc and you can edit history as a vim buffer
        "    hit i, and you're back to terminal mode
        "- after C-D, shell history remains on normal buffer and you can vim edit it
        "
        ":ConqueTerm bash
        ":ConqueTermSplit mysql -h localhost -u joe -p sock_collection
        ":ConqueTermTab Powershell.exe
        ":ConqueTermVSplit C:\Python27\python.exe
        "
        "BETA feature, didn't work for me
        ":let term = conque_term#open('bash', ['tabnew'])
            ":cal my_terminal.write("make run\n")
            ":cal my_terminal.writeln("make run")
            "
            "let term = conque_term#get_instance()
            ""most recent
            "
            "let term = conque_term#get_instance(3)
            ""specific instance
        "
        ":ConqueTermTab bashx make run
        ":ConqueTermTab bashx make run; exit
        Bundle 'rosenfeld/conque-term'
        "github mirror of the google code main

"general

    "allows vim to detect the filetype and use different behaviours
    "accordingly
    syntax on
    filetype on
    filetype plugin on
    filetype indent on

    "working directory is always the same as the file being edited
    set autochdir

    "leave vi compatibility
    set nocompatible

    "use the mouse
    set mouse=a

    "stop creating backup files
    set nobackup
    set noswapfile

    "automatically load files that were modified externally
    :set autoread

    "stop those enter to continue useless messages
    set shortmess=atI

    "see many possibilities on a tab at command mode
    set wildmenu
    set wildmode=list:longest
    set history=1000

    "maintains at least 4 lines in view from the cursor
    set scrolloff=4

    "see trailling whitespace
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+\%#\@<!$/

    "normally, pressing alt focoses on the menu in gvim, but vim NEEDS no menu,
    "vim only needs vimrc!!
    set winaltkeys=no

"gui

    "colorscheme
    colorscheme vividchalk

    "font size
    set guifont=9

    "line numbers

        "set nonumber
        set number

    "#wrapping

        set nowrap
        set linebreak
        set nolist
        set textwidth=0
        set wrapmargin=0
        let &showbreak='>'.repeat(' ', 8)
        "slights highlights chars after 80
        "highlight OverLength ctermbg=red ctermfg=white guibg=#592929
        "match OverLength /\%81v.\+/
        augroup vimrc_aus
            au BufEnter * highlight OverLength ctermbg=darkgrey guibg=#101010
            au BufEnter * match OverLength /\%75v.*/
        augroup END

    "#ruler

        "at the right bottom there is info about:
        "line, column and percentage of current file
        "in the same space for commands
        "that is the ruler

        set ruler
        "set noruler

    "buffers

        "The current buffer can be put to the background without writing to disk
        "When a background buffer becomes current again, marks and undo-history are remembered.
        "from http://items.sjbach.com/319/configuring-vim-right
        "set hidden
        "too dangerous!
        
        ":au BufAdd,BufNewFile,BufRead * nested tab sball

    "#tabs

        "format tab titles:

            set guitablabel=%N)\ %t\ %M

        "%N: tab number from left to right
        "%t: basename of loaded buffer
        "%M: modify status ( a '+' if modified )

    "#gvim specific

        set guioptions-=m  "remove menu bar
        set guioptions-=T  "remove toolbar
        set guioptions-=r  "remove right-hand scroll bar
        set guioptions-=b  "remove right-hand scroll bar


    "allow backspacing over everything in insert mode

        set backspace=indent,eol,start

    "#indentation

        set expandtab     "insert spaces instead of tabs
        set tabstop=4     "a tab is four spaces
        set shiftwidth=4  "number of spaces to use for autoindenting
        set autoindent    "always set autoindenting on
        set copyindent    "copy the previous indentation on autoindenting
        set shiftround    "use multiple of shiftwidth when indenting with '<' and '>'
        set smarttab      "insert tabs on the start of a line according to
                                            " shiftwidth, not tabstop
    "#folding

        set foldmethod=indent   "fold based on indent
        set foldnestmax=3       "deepest fold level
        set nofoldenable        "dont fold by default
        set foldlevel=3         "this is just what i use

    "#conceal
    
        "the thing that renders greek, underline, etc in latex for example

        "g:tex_conceal=""

        set cole=0

    "#search

        "control parameters of `/` search

            set hlsearch    "highlight search terms
            set incsearch   "show search matches as you type
            set ignorecase  "ignore case when searching
            set smartcase   "ignore case if search pattern is all lowercase,
                            " case-sensitive otherwise
            set showmatch   "set show matching parenthesis

    "allows '%' to jump between open 'if' 'else', 'do', 'done', etc instead
    "of just parenthesis like chars
    "marcros/matchit.vim has been a standard file for years

        runtime macros/matchit.vim

    "autocompletion. leave to distro default
    "set ofu=syntaxcomplete#Complete

    "#autosource files named so.vim

        "allows to define project specific mappings for example
        "this comes after FileType, and thus has higher precedence

        "sources file if it is readable
        fu! SoIfReadable(f)
            if filereadable(a:f)
                exe "so " . a:f
            en
        endf

        au BufRead,BufNewFile * cal SoIfReadable('so.vim')

    "#language speficif

        "to be split up into ftplugin if gest too large.
        "ftplugin.after is read after ftplugin, so you are sure that your
        "settings will be left after the distro's default

        "#data languages

        "#html

            au FileType html setlocal shiftwidth=4 tabstop=4
            au BufEnter,BufRead *.html cal MapAllBuff( '<F6>', ':w<cr>:sil ! firefox %<cr>' )

        "#compilable markup

            "#md #rst

                "au FileType *.md setlocal shiftwidth=4 tabstop=4
                au BufEnter,BufRead *.{md,rst} setlocal shiftwidth=4 tabstop=4
                au BufEnter,BufRead *.{md,rst} setlocal filetype=text
                au BufEnter,BufRead *.{md,rst} cal MapAllBuff( '<F5>', 'w<cr>:sil ! make<cr>' )

                au BufEnter,BufRead *.md  cal MapAllBuff( '<F6>', ':pu=''<span id=\"VIMHERE\"></span>''<cr>:w<cr>:sil ! make<cr>:d<cr>:w<cr>:sil ! make firefox RUN_NOEXT="%:r" ID="\#VIMHERE"<cr>' )
                "TODO this is broken still:
                au BufEnter,BufRead *.rst cal MapAllBuff( '<F6>', 'o<cr><ESC>k:pu=''.. _vimhere:''<cr>:w<cr>:sil ! make<cr>k:d<cr>:d<cr>:d<cr>:w<cr>:sil ! make firefox RUN_NOEXT="%:r" ID="\#vimhere"<cr>' )
                "au BufEnter,BufRead *.{md,rst} cal MapAllBuff( '<F6>', ':pu=''<span id=\"VIMHERE\"></span>''<cr>:w<cr>:silent ! mkdir -p _out; pandoc -s --toc % -o _out/%<.html<cr>:d<cr>:w<cr>:silent ! firefox _out/%<.html\#VIMHERE<cr>' )
                "au BufRead,BufNewFile *.{md,rst} noremap <buffer> <F6> <ESC>:! mkdir -p _out; pandoc -s --toc % -o _out/%<.html; firefox _out/%<.html<cr>

                au BufEnter,BufRead *.{md,rst} cal MapAllBuff( '<F7>', ':w<cr>:sil ! make<cr>:sil ! make firefox RUN_NOEXT="%:r"<cr>' )
                au BufEnter,BufRead *.{md,rst} cal MapAllBuff( '<F8>', ':w<cr>:sil ! make<cr>:sil ! make okular  RUN_NOEXT="%:r"<cr>' )

            "#latex


                au FileType tex setlocal shiftwidth=2 tabstop=2

                au BufEnter,BufRead *.tex cal MapAllBuff( '<F5>'  , ':w<cr>:! make<cr>' )
                au BufEnter,BufRead *.tex cal MapAllBuff( '<S-F5>', ':w<cr>:sil ! make clean<cr>' )
                au BufEnter,BufRead *.tex cal MapAllBuff( '<F6>'  , ':w<cr>:exe '':sil ! make run VIEW=''''"%:r"'''' LINE=''''"'' . line(".") . ''"''''''<cr>' )

                "this works
                "but the problem is: in which dir is the output file?
                "this is something only the makefile knows about.
                fu! LatexForwardOkular(pdfdir)
                    let pdf = a:pdfdir . expand('%:r') . '.pdf'
                    let synctex_out = system( 'synctex view -i "' . line(".") . ':1:' . expand('%') . '" -o "' . pdf . '"' )
                    let page = 1
                    for l in split( synctex_out, '\n' )
                        if l =~ '^Page:'
                            let page = substitute( l, '^Page:\(\d\+\)$', '\1', '' )
                        en
                    endfor
                    exe 'sil! ! nohup okular --unique -p ' . page . ' ' . pdf . ' &'
                endf
                "au BufEnter,BufRead *.tex cal MapAllBuff( '<F4>', ':cal LatexForwardOkular("_out/")<cr>' )

        "#interpreted languages #python #bash

            au FileType python setlocal shiftwidth=4 tabstop=4

            au FileType python,sh cal MapAllBuff( '<F6>', ':w<cr>:cal RedirStdoutNewTabSingle( "./" . expand(''%'') )<cr>' )

        "#compile to executable languages

            "#c #cpp #lex #y #fortran #asm

            fu! FileTypeCCpp()
                cal MapAllBuff( '<F5>'  , ':w<cr>:make<cr>' ) "vim make quickfix
                cal MapAllBuff( '<S-F5>', ':w<cr>:sil ! make clean<cr>' )
                cal MapAllBuff( '<F6>'  , ':w<cr>:cal RedirStdoutNewTabSingle("make run")<cr>' )
                    "make run, stdout to a new file
                    "stdout is only seen when program stops.
                cal MapAllBuff( '<S-F6>', ':w<cr>:cal RedirStdoutNewTabSingle("make run RUN_ARGS=''\"\"''")<LEFT><LEFT><LEFT><LEFT><LEFT>' )
                    "same as above, but may pas command line args
                cal MapAllBuff( '<F7>'  , ':cnext<cr>' )
                cal MapAllBuff( '<F8>'  , ':cprevious<cr>' )
                cal MapAllBuff( '<F9>'  , ':w<cr>:cal RedirStdoutNewTabSingle("make profile")<cr>' )
                cal MapAllBuff( '<S-F9>', ':w<cr>:! make assembler<cr>' )
            endf

            au FileType c,cpp,fortran,asm cal FileTypeCCpp()

            au FileType c,cpp,asm setlocal shiftwidth=4 tabstop=4
            au BufEnter,BufRead *.{l,lex,y} setlocal shiftwidth=4 tabstop=4

            "because fortran has a max line length...
            au FileType fortran setlocal shiftwidth=2 tabstop=2

        "#vimscript

            "reaload all visible buffers.
            "TODO: multiple windows per tabpage.
            fu! ReloadVisible()
                set noconfirm
                tabdo e
                set confirm
            endfu

            au FileType vim setlocal shiftwidth=4 tabstop=4
            "this will write all buffers, source this vimrc, and reaload open
            "buffers so that changes in vimrc are applied
            au FileType vim noremap <buffer> <F5> :wa<cr>:so %<cr>:sil cal ReloadVisible()<cr>

"#key bindings

    "here are all the:

    "- cheats on default meanings
    "- custom mappings

    "sorted by qwerty order so that it is easy to find:

        "Esc F1-F12
        "1234567890
        "qwertyuiop[]
        "asdfghjkl;'\
        "zxcvbnm,./
        "^<v>

    "view docs on default mappings:

        "h index

    "language specific mappings may be in language specific sections

    "rationale: leave `<c-` commands to commands that must be done repeatedly several times

    "#mappable keys

        "vim is designed to work on terminals without X server.

        "therefore
        
        "- only stuff that has a standard representation can have mappings in vim.

            "examples:

                "a, s-a, c-a, ...

            "non-examples:

                "c-s-a

            "those non-examples are dealt with in other programs by detecting that
            "one key is pressed while the other is down

            "however terminals cannot detect key up/down i think!

        "- only stuff that has no control flow meaning in terminals is mappable!

            "non-examples:

            "- c-c: terminate process
            "- c-z: put process on background
            "- c-q:

    "#leader

        "set the current leader:

            "let mapleader = ','
            let mapleader = '\'

        "use current leader:

            "nnoremap <leader>a b

        "redefining it after changing a mapping has no effect on already defined
        "maps, but will affect commands that are defined afterwards:

            "let mapleader = ','
            "noremap <leader>a b
            "let mapleader = '\'
            "noremap <leader>d e

        "here, `,a` and `\d` have gotten mappings!

    "#f keys

            cal MapAll('<F2>',':NERDTreeToggle<cr>')
            cal MapAll('<F3>',':cal GuakeNewTabHere()<cr>')
            cal MapAll('<S-F3>',':ConqueTermTab bash<cr>')

    "#~

        "invert selection case:

            "vnoremap ~

    "#@

        "do macro saved on a register:
        
            "noremap @a

        "redo last used macro:

            "noremap @@

    "##

        "noremap * backwards:

            "noremap #

    "#*

        "search for word under cursor
        "# for backwards

            "noremap *

        "replacement starts as current word (w) under cursor
        "(analogy to `*` which searches for word under cursor):

            nnoremap <leader>* bve"zy:%s/<C-r>z/<C-r>z/g<left><left>

    "#tab

        "next and previous tab:

            cal MapAll( '<c-tab>',   ':tabnext<cr>' )
            cal MapAll( '<c-s-tab>', ':tabprevious<cr>' )

    "#q

        "start/end recording commands in register a:

            "nnoremap qa

        "enter ex mode:

            "nnoremap Q

        "same as command mode, except you can do several ex commands
        "without exiting ex command mode

        "visual block mode:

            "nnoremap c-q

        "same as `c-v` in gvim, but used for terminal control
    
    "#w

        "move across windows:

            "<c-w>h
            "<c-w>j
            "<c-w>k
            "<c-w>l

        "rationale: see <c-up>

        "close buffers:

            "cal MapAll( '<c-w>', ':tabclose<cr>' )
            cal MapAll( '<c-w>', ':q<cr>' )
            "cal MapAll( '<c-w>', ':bd<cr>' )

    "#e

        "scrol up one line (don't move cursor (unless it would go out of view)):

            "nnoremap <c-e>

        "mnemonic: Extra lines!!

        "accelerate vertical scroll down:

            nnoremap <C-E> 5<C-E>

    "#r

        "replace mode (insert but overwritting)
        "a bit useless

            "nnoremap R

        "redo:

            "nnoremap <C-R>

    "#t

        "like `f`, but stops right before char.

            "nnoremap t

        "repeated uses do nothing

        "a bit useless

        "mnemonic: unTill

        "tab navigation in normal mode
        "in terminal, alt tab is not possible,
        "but should be used in gvim instead.

            nnoremap tf :tabfirst<cr>
            nnoremap tl :tablast<cr>
            nnoremap tt :tabedit<Space>
            nnoremap tT :tabclose<cr>
            nnoremap tn :tabnew<cr>
            nnoremap tm :tabm<Space>

    "#y

        "same as c-e, upwards:

            "nnoremap <c-y>

        "mnemonic: ?

        "same as yy:

            "nnoremap Y

        "accelerate vertical scroll up
        
            nnoremap <C-Y> 5<C-Y>

        "copy line to system clipboard:

            nnoremap yY ^v$"+y

    "#u

        "selection to lowercase:

            "vnoremap u

        "selection to uppecase:

            "vnoremap U

        "half page Up:

            "nnoremap <c-u>

    "#i

        "inverse of <c-0>

        "nnoremap <c-i>

    "#o

        "do one normal command and return to insert mode

            "inoremap <C-o>:

        "go to last location you were at before jumping with commands lik `/` (:h jumplist)
        "may change buffers in cur window

    "#{

        "{       previous
        "} go to next     latex paragraph (double newline)

    "#a

        "Increment integer number under the cursor!

            "<C-A>

        "pAste from system clipboard before cursor (in the same place as you would edit with 'i')
        
        "the pasted item is left selected in viusal mode if you want to indent it

        "so if you want to append to a Line to to insert mode first, 'A' to append and then <C-A>

        "does not affect any vim local register

        "rationale

        "- c-A not to conflict with c-v visual block mode or with terminal shortcuts

        "- is left hand only, allowing you to keep your right hand is no the mouse
        
        "- the default <c-a> command is not that useful

            cnoremap <C-A> <C-R>+
            inoremap <C-A> <ESC>"+p`[v`]
            nnoremap <C-A> "+P`[v`]
            vnoremap <C-A> d"+P`[v`]

    "#s

        "same as cl:

            "nnoremap

        "useless.

        "substitude starting with selection/selection/:

            vnoremap s "zy:%s/<C-r>z/<C-r>z/g<left><left>

        "substitude starting with selection//

            vnoremap S "zy:%s/<C-r>z//g<left><left>

        "substitute on all file very magic:

            nnoremap <leader><leader>s :%s/\v/g<left><left>

        "substitute on all file very non-magic:
        
            nnoremap <leader><leader>S :%s/\V/g<left><left>

        "insert single char
        "can be repeated with `.`

            fu! RepeatChar(char, count)
                return repeat(a:char, a:count)
            endfu
            nnoremap <silent> s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<cr>
            nnoremap <silent> S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<cr>

        "type bd *.xml<C-S> to delete all xml buffers

            "cnoremap <C-S> <C-A>
    "#d

        "cut line to system clipboard:

            nnoremap dD ^v$"+ygv

        "takes word under cursor
        "open in turrent window a file with same name as that word
        "searchs files under the special path variable (no g: prefix, but global)
        "  help path
        "looks in cur dir by default
        "usage: view header/inlcluded files

            "nnoremap gf

    "select Go to last Pasted text (to indent, or delete for example)

        nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

    "I would rather have the capital H and L to go to
    "beginning or end of line
    "and J, K to jump 5 lines instead.
    "Also, I prefer to move along visual lines
    "rather than real lines ( thus the remap )

    nnoremap H ^
    vnoremap H ^
    nnoremap j gj
    vnoremap j gj
    nnoremap J 4gj
    vnoremap J 4gj

    "#k

        nnoremap k gk
        vnoremap k gk
        nnoremap K 4gk
        vnoremap K 4gk

        "i use J for something else:

            nnoremap <C-k> J

    "#l

        nnoremap L $
        vnoremap L $

    "#:

        "repeat last f, F, t or T (like n,N)

            "nnoremap ;

        "enter command mode:

            "nnoremap :

        "swap ';' and ':', dispensing shift to start commands:
            nnoremap ; :
            nnoremap : ;

        "noremap <c-;> asd

    "#z

        "remove useless zl that does single horizontal scroll:
        
            nnoremap zl zL
            nnoremap zh zH

    "#x

        "decrement number under cursor (oposite of <c-a>)

            "nnoremap <C-X>

        "cut to system clipboard

            vnoremap X "+ygvd

    "#c

        "copy to system clipboard:

            vnoremap C "+y

    "#m

        nnoremap <C-M> <plugin>NERDComToggleComment<cr>
            "toggle coMMent

        "make mark a on cur buf

            "ma

        "mark A on all open buffers
        "go to opens that buffer in cur window:

            "mA

    "#<

        "keep selected after shift in visual mode

            vnoremap < <gv
            vnoremap > >gv

    "#/

        "search forwards:

            "nnoremap /

        "very magic is more useful than normal:

            nnoremap / /\v

    "#directionals

            inoremap <Down> <C-o>gj
            inoremap <Up> <C-o>g

        "move across windows:

            nnoremap <C-left> <C-w>h
            nnoremap <C-right> <C-w>l
            nnoremap <C-up> <C-w>k
            nnoremap <C-down> <C-w>j

        "rationale:

        "- control for repeated uses
        "- c-w is a bit useless, remap it to something better

"#sources

"- <http://andrewscala.com/vimscript/>

    "a few good straight to the point, important vimscript tips

"- http://www.ibm.com/developerworks/linux/library/l-vim-script-1/index.html

      "begginner tuts on vimscript

"#vimscript

    "is the built-in language for scripting vim
  
"#ex command

    "is anything that can come after you type ':'
    "therefore anything that can be done in vimscript 
    
    "in `.vim` files, you don't need to add the ':'
    
    "examples: `:w`, `:d`, `:let`, `:cal`, `:norm`, etc.

    "non-examples:
    
    "- `h` (move left). This is called aa *normal mode command*. It can however be
            "accessed from a vimscript via the <#norm> command

    "- variables
    
            "let a = 1

        "a is not a command, but a variable. but you can use a inside of other commands:

            "ec a

    "- functions
    
            "fu! F()
                "ec 1
            "endf

        "f is not a command, so you **cannot** do:

            ":F()

        "you can however call a function with the `cal` command:

            ":cal F()

        "also it is a normal combo to define commands for functions that you
        "want to use often with something along:

            ":com! F cal F()

    "you can create you own commands with <#com>

"#command mode

    "is what you get when you type `:`

    "can tab complete

    "after a tab, left and right arrows navigate possible tab complete commands.

    "after a tab, up returns to the normal command mode

"#ex mode

    "is what you get when you type `Q`

    "it is like command mode, except you stay in it after executing a command until you type 'visual'

"#comments

    "start with '"'

"#spaces

    "are ignored like in c, except for newlines:

        "ec 1
        "ec 2

"#multiline commands

    "you can use the pipe char '|' to replace *some*, *but not all* newlines

        "ec 1 | ec 2

    "for example, does **not** work for function definitions:

        "fu F() | ec 1 | endf

"#scope

    "- g: varname     The variable is global
    "- s: varname     The variable is local to the current script file
    "- w: varname     The variable is local to the current editor window
    "- t: varname     The variable is local to the current editor tab
    "- b: varname     The variable is local to the current editor buffer
    "- l: varname     The variable is local to the current function
    "- a: varname     The variable is a parameter of the current function
    "- v: varname     The variable is one that Vim predefines

"#vars

    "must use let always:

        "let a = 2 | if a != 2 | ec 'fail' | en

    "can redefine:

        "let a = "abc"
        "let a = 1

    "#environment

        "just add a dollar `$`.

        "home variable, inherited from the calling environment:

            "ec $HOME

        "empty if not defined

        "some environment variables are given default values if undefined at startup:

            "ec $VIM
            "ec $VIMRUNTIME

        "can also be changed:

            "let $a = b
            "ec $a
            "!echo $a

"#list

    "let a = [ 1, 2, 3 ]

    "equality:

        if [1,2] != [1,2] | ec 'fail' | en
        if [1,2] == [2,1] | ec 'fail' | en

    "range:
    
        if range(3) != [ 0, 1, 2 ] | ec 'fail' | en

    "#filter

        "done in place:

            "a = range(4)
            "filter( a, 'v:val > 1' )
            "if a != [2,3] | ec 'fail' | en

        "copy:

            "a = range(4)
            "let b = filter( filter( a, 'v:val > 1' ) )
            "if a != range(4) | ec 'fail' | en
            "if b != [2,3]    | ec 'fail' | en

"#dict

"#string

    "escape

    ":ec 'That''s enough.'
    ":ec '\"'
        "exactly \ and "
        "the only escape inside single quotes is '' for '

    "concat:

        "if "ab" . "cd" != 'abcd' | ec 'fail' | en

    "string to int:

        "if 10  + "10"    != 20   | ec 'fail' | en
        "if 10  + "10.10" != 20   | ec 'fail' | en
        "if 1.1 + "1.1"   != 2.1  | ec 'fail' | en

    "equality:

        "if "ab" != "ab" | ec "fail" | en

    "length:

        "if len("abc") != 3 | ec 'fail' | en

    "split:

        "if split( "a,b,c", "," ) != [ 'a', 'b', 'c' ] | ec 'fail' | en

    "join:

        "if join( ["a", "b", "c"], "," ) != 'a,b,c' | ec 'fail' | en

"#if

        "if 0
            "ec 0
        "elseif 1
            "ec 1
        "en

    "single line:

        "if 0 | ec 0 | elseif 1 | ec 1 | else | ec 2 | en

"#for

    "for i in [1,3,2] | ec i | endfor

"#function

    "must start with uppercase char

    "'!' means can override existing func

    "cannot use | for single line

        fu! F( a, b )
            retu a:a + a:b
        endf

        if F( 1, 2 ) != 3 | ec 'fail' | en

    "nargs:

        fu! F( a, b, ... )
            for i in range( a:0 )
                ec a:{i}
            endfor
        endf

    "a:0 contains the number of args
    "a:1 contains the first arg
    "...

    "#cal

        "command to call function

        "ignores return value

        "only side effects can be useful therefore

"#exe

    "execute string as a vim command

        "exe "let a = 10"
        "if

    "multiple args separated by space:

        "exe "ec 1 |" "ec 1"

"#sil

    "ommit messages

    "multiline messages automatically require you to press enter:

        fu! F()
            ec 1
        endf

        cal F()
            "no enter

        fu! F2()
            ec 1
            ec 2
        endf

        cal F2()
            "enter

    "to ommite messages, use can use sil:

        ":sil cal F()
        ":sil cal F2()

    "silent shows vim errors and waits for confirmation:

        ":sil ec idontexist

    "unless you add '!':

        ":sil! ec idontexist

    "there must be no space between '!' and sil!! otherwise you get a shell command:

        ":sil ! ls
        ":sil ! echo idontexist

"#redir

    "redirect output of any *vim command* (ex :ec 1) output (for sh stdout (:! ls), use <#r> )

    "redir to var a:

        "redir =>a | ec 1 | redir END
        "if a != 1 | ec 'fail' | en

    "append ro var a:

        "redir =>>a

    "redir to register a:

        "redir @a
            "ec 1
        "redir END

    "redir @a
    "!ls
    "redir END
        "redir to register a
        "a contains:
        "
        "!ls
        "
        "a b c d e

"#shell commands

    "excecute shell command:

        "! ls; ls

    "pass vim variable to bash command:

        "let a = 1
        "exe "! echo " . a

    "#system

        "exec sh command and get stdout

        "let a = system( 'ec asdf' )
        "ec a
            "asdf

        "let a = system( 'sort', "b\na" )
        "ec a
            "a
            "b

        ":ec v:shell_error
            "constains return status of last command executed by shell after
            "- ``:!``
            "- ``:r !``
            "- calling ``system()``

    "#exit status of shell command

        "is stored in `v:shell_error`

        "same as `$?`

        "works after:

        "- !
        "- r !
        "- system

"#buffer

    "buffers are RAM memory versions of files, possibly without saved to disk changes

    "they may be open on one or more windows or not.

    "#loaded vs unloaded

        "if a buffer is loaded it occupies space in memory.

        "if a buffer is visible on a window, it must be loaded.

    "#visible vs hidden

        "if a buffer is open on some window it is visible

        "a buffer may be loaded without being visible. It is called a *hidden buffer*
    
    "#buffer list

        "is a list of buffers vim knows of! =)

        "they may be loaded or not, visible or not.

    "#ls

        "show buffer list:

            "ls

        "status:

        "a: Active == loaded and   visible
        "h: Hidden == loaded but invisible

    "add file to buffer list but don't load it:

        "bad f1.txt

    "#b

        "load buffer 2 and make it visible in cur window:

            "b 2

        "load buffer `file.txt`:

            "b file.txt

        "tab complete matches in middle of file paths.

        "if there is a single match for a substring of path, <enter> opens it.

    "#sb

        "same as b, but split current window instead of unloading current buffer

            "sb 1

    "#bunload
    
        "unload current but don't remove it from buffer list.
            
            ":bunload

        "closes *all* windows in which it was visible.

    "#bd

        "unload and remove from list

        "closes *all* windows in which it was visible

        "current:
            
            "bd

        "by filename:

            "bd f1.txt f2.txt

        "by number (can be found with :ls)

            "bd 12 13

        "by range of bumbers:

            "3,5bd

    "#bw

        "Wipe. like bd, but also removes all metadata data like marks

    "#w

        "save cur buffer to disk:

            "w
        
        "if file does not exit, create it.

    "wipe all buffers without corresponding existing files:

        fu! s:WipeBuffersWithoutFiles()
            let bufs = filter(
                range( 1, bufnr('$') ),
                'bufexists(v:val) && '.
                \'empty(getbufvar(v:val, "&buftype")) && '.
                \'!filereadable(bufname(v:val))'
            )
            if !empty(bufs)
                exe 'bw' join(bufs)
            en
        endf

        "command WBWF call s:WipeBuffersWithoutFiles()

"#window

    "a window is a view of a buffer.

    "a buffer may be visible in multiple windows.

    "modifying a buffer in any window automatically modifies its view in other windows.

    "close cur window:

        ":q

    "does not delete its buffer from buffer list.
    
    "if this was the last visible window of the buffer,
    "also unloads the buffer.

    "close all windows and quit vim:
    
        ":qa

    ":on

        "close all windows except cur one

"#tab

    "a tab is a collection of split windows

"#norm

    "execute normal mode command:

        "norm dd

"#editing commands

    "prints lines to command line

        "#p
    
    "#pu

      "insert abc on a new line after current line:

          "pu = 'abc'

          "let a = 'abc'
          "pu = a

      "inserts content of register a:

          "pu a

      "before cur line:

            "pu! a

    "#d

        "delete cur line, put it on register

    "#r

        "inserts contents of file here

        "inserts stdout in current line (read)

            "r a.txt

            "r !ls

    "yank:

        "y

    "yank to register a:

        "y a

    "#s

        "substitute on lines with regex

        "s/re/sub
            "sub
        "s/re/sub/g
            "global
        "s/re/sub/c
            "confirm before

    ":3t5
        "copy line 3 to line 5

    ":3m5
        "move line 3 to line 5

    ":g/re/p
        "global if line matches re

    ":g/^pattern/s/$/mytext
        "do s in each line that matches pattern

"#range

    "for many commands you can specify a line range of action

    "lines 1 and 2:

        ":1,2p

    "from cur line to end:

        ".+1,$p

    "all lines before the current line

        ":1,.-1p

    "all lines: 
    
        "%p

        "1,$p

    "from mark a to mark b, inclusive

        ":'a,'bp

    "/pattern/     next line where pattern matches

    "?pattern?     previous line where pattern matches

    "\/     next line where the previously used search pattern matches
    "\?     previous line where the previously used search pattern matches
    "\&     next line where the previously used substitute pattern matches
    "0;/that     first line containing "that" (also matches in the first line)
    "1;/that     first line after line 1 containing "that"

    "http://vim.wikia.com/wiki/Ranges

"#au

    "<http://www.ibm.com/developerworks/linux/library/l-vim-script-5/index.html>

    "patterns:
    
    "- *.py
    "- *.py,*.pl
    "- *.{py,pl}

"#map #noremap #nmap #nnoremap

    "map keys and key sequences to others
    "later view what they are mapped to

    ":h map

    "#mode versions

        "n: normal
        "v: visual
        "i: insert
        "c: command

            "nmap a b
            "vmap b c
            "imap c d
            "cmap d e

    "#no versions

        "don't remap recursivelly

        "always use this to avoid lots of confusion =)

        "a and b become c:

            "map! a b
            "map! b c

        "a becomes b, b become c:

            "noremap! a b
            "noremap! b c

    "#! versions

        "without exclamation: map on all command like modes: normal, visual, ...
        "with               :            insert            : insert, command, ...

            "noremap  a b
            "noremap! a b
        
        "but cannot use exclamation with mode also:
            
            "noremap! a b

        "makes no sense

    "#override

        "whatever comes after wins:

            "map! a b
            "map! a c

    "#unmap

        "rever a map to its vim default:

            "map a b
            "unmap a

            "map! a b
            "unmap! a

    "#map to nothing

            "map! q <nop>

    "#view what something is currently mapped to

            "map a
            "map <c-a>

    "#multiple keys

            "map ab c

        "if you type a then b before the timeout, triggers c

        "if you type `a` and wait the timeout, triggers `a`

        "#timeoutlen

            "control timeout in ms

            "default: 1000ms

            "set timeoutlen = 10
            "set timeoutlen = 3000

"#bufdo #tabdo #windo
    "do a command on all *

"#set

    "controls several vim options

    "- nomodified
        "as if the buffer hadn't been modified

"#built-in functions

    "if filereadable("SpecificFile")
            "ec "SpecificFile exists"
    "en

    "#line

        "cur line number

            "a = line(".")

    "#expand

        ":ec expand('%:r')
        "@%     dir/a.vim     directory/name of file
        "%:p  /usr/dir/a.vim
            "full path
        "%:h    /usr/dir
            "head
            "but may be relative to ~
        "%:t    a.vim
            "tail
        "%:r    a
            "root
        "%:e    .vim
            "ext
        "%:p:h    /usr/dir
            "head
            "absolute
        "%:p:h:t    dir
        "map a :ec expand('%')<cr>
            "always expands ``.vimrc``!
            "no use
        "fu! E()
        "  exe ':ec expand('%')'

        "this works, don't know why:

            "so %

"#regex

    "pearl like but...

    "by default must escape some chars for them *to be* magic but not others...

    "but you can change that with modifying chars and using one of the four flavors:

    "- magic
    "- non magic
    "- very magic
    "- very non magic

    "I only recommend using very magic and very non-magic for you own sanity
    "since in those modes it is easy to remember what is what.

    ":h regex for explanations

    "#very non magic

        "becomes not a regex, everything is literal, unless escaped by \:

        "default regex:

            "/.*

        "very non-magic:

            "/\V\.\*

    "#very magic

        "you can change the flavour with \v! with \v, meaning Very magic,
        "only: [A-Za-0-9_] are not magic and thigs really work like in perl!

        "example:

        "default regex:

            "/\(a\+\)

        "very magic regex:

            "/\v(a+)

        "you should always use very magic.

    "#change default flavor

        "cannot be done: <http://stackoverflow.com/questions/3760444/in-vim-is-there-a-way-to-set-very-magic-permanently-and-globally>

        "would break too may plugings

    "special chars

        "\r newline

    "escape to be literal:

    "- .      wildcard
    "- a*     repetition
    "- a\{-}  non greedy repeat
    "- [abc]  char classes
    "- ^      begin
    "- $      end

    "escape to be magic:

    "- a\+
    "- a\(b\|c\)
    "- a\|b
    "- a\{1,3}
    "- \<           word boundary left
    "- \>           word boundary right
    "- \1           mathing group 1. can be used on search
    "- /\(\w\)\1  search equal adjacent chars

    "classes:

    "- \w   alpha (a-zA-z)
    "- \n     a newline character (line ending)
    "- \s   whitespace except newline
    "- \S   non-whitespace
    "- \_s     a whitespace (space or tab) or newline character
    "- \_^     the beginning of a line (zero width)
    "- \_$     the end of a line (zero width)
    "- \_.     any character including a newline

    "#perldo

        "if compiled with perl support (`vim --version | grep perl`),
        "you can use perld for replacements

        "ex:

            ":pe $a = 'b'
            ":perldo s/$a(.)/c\1/g

        "so you get perl regexes

    "#s

        ":s/\(a\)/\1b
            "refer to capture group on replace
        ":s/.*/\u&
            "Sets first letter of each line to uppercase
        ":s/.*/\l&
            "Sets first letter of each line to lowercase
        ":%s/\r//g
            "Delete DOS carriage returns (^M)
        ":%s/\r/\r/g
            "Transform DOS carriage returns in returns
        ":%s/a/a/c
            "confirm each match replace
            "y: yes
            "n: no
            "a: replace all remaining
            "q: quit
            "l: last. yes and quit

    "#substitute

        "regex replace in vimscript

            "if substitute( 'abc', 'a\(.\)c', '\1', '' ) != 'b' | ec 'fail' | en

    "check if string matches regex:

        "if 'abc' =~ 'a.c' | | else | ec 'fail' | en
        "if 'abc' !~ 'a.c' |          ec 'fail' | en

"#com

    "view existing and create new commands

    "`!` creates new. must start uppercase
    "command! -nargs=+ -complete=command Func call Func(<q-args>)
    "define a user command from a function
    "now you can cal  Func as df

    "com! -nargs=1 Pd :perldo

"#quickfix

    "- :make    creates the error list
    "- :copen   open error list in window
    "- :cc      see the current error
    "- :cn      next error
    "- :cp      previous error
    "- :clist   list all errors

"#script vim with python

    "you can script vim with python instead of vimscript!!!

    "this is a **GREAT** feature!!! no more vimscript for me except for the most simple tasks!!!

    "h python-vim

    "for this to work you need:

    "- python!
    "- vim compiled with python support

    "separate commands go to the same python session:

        "py a = 1
        "py a = a + 1
        "py assert a == 2

    "commands:

        ":py vim.command('p')               "execute an Ex command

    "normal mode commands:

        ":py vim.command('normal j')        "down one line

    "window:

        ":py w = vim.windows[n]             "gets window "n"
        ":py cw = vim.current.window        "gets the current window
        ":py w.height = lines               "sets the window height
        ":py w.cursor = (row, col)          "sets the window cursor position
        ":py pos = w.cursor                 "gets a tuple (row, col)

    "buffer:

        ":py b = vim.buffers[n]             "gets buffer "n"
        ":py cb = vim.current.buffer        "gets the current buffer
        ":py name = b.name                  "gets the buffer file name
        ":py line = b[n]                    "gets a line from the buffer
        ":py b[n] = str                     "sets a line in the buffer
        ":py b[n:m] = [str1, str2, str3]    "sets a number of lines at once
        ":py del b[n]                       "deletes a line
        ":py del b[n:m]                     "deletes a number of lines
        ":py del b[n:m]                     "deletes a number of lines

    "#vim.eval

        "evaluate a vim expression and get its result

        "returns:

        "- a string if the Vim expression evaluates to a string or number
        "- a list if the Vim expression evaluates to a Vim list
        "- a dictionary if the Vim expression evaluates to a Vim dictionary

        "pass a vim integer variable to python:

            ":let a = 1
            ":py a = int( vim.eval('a') )
            ":py assert a + 1 == 2

    "multiline python code:

py << EOF
def f():
    print 1
EOF

    fu! PythonTest()
        py f()
    endf

"#vim configuration

    "<http://www.22ideastreet.com/debug/vim-directory-structure/>

    "help on startup sequence:

        ":h startup

    "show all scripts that are run and their order:

        ":scriptnames

    "order:

    "- ~/.vimrc
    "- ~/.vim/plugin/

    "note that:

    "- ~/.vimrc comes before the plugins! So plugins may override stuff you put in your .vimrc.

    "#plugin

        "plugins sourced for all file types

        "*nix location: ~/.vim/plugin/

        "all files ending in .vim will be sourced at startup

    "#ftplugin

        "plugin that sources scripts only for particular types

        "*nix location:  ~/.vim/ftplugin

        "all .vim in this directory and subdirectories will be sourced on Buf enters

        "sourced on c files:

            "c.vim
            "c_extra.vim
            "c/settings.vim

        "'_' is required to separate c form the arbitrary rest of the name

"#find

    ":find
    ":sfind
    ":tabfind
    "find in vim path var, and edit here, split, new tab
