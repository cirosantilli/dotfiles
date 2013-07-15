"#my functions

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

        " transforms well formated selected line commented code to markdown
        "
        " well formated for languages that don't have fixed indentation:
        "
        " - use exact md, except that instead of header levels use 4 spaces for indentation
        "     and always a single `#`
        "
        " for languages that have fixed inedentation (python):
        "
        " - always add a space after each comment, except for the code
        "
        "     this way, you can simply uncomment to try stuff out
        "
        "     not yet implemented
        "
        " this is only an heuristic, as nested lists are hard to tokenize
        "
        " :param comment: the regex that starts the line comment.
        "
        "     ex: `#` in python, `"` in vim
        "
        " :param comment: regexp that starts a comment
        " :type comment: string
        "
        fu! CodeToMd(comment)

            "for each removed indent, add a header level
            let a:find = '\v^(\s*)    (' . a:comment . '#+)'
            for a:n in range( line("'<"), line("'>") )
                let a:l = getline(a:n)
                while a:l =~ a:find
                    exe string(a:n) . 's/' . a:find . '/\1#\2/'
                    let a:l = getline(a:n)
                endwhile
            endfor

            silent! exe '''<,''>s/\v^\s*' . a:comment . '([^#])/\1/'
            "silent! exe '''<,''>s/\v^(#+)([^#])/\1 \2/'
            silent! exe '''<,''>s/\v^\s+([^#])/    \1/'
        endfunction

        "reduces level of all selected markdown headers
        "
        "operates linewise even if the cursor is not a the beginning of a line
        "
        "if there is a level one header at already level one,
        "raises an exception and does nothing
        "
        fu! MdReduceLevel()
            for a:n in range( line("'<"), line("'>") )
                if getline(a:n) =~ '^#[^#]'
                    throw 'one of the headers is already at level one. Operation aborted'
                endif
            endfor
            exe '''<,''>s/\v^(#+)#/\1/'
        endf

        fu! MdIncreaseLevel()
            exe '''<,''>s/\v^(#+)/\1#/'
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

        "remove a plugin:

        "required:
        filetype off

        set rtp+=~/.vim/bundle/vundle/
        cal vundle#rc()

        "let Vundle manage Vundle:

                Bundle 'gmarik/vundle'

        "#inner workings

            "Vundle adds each plugin        to runpath, before ~/.vim/after
            "                 plugin/after            , after

        "#overriding mappings

            "using the default path maintained by vundle you can override

            "ftplugin mappings by:

            "- putting the mapping as an au in your vimrc:

                "au FileType FT nn <buffer> a b

            "- putting the mapping inside ~/.vim/ftplugin/FT_something.vim

                "nn <buffer> a b

            "- putting the mapping inside ~/.vim/after/ftplugin/FT_something.vim

            "I don't think `ftplugin/after` mappings can be overriden

            "TODO


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
        imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)": pumvisible() ? "\<c-n>": "\<TAB>"

        "Plugin key-mappings.
        imap <c-k>     <Plug>(neocomplcache_snippets_expand)
        smap <c-k>     <Plug>(neocomplcache_snippets_expand)
        inoremap <expr><c-g>     neocomplcache#undo_completion()
        inoremap <expr><c-l>     neocomplcache#complete_common_string()


        "<cr>: close popup
        "<s-CR>: close popup and save indent.
        inoremap <expr><cr>  pumvisible() ? neocomplcache#close_popup() : "\<cr>"
        inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup() "\<cr>": "\<cr>"
        "<TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<c-n>": "\<TAB>"

        "<c-h>, <BS>: close popup and delete backword char.
        inoremap <expr><c-h> neocomplcache#smart_close_popup()."\<c-h>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<c-h>"
        inoremap <expr><c-y>  neocomplcache#close_popup()
        inoremap <expr><c-e>  neocomplcache#cancel_popup()

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

    "#fugitive

        "git vim interface

        Bundle 'tpope/vim-fugitive'

    "#easymotion

        "list on place all possitions and jump to them with a single key stroke

        "very fast for non structured moves!

        "- <leader><leader>w        beginnings  of words and lines
        "- <leader><leader>W                       Words
        "- <leader><leader>e        ends           words
        "- <leader><leader>E        ends           Words
        "- <leader><leader>f{char}  given chars
        "- <leader><leader>j        lines down
        "- <leader><leader>n        last search down

            "h easymotion

        Bundle 'Lokaltog/vim-easymotion'

    "#nerdcommenter

        "does the right type of comment for each recognized language

        Bundle 'scrooloose/nerdcommenter'

        "toogle comment on current/selected lines:

            "<leader>c<space>

    "#nerdtree

        "file manager

            Bundle 'scrooloose/nerdtree'

            "h nerdtree

        "let NERDTreeKeepTreeInNewTab=0
        "let loaded_nerd_tree=1  "stop opening nerd tree.

        "- ?: help

        "- u: root up a dir
        "- C: change root to selected dir
        "- o: toogle open close dir
        "- x: close current level

        "- - t: open in new tab and to to it
             "For file,  opens normal buffer
             "For dir,   opens another nerdtree with root there
        "- T: same as t but stay on current nerd tree

        "- - p: go to parent of current
        "- P: go to root
        "- K: first   sibling current level
        "- J: last    sibling current level
        "- <c-k>: previous sibling
        "- <c-j>: next sibling

        "- m: enter a menu that allows you to: copy, delete, etc.
            "selected node. <esc> to exit this menu

        "- A: toogle maximize

        "- B: show bookmark list and move cursor to first one
        "- o: move root to selected bookmark
        "- D: delete selected bookmark
        "
        "the following commands can only be used from inside NERDTree:
        "- :Bookmark <name>: create bookmark at node under cursor with given name
        "- :BookmarkToRoot <name>: move root to bookmark with given name
        "- :ClearBookmark <name>: delete bookmark

    "#vim-session

        "manage sessions

        "in particular, can load last session automatically...

        "help:

            "h session

        "list all sessions:

            "OpenSession <tab>

        "save session:

            "SaveSession <session_name>

        "delete session:

            "DeleteSession <session_name>

        Bundle 'xolox/vim-session'

        let g:session_autosave = 'yes'

        "open last used session instead of the session called default (which
        "is the default behaviour):

            let g:session_default_to_last = 1

        "autoload session at startup as specified by `g:session_default_to_last`:

            let g:session_autoload = 'yes'

    "#msanders/snipmate.vim

        "allow you to define snippets: inster pieces of code, and then jump to
        "the point you want with tab. Also allows to force several placeholders
        "to be equal.
        Bundle 'msanders/snipmate.vim'

    "#vim-scripts repos

        Bundle 'L9'
        Bundle 'FuzzyFinder'

    "#tpope/vim-surround

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

    "#vim-vis

        "visual block only replace
        "select then :B s/a/b/g. replace acts only on selected block
        Bundle 'taku-o/vim-vis'

    "#conque-term

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

    "#vim-markdown

        "syntax highlight
        "code folding

        Bundle 'plasticboy/vim-markdown'

        "disable folding

            let g:vim_markdown_folding_disabled=1

        "Bundle 'tpope/vim-markdown'

    "#sparkup

        "html mappings

        Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

    "#vim latex

        "Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
        "Bundle 'jcf/vim-latex'
        "could not install with vundle or vim. next best option then
        "set runtimepath+=$HOME/.vim/plugin/vim-latex

    "#rope-vim

        "python refactoring

        Bundle 'klen/rope-vim'

"#general

    "leave vi compatibility:
    set nocompatible

    "#filetype

        "set autodetect filetype and set it for buffers:
        filetype on

        "this allows the following to work properly:

        "- plugins for given filetypes
        filetype plugin on

        "- syntax highlighting
        syntax on

        "- indent for specific filetypes
        filetype indent on

    "#search

        "control parameters of `/` search

            set hlsearch    "highlight search terms
            set incsearch   "show search matches as you type
            set ignorecase  "ignore case when searching
            set smartcase   "ignore case if search pattern is all lowercase,
                            " case-sensitive otherwise
            set showmatch   "set show matching parenthesis
            set wrapscan  " wrap around end of document (default)
            "set nowrapscan " do not wrap around

        "stop current highlighting:

            "noh

        "will be automatically turned back on on next search

    "working directory is always the same as the file being edited
    set autochdir

    "allow to use the mouse:
    set mouse=a

    "stop creating backup files
    set nobackup
    set noswapfile

    "automatically load files that were modified externally
    set autoread

    "stop those enter to continue useless messages:
    set shortmess=atI

    "tab completion
    set wildmenu
    set wildmode=list:longest
    set history=1000

    "maintains at least 4 lines in view from the cursor
    set scrolloff=4

    "normally, pressing alt focuses on the menu in gvim, but vim NEEDS no menu,
    "vim only needs vimrc!!
    set winaltkeys=no

    "colorscheme
    colorscheme vividchalk

    "font size
    set guifont=9

    "line numbers on right of page

        "set nonumber
        set number

    "#wrapping

        set nowrap
        set linebreak
        set nolist
        set textwidth=0
        set wrapmargin=0
        let &showbreak='>'.repeat(' ', 8)

        aug highlight_line_too_long
            au BufEnter * highlight LineTooLong ctermbg=darkgrey guibg=#101010
            au BufEnter * match LineTooLong /\%75v.*/
        aug END

    "highlight tralling whitestpace
    aug highlight_trailling_whitespace
        au BufEnter * highlight TraillingWhitespace ctermbg=brown guibg=brown
        au BufEnter * match TraillingWhitespace /\s\+$/
    aug END

    "#ruler

        "at the right bottom there is info about:
        "line, column and percentage of current file
        "in the same space for commands
        "that is the ruler

        set ruler
        "set noruler

    "#tabwindow

        "format tab titles:

            set guitablabel=%N)\ %t\ %M

        "%N: tab number from left to right
        "%t: basename of loaded buffer
        "%M: modify status ( a '+' if modified )

    "allow backspacing over everything in insert mode:

        set backspace=indent,eol,start

    "#tab

        set expandtab     "insert spaces instead of tabs
        set tabstop=4     "a tab viewed as 8 spaces
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

    "#gvim specific

        set guioptions-=m  "remove menu bar
        set guioptions-=T  "remove toolbar
        set guioptions-=r  "remove right-hand scroll bar
        set guioptions-=b  "remove right-hand scroll bar

    "#conceal

        "the thing that renders greek, underline, etc in latex for example

        "g:tex_conceal=""

        set cole=0

    "allows '%' to jump between open 'if' 'else', 'do', 'done', etc instead
    "of just parenthesis like chars
    "marcros/matchit.vim has been a standard file for years

        runtime macros/matchit.vim

    "autocompletion. leave to distro default
    "set ofu=syntaxcomplete#Complete

    "#autosource project files

        "allows to define project specific mappings for example
        "this comes after FileType, and thus has higher precedence

        " if there is a file named `so.vim` in current dir, source it
        "
        "fu! SoCurDir(f)
            "if filereadable(a:f)
                "exe "so " . a:f
            "en
        "endf

        "au BufRead,BufNewFile * cal SoCurDir('so.vim')

        " if there is a file named `so.vim` in current dir or any of its
        " parent dirs, source it
        "
        fu! FindSourceUp(filename)
            let a:parent = fnamemodify( '.', ":p:h")
            let a:path = a:parent . '/' . a:filename
            let a:found = 1
            while ! filereadable( a:path )
                if a:parent ==# '/'
                    let a:found = 0
                    break
                endif
                let a:parent = fnamemodify( a:parent, ":h") 
                let a:path = a:parent . '/' . a:filename
            endwhile
            if a:found
                exe "so " . a:path
            endif
        endf

        au BufRead,BufNewFile * cal FindSourceUp('so.vim')

"#language speficif

    "the right place for those is in a ftplugin, but I'm lazy to put such small settings in files...

    "#data languages

    "#html

        au FileType html setlocal shiftwidth=4 tabstop=4
        au BufEnter,BufRead *.html cal MapAllBuff( '<F6>', ':w<cr>:sil ! firefox %<cr>' )

    "#compilable markup

        "#md #rst

            "au FileType *.md setlocal shiftwidth=4 tabstop=4
            au BufEnter,BufRead *.{md,rst} setl shiftwidth=4 tabstop=4
            "au BufEnter,BufRead *.{md,rst} setl filetype=text
            au BufEnter,BufRead *.{md,rst} cal MapAllBuff( '<F5>', 'w<cr>:sil ! make<cr>' )

            au BufEnter,BufRead *.md  cal MapAllBuff( '<F6>', ':pu=''<span id=\"VIMHERE\"></span>''<cr>:w<cr>:sil ! make<cr>:d<cr>:w<cr>:sil ! make firefox RUN_NOEXT="%:r" ID="\#VIMHERE"<cr>' )
            "TODO this is broken still:
            au BufEnter,BufRead *.rst cal MapAllBuff( '<F6>', 'o<cr><ESC>k:pu=''.. _vimhere:''<cr>:w<cr>:sil ! make<cr>k:d<cr>:d<cr>:d<cr>:w<cr>:sil ! make firefox RUN_NOEXT="%:r" ID="\#vimhere"<cr>' )

            "make and open with firefox on curent point without a makefile
            let s:out_dir = '_out'
            au BufEnter,BufRead *.{md,rst} cal MapAllBuff( '<S-F6>', ':pu=''<span id=\"VIMHERE\"></span>''<cr>:w<cr>:silent ! mkdir -p ' . s:out_dir . '; pandoc -s --toc % -o ' . s:out_dir . '/%<.html<cr>:d<cr>:w<cr>:silent ! firefox ' . s:out_dir . '/%<.html\#VIMHERE<cr>' )
            "au BufRead,BufNewFile *.{md,rst} noremap <buffer> <F6> <ESC>:! mkdir -p _out; pandoc -s --toc % -o _out/%<.html; firefox _out/%<.html<cr>

            au BufEnter,BufRead *.{md,rst} cal MapAllBuff( '<F7>', ':w<cr>:sil ! make<cr>:sil ! make firefox RUN_NOEXT="%:r"<cr>' )

            "clean default output dir
            au BufEnter,BufRead *.{md,rst} cal MapAllBuff( '<S-F7>', ':sil !rm -r ' . s:out_dir . '<cr>' )
            au BufEnter,BufRead *.{md,rst} cal MapAllBuff( '<F8>', ':w<cr>:sil ! make<cr>:sil ! make okular  RUN_NOEXT="%:r"<cr>' )

        "#latex

            au FileType tex setlocal shiftwidth=4 tabstop=4

            au BufEnter,BufRead *.tex cal MapAllBuff( '<F5>'  , ':w<cr>:! cd `git rev-parse --show-toplevel` && make<cr>' )
            au BufEnter,BufRead *.tex cal MapAllBuff( '<S-F5>', ':w<cr>:! cd `git rev-parse --show-toplevel` && make clean<cr>' )
            au BufEnter,BufRead *.tex cal MapAllBuff( '<F6>'  , ':w<cr>:exe '':sil ! cd `git rev-parse --show-toplevel` && make view VIEW=''''"%:p"'''' LINE=''''"'' . line(".") . ''"''''''<cr>' )

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

    "#interpreted languages #python #bash #perl

        au FileType sh,python,perl setlocal shiftwidth=4 tabstop=4
        au FileType sh,python,perl cal MapAllBuff( '<F6>', ':w<cr>:cal RedirStdoutNewTabSingle( "./" . expand(''%'') )<cr>' )

    "#compile to executable languages

        "#c #c++ #cpp #lex #y #fortran #asm #s

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

        au FileType c,cpp,fortran,asm,s cal FileTypeCCpp()

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

"#maps

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

    "language specific mappings may be in language specific sections

    "#leader

        "set the current leader:

            "let mapleader = ','
            let mapleader = '\'

        "use current leader:

            "nn <leader>a b

        "redefining it after changing a mapping has no effect on already defined
        "maps, but will affect commands that are defined afterwards:

            "let mapleader = ','
            "noremap <leader>a b
            "let mapleader = '\'
            "noremap <leader>d e

        "here, `,a` and `\d` have gotten mappings!

    "#f keys

            cal MapAll( '<F2>',     ':NERDTreeToggle<cr>')
            cal MapAll( '<F3>',     ':cal GuakeNewTabHere()<cr>')
            cal MapAll( '<S-F3>',   ':ConqueTermTab bash<cr>')

    "#~

        "invert selection case:

            "vn ~

    "#@

        "do macro saved on a register:

            "noremap @a

        "redo last used macro:

            "noremap @@

    "##

        "noremap * backwards:

            "noremap #

    "#%

        "goes between open close pairs

            "nn %

            "h %

        "pairs are defind by:

            "set mps?

        "very useful command

        "individual pairs and more can be done with `[`

    "#^

        "go to first non whitespace char of line:

            "unmap ^

        "toogle between current and alternate file:

            "unmap c-^

    "#*

        "search for word under cursor
        "# for backwards

            "noremap *

        "replacement starts as current word (w) under cursor
        "(analogy to `*` which searches for word under cursor):

            nn <leader>* bve"zy:%s/<c-r>z/<c-r>z/g<left><left>

    "#(

        "- ( previous sentence
        "- ) next

        "what is a sentence?

        "something that ends in '.', '?' or '!'

           "h sentence

    "#tab

        "next and previous tab:

            cal MapAll( '<c-tab>',   ':tabnext<cr>' )
            cal MapAll( '<c-s-tab>', ':tabprevious<cr>' )

    "#q

        "start/end recording commands in register a:

            "nn qa

        "enter ex mode:

            "nn Q

        "same as command mode, except you can do several ex commands
        "without exiting ex command mode

        "visual block mode:

            "nn c-q

        "same as `c-v` in gvim, but used for terminal control

    "#w

        "move across windows:

            "<c-w>h
            "<c-w>j
            "<c-w>k
            "<c-w>l

        "rationale: better with a direct control key mapping.

        "close windows:

            "cal MapAll( '<c-w>', ':tabclose<cr>' )
            cal MapAll( '<c-w>', ':q<cr>' )
            "cal MapAll( '<c-w>', ':bd<cr>' )

    "#e

        "scrol up one line (don't move cursor (unless it would go out of view)):

            "nn <c-e>

        "mnemonic: Extra lines!!

        "accelerate vertical scroll down:

            "nn <c-E> 5<c-E>

    "#r

        "replace mode (insert but overwritting)
        "a bit useless

            "nn R

        "redo:

            "nn <c-R>

    "#t

        "like `f`, but stops right before char.

            "nn t

        "repeated uses do nothing

        "mnemonic: unTill

        "major use: delete untill char, but don't delete char. Ex:

        "buffer:

            "f(a,b,c,d)
            "  ^

        "you want to delete up to `d`, but keep the `)`

        "solution: `dt)`

        "tab navigation in normal mode
        "in terminal, alt tab is not possible,
        "but should be used in gvim instead.

            nn <leader>tt :tabe<space>
            nn <leader>tb :tabe<cr>:b<space>
            nn <leader>tm :tabm<space>

            "currently usint another shortcut for this:

                "nn <leader>tT :tabclose<cr>

    "#y

        "same as c-e, upwards:

            "nn <c-y>

        "mnemonic: close to c-u (on qwertyu)

        "same as yy:

            "nn Y

        "accelerate vertical scroll up

            "nn <c-Y> 5<c-Y>

        "copy line to system clipboard:

            nn yY ^v$"+y

    "#u

        "selection to lowercase:

            "vn u

        "selection to uppecase:

            "vn U

        "half page Up:

            "nn <c-u>

    "#i

        "inverse of <c-0>

        "nn <c-i>

    "#o

        "do one normal command and return to insert mode:

            "inoremap <c-o>:

        "go to last location you were at before jumping with commands lik `/` (:h jumplist)
        "may change buffers in cur window

            "nn <c-o>

        "go to the other extremity of visual selection:

            "vn o
            "vn O

        "on block visual mode, toogle up down corner with `o` and toogle left
        "right corner with `O`

    "#[

        "miscelaneous commands, mostly section motions

        "- } go to next     latex paragraph (double newline)
        "- {       previous

        "- ] go to next     section
        "- [       previous

        "what is a section? defined by `se sects?`.

            "h sect

        "- c-] go to location of link under cursor used in vim docs TODO how to make one of those?

        "- [( last unmatched open par. Same for ),[,],{,}.=, but not for <>
        "- [z fold move

    "#|

        "go to column number:

            "unmap \n|

    "#a

        "Increment integer number under the cursor!

            "<c-A>

        "pAste from system clipboard before cursor (in the same place as you would edit with 'i')

        "the pasted item is left selected in viusal mode if you want to indent it

        "so if you want to append to a Line to to insert mode first, 'A' to append and then <c-A>

        "does not affect any vim local register

        "rationale

        "- c-A not to conflict with c-v visual block mode or with terminal shortcuts

        "- is left hand only, allowing you to keep your right hand is no the mouse

        "- the default <c-a> command is not that useful

            cnoremap <c-A> <c-R>+
            inoremap <c-A> <ESC>"+p`[v`]
            nn <c-A> "+P`[v`]
            vn <c-A> d"+P`[v`]

    "#s

        "same as cl:

            "nn

        "useless.

        "substitude starting with selection/selection/:

            vn s "zy:%s/<c-r>z/<c-r>z/g<left><left>

        "substitude starting with selection//

            vn S "zy:%s/<c-r>z//g<left><left>

        "substitute on all file very magic:

            nn <leader><leader>s :%s/\v/g<left><left>

        "substitute on all file very non-magic:

            nn <leader><leader>S :%s/\V/g<left><left>

        "insert single char
        "can be repeated with `.`

            fu! RepeatChar(char, count)
                return repeat(a:char, a:count)
            endfu
            nn <silent> s :<c-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<cr>
            nn <silent> S :<c-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<cr>

        "type bd *.xml<c-S> to delete all xml buffers

            "cnoremap <c-S> <c-A>
    "#d

        "cut line to system clipboard:

            nn dD ^v$"+ygv

        "takes word under cursor
        "open in turrent window a file with same name as that word
        "searchs files under the special path variable (no g: prefix, but global)
        "  help path
        "looks in cur dir by default
        "usage: view header/inlcluded files

            "nn gf

    "#f

        "one screen Forward:

            "nn <c-f>

    "#g

        "leader for lots of miscelaneous commands

        "- gg: go to first line
        "- G:  go to last line
        "- {num}G:  go to line num
        "- ge: go to end of last word!
        "- gE:
        "- gv: go to visual mode and reselect previous visual selection.

            "also restores visual mode type (char, bloc, line)

            "you can also set that selection programatically:

                "call setpos("'<", [0, 2, 1])
                "call setpos("'>", [0, 3, 2])
                "normal! gv

        "- {num}gt: go to tab num 1 based.

        "select Go to last Pasted text (to indent, or delete for example)

            nn <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

        "show current file name and position:

            "nunmap <c-g>

        "useless if you have `se ruler`

    "I would rather have the capital H and L to go to
    "beginning or end of line
    "and J, K to jump 5 lines instead.
    "Also, I prefer to move along visual lines
    "rather than real lines ( thus the remap )

        "nn H ^
        "vn H ^

    "#j

        "use screen lines instead of real lines:

            nn j gj
            vn j gj

        "accelerate down

            nn J 5j
            vn J 5j

        "join lines:

            "unmap J

        "same as j:

            "nn <c-j> j

        "therefore useless.

    "#k

        "use screen lines instead of real lines:

            nn k gk
            vn k gk

        "accelerate up

            nn K 5k
            vn K 5k

        "search word under cursor using a given program:

            "unmap K

        "default is `man`

        "not *very* useful

        "nop:

            "map <c-k> <nop>

    "#l

        "nn L $
        "vn L $

    "#:

        "repeat last f, F, t or T (like n,N)

            "nn ;

        "enter command mode:

            "nn :

        "swap ';' and ':', dispensing shift to start commands:
            nn ; :
            nn : ;

        "noremap <c-;> asd

    "#z

        "remove useless zl that does single horizontal scroll:

            nn zl zL
            nn zh zH

        "open close fold under cursor:

            "unmap zo
            "unmap zc

        "recursivelly:

            "unmap zO
            "unmap zC

        "toogle fold:

            "unmap za
            "unmap zA

        "all folds (m more, M max, r reduce, R min)

            "unmap zm
            "unmap zM
            "unmap zr
            "unmap zR

        "move over folds:

            "unmap [z       "start  of current
            "unmap ]z       "end    of current
            "unmap zj       "start  of next
            "unmap zk       "end    of next

    "#x

        "decrement number under cursor (oposite of <c-a>)

            "nn <c-X>

        "cut to system clipboard

            vn X "+ygvd

    "#c

        "copy to system clipboard:

            vn C "+y

    "#m

        nn <c-M> <plugin>NERDComToggleComment<cr>
            "toggle coMMent

        "make mark a on cur buf

            "ma

        "mark A on all open buffers
        "go to opens that buffer in cur window:

            "mA

    "#<

        "keep selected after shift in visual mode

            vn < <gv
            vn > >gv

    "#/

        "search forwards:

            "nn /

        "very magic is more useful than normal:

            nn / /\v

    "#directionals

            inoremap <down> <c-o>gj
            inoremap <up> <c-o>g

        "move across windows:

            nn <c-left> <c-w>h
            nn <c-right> <c-w>l
            nn <c-up> <c-w>k
            nn <c-down> <c-w>j

        "rationale:

        "- control for repeated uses
        "- c-w is a bit useless, remap it to something better

"#sources

"#h

    "the most important of all commands

        "h
        "h map

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

    "are mostly ignored like in c, except for newlines!

        "ec 1
        "ec 2

    "therefore, you don't need `;` everythwere, but you need to get newlines
    "right

    "multiline commands in script: start *next* line with `\` backslash:

        "ec
        "\ 1

"#multiline commands

    "you can use the pipe char '|' to replace *some*, *but not all* newlines

        "ec 1 | ec 2

    "for example, does **not** work for function definitions:

        "fu F() | ec 1 | endf

"#scope

"- g: global
"- s:       local to current    script file
"- w:                           editor window
"- t:                           editor tab
"- b:                           editor buffer
"- l:                           function
"- a: a parameter of the current function
"- v: vim predefined

    "#sid

        "make helper functions or variables that are unique to the script
        "and cannot be called from outside

        "example, in a plugin:

            "fu! s:F()
                "retu 1
            "endf

            "nn <buffer> cal <SID>F()

        "now F can only be called as a helper inside the plugin
        "and not directly to users of the plugin.

        "the advantage of this is that you can make unique short names
        "for script only functions

"#variables

    "must use let always:

        "let a = 2 | if a != 2 | ec 'fail' | en

    "can redefine:

        "let a = "abc"
        "let a = 1

"#environment variables

    "just add a dollar `$`.

    "home variable, inherited from the calling environment:

        "ec $HOME

    "empty if not defined

    "some environment variables are given default values if undefined at startup:

    "shared root:

        "ec $VIM

    "TODO:

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

    "find item:

        if (index( [1,2], 1) != 0) | ec 'fail' | end
        if (index( [2,1], 1) != 1) | ec 'fail' | end
        if (index( [1,2], 3) >= 0) | ec 'fail' | end

    "contains:

        if (index( [1,2], 3) >= 0) | ec 'fail' | end

    "unpack (like python tuples):

        "let [a,b] = [1,2]
        "if a != 1 | ec 'fail' | en
        "if b != 2 | ec 'fail' | en

    "can be used to return multiple values from function

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

    "special chars

        "clike:

            "ec "\n"

        "control chars:

            "ec "\<s-v>"

        "appear like ^V

        "must use double quotes:

            "ec '\n'

        "outputs literal '\n'

    "compare:

        "note the insanity:

            "abc" ==# "Abc"	  "evaluates to 0
            "abc" ==? "Abc"	  "evaluates to 1
            "abc" == "Abc"	  "evaluates to 1 if 'ignorecase' is set, 0 otherwise

        "therefore: **always use either ==# or ==? when comparing strings!!**

    "concat:

        "if "ab" . "cd" != 'abcd' | ec 'fail' | en

    "string to int:

        "if 10  + "10"    != 20   | ec 'fail' | en
        "if 10  + "10.10" != 20   | ec 'fail' | en
        "if 1.1 + "1.1"   != 2.1  | ec 'fail' | en

    "substring

        "let a = 'abc'
        "if a[0]     != 'a'  | ec 'fail' | en
        "if a[0:1]   != 'ab' | ec 'fail' | en
        "if a[1:]    != 'bc' | ec 'fail' | en
        "if a[-1]    != 'c'  | ec 'fail' | en

    "equality:

        "if "ab" != "ab" | ec "fail" | en

    "test regex match:

        "if "ab" !~ "a." | ec "fail" | en

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

    "#boolean operations

        "all that matters is =0 or !=0:

            "if !0     != 1 | ec 'fail' | en
            "if !1     != 0 | ec 'fail' | en
            "if !-1    != 0 | ec 'fail' | en
            "if 0 && 1 != 0 | ec 'fail' | en
            "if 0 || 1 != 1 | ec 'fail' | en

"#for

        "for i in [1,3,2] | ec i | endfor

"#while

        "let i = 0
        "while i < 3
            "ec i
            "let i = i + 1
        "endwhile

    "there is no do-while loop

"#function

    "must start with uppercase char

    "'!' means can override existing func

    "cannot use | for single line

        "fu! F( a, b )
            "retu a:a + a:b
        "endf

        "if F( 1, 2 ) != 3 | ec 'fail' | en

    "nargs:

        "fu! F( a, b, ... )
            "for i in range( a:0 )
                "ec a:{i}
            "endfor
        "endf

    "a:0 contains the number of args
    "a:1 contains the first arg
    "...

    "#cal

        "command to call function

        "ignores return value

        "only side effects can be useful therefore

    "#multiple return values

        "fu! F()
            "retu [1,2]
        "endf

        "let [a,b] = F()
        "if [a,b] != [1,2] | ec 'fail' | en

    "no return val returns 0:

        "fu! F()
        "endf

        "if F() != 0 | ec 'fail' | en

    "#default values

        "concept does not exist in the language.

        "possible solution:

            "fu! F(a, ...)

                "if a:0 > 0
                    "let b = a:1
                "el
                    "let b = 0
                "en

                "if a:0 > 1
                    "let c = a:2
                "el
                    "let c = 0
                "en

            "endf

    "#assign function to a variable

        "must use the `function` function:

            "fu! F()
                "ret 1
            "endf

            "let A = function('F')

            ""ERROR: must be capital
                ""let a = function('F')

            "if A() != 1 | ec 'fail' | en

        "also works:

            "ec function('F')()
            "cal function('F')()

"#exceptions

    "throw:

        "th 'abc'

    "try catch finnaly:

        "try:
            "th 'abc'
        "cat: /a./
            "ec 'a.'
        "cat:
            "ec 'default'
        "fina:
            "ec 'finnally'
        "endt
"#so

    "exe from given file (Source)

    "source this file:

        "so %

    "any vim output (ex `ec 1`) done in that file will be interpreted as an error.

    "#fini

        "stop sourcing script

            "fini
            "ec 1

"#sil

    "ommit messages

    "multiline messages automatically require you to press enter:

    "no need for enter:

        "fu! F()
            "ec 1
        "endf

        "cal F()

    "needs enter:

        "fu! F2()
            "ec 1
            "ec 2
        "endf

        "cal F2()

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

    "excecute shell commands:

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

        "load buffer in the buffer list and make it visible in cur window

        "does not however add new buffers to the buffer list.

        "by number 2:

            "b 2

        "by path:

            "b file.txt

        "tab complete matches in middle of file paths.

        "if there is a single match for a substring of path, <enter> opens it.

    "#e

        "edit a file in current window

        "tab complete only shows file in current directory, not the buffer
        "list.

        "if a file is not already in a loaded buffer, it is added to the
        "buffer list and loaded

        "if a file is already on a loaded buffer and that buffer has no
        "changes, updates the buffers to match disk (in case for example that
        "the file was modified externally of vim)

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

    "#alternate file

        "then you open a buffer on top of another on a window,
        "for example with `:b`,
        "the old buffer is remembered and is called the *alternate file*

        "you can toogle between the current and alternate file with <c-*>

            ":b

        "this behaviour can be orverriden with `keepalt`.

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

        "call it at every startup (TODO does not work)

            "cal s:WipeBuffersWithoutFiles()

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

"#exe

    "execute string as a vim command

        "exe "let a = 10"
        "if

    "multiple args are concatenated separated by space:

        "exe "ec 1 |" "ec 1"

    "application: pass parameters to functions

"#norm

    "execute normal mode command:

        "norm dd

    "this does *not* leave current mode and goes to normal mode, unless you
    "tell it too
    "but has all the effects of useing the commnad on normal mode

    "

    "with [!] execute normal mode command without mappings activated:

        "map a b

    "b:

        "norm a

    "a:

        "norm! a

    "**always use this!!** unless you really want to use the user commands...
    "which is a rare case

    "multiple commands:

        "norm! jj

    "goes twice down

    "special chars:

        "exe "norm! \<s-v>"

    "goes to line visual mode

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

    "join current and next line:

        ":j

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

    "execute command automatically on an event.

    "#events

        "list events:

            "h event

        "two important events:

            "au BufEnter,BufRead *.c noremap a b

        "with those two, you can define mappings, options, functions or variables to any c file

    "#order

        "autocommands are always executed on the order that they are set thus:

            "au BufEnter,BufRead * echo 1
            "au BufEnter,BufRead * echo 2

        "will always echo 1 and then 2

            "au BufEnter,BufRead * echo 2
            "au BufEnter,BufRead * echo 1

        "will always echo 2 and then 1

    "#patterns

        "for many events except FileType, you can use the following patterns:

        "- *.py
        "- *.py,*.pl
        "- *.{py,pl}

        "for FileType, just enter enter the filetypes (`:se ft?`) comma separated:

            "au FileType c,cpp noremap a b

    "#aug

        "groups autocomands

        "you can later execute autocommands from a single chosen group afterwards
        "with `:do` or `:doautoall`

        "`au`s in a group are stil executed by default when the file is sourced

        "example: TODO get working

            "aug A
                "au BufEnter,BufRead * echo 1
                "au BufEnter,BufRead * echo 2
            "aug END
            "au BufEnter * echo 3

        "to do only groupa A use:

            "do A

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

        "just like `unmap`, **must** use the same version to override!

    "#unmap

        "rever a map to its vim default:

            "map a b
            "unmap a

        "**must** use same version to set/unset:

            "map! a b
            "unmap! a

            "inoremap a b
            "iunmap a

            "map <buffer> a b
            "map <buffer> a b

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

    "#options

        "- <buffer>: only map on cur buffer. Should always be used on ftplugins.

        "- <silent>: don't print the input command to screen. Command output is
            "still visible

                "fu! F()
                    "ec 1
                "endf

                "map            a :cal F()<cr>
                "map <silent>   a :cal F()<cr>

        "- <expr>: evaluate rhs and map to result

            "ex:

                "map <expr> x 'a' . 'b'

            "is the same as:

                "map <expr> x ab

    "#which keys can be mapped

        "TODO check and understand all of this... very confusing.

        "vim is designed to work on terminals without X server.

        "#must have standard terminal representation

            "only stuff that has a standard terminal representation can have mappings in vim

            "of course, it is up to your terminal to determine what maps to
            "what, but usually ^X is achieved via c-x (except for c-@)

            "#has standard terminal representation

                "- alpha (numbers are reserved for repeating motions)
                "- s-alphanum

                "- control

                    "- c-{alpha}
                    "- ^@
                    "- ^[
                    "- ^\
                    "- ^]
                    "- ^^[j]
                    "- ^_
                    "- ^?

                    "note: c-[ is the same as esc, but can be remapped.

                "- {F keys}
                "- s-{F keys}

                "- alt-{alphanum} Also called meta key.

                    "a, s-a, c-a, c-@...

            "#does not have standard terminal representation

                "those non-examples are dealt with in GUI programs by detecting that
                "one key is pressed while the other is down

                "however terminals cannot detect key up/down TODO confirm

                "- c-s-{key}
                "- c-a-{key}

        "#must not be a terminal control character

            "non-examples:

            "- c-c: terminate process
            "- c-s: stop foreground process
            "- c-q: resume after c-s
            "- c-z: stop foreground process and put it on background
            "- c-d: eof
            "- c-v c-X: enter a literal control char

    "#which keys are a good idea to map

        "very useful manual section:

            "h map-which-keys

        "summary:

        "- use `<c-` or `<s-` for commands that must be done repeatedly several times

            "instead of two key combinations like `<leaders>a`


"#bufdo #tabdo #windo
    "do a command on all *

"#set

    "control and view several vim options

        "h options

    "view value:

        "set ft?

    "set value on non boolean option:

        "set ft=vim

    "set value of boolean option to true:

        "set expandtab

    "set value of boolean option to false:

        "set expandtab

    "toogle value (only applicable to boolean options):

        "set wrapscan!

    "get value of option programatically:

        "ec &ft

    "just add ampersand.

    "- nomodified

        "as if the buffer hadn't been modified

    "#setl

        "sets option only for cur buffer

        "only some options can have local values.

        "should always be used instead of `:se` in ftplugin files.

"#builtin functions

    "#file operations

        "check file exists and is radable:

            "if filereadable("SpecificFile")
                    "ec "SpecificFile exists"
            "en

        "dirname

            "for a file or directory not enting in slash:

                "if fnamemodify( '/a/b', ':h') != '/a' | ec 'fail' | endif
                "if fnamemodify( '/a/b/', ':h') != '/a/b' | ec 'fail' | endif

            "whatch out for trailling slashes since that changes the meaning...

            "don't use `:p` since this makes no sense and does not work if the path does not exists!

        "ls path

            ":echo globpath(path, '*')

        "find .:

            ":echo split(globpath('.', '**'), '\n')

        "os path join: vim autoconverts `/` in paths to the correct os separator (ex Windows `\`)

    "#expand

        "ec expand('%:r')

        "see:

            "h filename-modifiers

        "for the possible things you can expand

    "#position

        "get cur line number:

            "ec line(".")

        "get last line in buffer:

            "ec line("$")

        "get first line of last visual selection:

            "ec line("'<")

        "last one:

            "ec line("'>")

        "get cur column

            "ec column(".")

        "get cur line number, column, buffer

            "getpos():

        "returns:

            "[bufnum, lnum, col, off]

        "setpos() with same args to set (last can be ommitted):

            "setpos (0,2,3)

        "if buf number 0 means in current buffer

        "another way to set position:

            "cursor(line,col)

        "get initial position while on visual mode:

            "getpos("'<")

        "set visual selection position from function:

            ""put user in visual mode and set the visual selection
            ""
            ""if arguments are not valid, nothing is changed, and raises an exception
            ""
            "":param 1:
            ""
            ""    Visual mode to leave user in.
            ""
            ""    must be either one of:
            ""
            ""    - 'v' for visual (default)
            ""    - "\<s-v>" for line visual
            ""    - "\<c-v>" for block visual
            "":type 1: string
            ""
            "":returns: 0
            ""
            "":raises: bad mode argument, bad position argument
            ""
            "fu! SetSelection( x, y, x2, y2, ... )
                "let valid_mode_strings = ["v","\<s-v>","\<c-v>"]

                "if a:0 > 0
                    "if index( valid_mode_strings, a:1 ) >= 0
                        "let mode = a:1
                    "el
                        "th 'bad mode argument: ' . a:1 . ' valid options: ' . join( valid_mode_strings, ', ' )
                    "en
                "el
                    "let mode = 'v'
                "en

                "let oldpos = getpos('.')

                "if setpos( '.', [0,a:x,a:y] ) != 0
                    "exe "norm! \<esc>"
                    "th 'bad position argument: ' . a:x . ' ' . a:y . ' ' . a:x2 . ' ' . a:y2
                "en

                "exe 'norm! ' . mode

                "if setpos( '.', [0,a:x2,a:y2] ) != 0
                    "exe "norm! \<esc>"
                    "cal setpos( '.', oldpos )
                    "th 'bad position argument: ' . a:x . ' ' . a:y . ' ' . a:x2 . ' ' . a:y2
                "en
            "endf

    "#mode()

        "get current mode representation string:

            "ec mode()

        "set mode: TODO is this the best way?

            "exe "norm! " . mode()

    "#visualmode()

        "get string representing type of last visual mode on cur buffer:

        "- v:   charcter
        "- V:   line
        "- ^V:  block

        "this can be used with `norm` to set back to last visual mode:

            "exe 'norm! ' . visualmode()

    "#buffer content

        "get content of cur line:

            "ec getline(".")

        "get all lines from to:

            "ec getline(1,3)

        "get all lines of buffer:

            "ec getline(1, line("$"))

        "returns a list of lines

    "#search

        "same as '\' but:

        "- is a function
        "- does not set last jump mark (for use with `<c-o>` for example)

        "returns:

        "- line number if match
        "- 0 if no match

        "it is therefore preferable in vimscript.

            "cal search('a')
            "cal search('\va')

        "don't move cursor:

            "cal search( 'a', 'n' )

        "backwards:

            "cal search('a','b')

        "wrap around end (default):

            "cal search('a','w')

        "don't wrap around end:

            "cal search('a','W')

        "end of match:

            "cal search('ab','e')

        "stops at 'b' instead of 'a'

        "start search from under cursor

            "cal search('a','c')

        "by default, if you are over an 'a' char and to search a,
        "you will move to next match. But not with 'c'.

        "get column too:

            "searchpos('a')

        "get line and pos of match start and end:

            "TODO

        "search for pairs like 'if' 'else':

            "searchpair(TODO)

    "#getreg

        "get value of a register into vimscript

        "norm '"ay'
        "ec getreg('a')

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

    "for explanations

        ":h regex

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

    "#classes

        "- \w   alpha (a-zA-z)
        "- \n     a newline character (line ending)
        "- \s   whitespace except newline
        "- \S   non-whitespace
        "- \_s     a whitespace (space or tab) or newline character
        "- \_^     the beginning of a line (zero width)
        "- \_$     the end of a line (zero width)
        "- \_.     any character including a newline

    "# escaping in default mode

        "if you really use default mode, here the escape list follows.

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

    "#perldo

        "if compiled with perl support (`vim --version | grep perl`),
        "you can use perld for replacements

        "ex:

            ":pe $a = 'b'
            ":perldo s/$a(.)/c\1/g

        "so you get perl regexes

    "#s

        "capture group:

            ":s/\(a\)/\1/

        "set first letter of each line to uppercase:

            ":s/.*/\u&

        "sets first letter of each line to lowercase:

            ":s/.*/\l&

        "#multiline

            "`\n` vs `\r` confusion: <http://stackoverflow.com/questions/71417/why-is-r-a-newline-for-vim>

            "when searching `\n` is a newline char, `\r` <CR>

            "when replacing `\n` is the null byte and `\r` a newline char

            "replace two or more newlinews for two newlines:

                ":%s/\n\n+/\r\r/

        "confirm each match replace before doing it:

            ":%s/a/a/c

        "- y: yes
        "- n: no
        "- a: replace all remaining
        "- q: quit
        "- l: last == yes and quit

    "#substitute

        "regex replace in vimscript

            "if substitute( 'abc', 'a\(.\)c', '\1', '' ) != 'b' | ec 'fail' | en

        "todo: how to use magic

            "if substitute( '\vabc', 'a(.)c', '\1', '' ) != 'b' | ec 'fail' | en

    "#match

        "get start of match index:

            "if match( 'abc', '\v.c' ) != 1 | ec 'fail' | en
            "if match( 'abc', '\v.b' ) != 0 | ec 'fail' | en

    "#matchstr

        "get matching string

            "if matchstr( 'abc', '\v.c' ) != 'bc' | ec 'fail' | en
            "if matchstr( 'abc', '\v.b' ) != 'ab' | ec 'fail' | en

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

"#python vim scripting

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

    "#vim to python

        "evaluate a vim expression and get its result into python

        "returns:

        "- a string if the Vim expression evaluates to a string or number
        "- a list if the Vim expression evaluates to a Vim list
        "- a dictionary if the Vim expression evaluates to a Vim dictionary

        "pass a vim integer variable to python:

            ":let a = 1
            ":py a = int( vim.eval('a') )
            ":py assert a + 1 == 2

    "#python to vim

        "

    "multiline python code:

"py << EOF
"def f():
    "print 1
"EOF

    "fu! PythonTest()
        "py f()
    "endf

"#vim configuration

    "<http://www.22ideastreet.com/debug/vim-directory-structure/>

    "help on startup sequence:

        ":h startup

    "show all scripts that are run and their order:

        ":scriptnames

    "#verb

        "verbose info on commands

        "often shows which file last set something!

        "very useful to debug.

        "maps:

            "verb map a

        "options:

            "verb set ft?

    "#plugins

        "one very important thing that is executed **after** reading `.vimrc`:

            ":runtime! plugin/**/*.vim

        "this is how plugins are loaded automatically.

    "#runtimepath #rtp

            "set rtp?

        "a vim source path

        "comma separated list of palces where TODO

        "important stuff that is there by default on linux:

        "- `/usr/share/vim` and some subdirs. Installation default.
        "- `~/.vim/`.       User managed.
        "- `~/.vim/after/`. User managed. Comes after plugins.

        "#ru

            "- search in rtp
            "- so all files found
            "- no error if non found
            "- wildcards work:

                ":ru plutin/*.vim

"#ftplugin

    "plugins that au sources only for particular types of files

        "h ftplugin

    "for those to work, you must first detect the type of file:

    "#detect filetype manually

        "typical methods:

        "- by extension
        "- by file contents (shebangs tipically)

        "get current filetype:

            "set ft?

        "obviously, this is a local option.

        "set current filetype:

            "setl ft=python

        "this is typically done as an `au BufNewFile,BufRead`, but you could to it manually to to test.

    "#default filetype detection

        "vim does detection for a bunch of file types by default.

        "show detection, plugin and indent status:

            "filet

        "turn on filetype detection:

            "filet on

        "this ources $VIMRUNTIME/filetype.vim, which in short does lots of
        "au for lots of known file types.

        "detect filetype for current file again using the default scripts:

            "filetype detect

    "#create new filetype

        "very well explained here:

            "h new-filetype

    "#default ftplugin sourcing

        "vim comes with good defaults for loading plugins only for given filetypes.

        "turn on ftplugins detection:

            "ftplugin on

        "this ources $VIMRUNTIME/ftplugin.vim
        "which in short executes all files inside

            ":ru! /ftplugin/

        "with vim extensions .vim in this directory and subdirectories

        "when the buffer of the right filetype enters.

        "for example for `c` files the following would all be sourced (in alphabetical path order)

            "c.vim
            "c_extra.vim
            "c/settings.vim

        "'_' is required to separate c form the arbitrary rest of the name

        "as explained in the help:

        "- always use setlocal      instead of set
        "-            map <buffer>             map

    "#override defaults

        "the simplest way is to  create an ftplugin file and put it inside
        "after/ftplugin

        "this however is a pain because you have to keep many separate files.

    "#default indent sourcing

        "exact same idea as ftplugin, but replace plugin by indent.

"#find

    ":find
    ":sfind
    ":tabfind
    "find in vim path var, and edit here, split, new tab

"#ftp

    "vim has built-in ftp! =)

    "open file browser:

        "vim ftp://username@host:port/

    "you will be asked for password

    "navigate file browser (TODO):

    "open file:

        "vim ftp://username@host:port/path/to/file.html

"#tags

    "<http://vim.wikia.com/wiki/Browsing_programs_with_tags>

    "List and jump to definitions of functions or variables.

    "#generate tags

        "Before jumping to tags, you have to generate them with an external program.

        "tags must be placed in a file called tags in the current directory (TODO check)

        "`tags` is a POSIX possibility. `exuberant-ctags` is more complete non standard possibility

        "Generate tags in all subdirs POSIX 7 compliant:

            "for d in `find . -type d`; do cd $d && ctags *.h; done

        "TODO write an append code for this that puts tags on current dir.

        "Using gnu ctags:

            "ctags -R

        "Will generate a t

    "Jump to first tag whose name is the same as the word currently under the cursor:

        "<c-]>

    "Note that there may be multiple tags with the same name, in special the
    "definition and other declarations.

    "Jump to next or previous tag found with last jump command:

        ":tn
        ":tp

    "If there is more than one tag, show a tag list, else jump:

        "g <c-]>

    "Jump to tag with given name:

        ":ta dentry
