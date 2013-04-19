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

"plugins
    "vundle. plugin manager.
    "
    "to install plugin, place line Bundle 'gitrepouser/reponame' and run
    "BundleInstall

    filetype off
        "required!

    set rtp+=~/.vim/bundle/vundle/
    cal vundle#rc()

    "let Vundle manage Vundle
    "The
        Bundle 'gmarik/vundle'

    "fugitive
        Bundle 'tpope/vim-fugitive'

    "easymotion.

        "to understand this, do <leader><leader>w ...
        Bundle 'Lokaltog/vim-easymotion'

    Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

    Bundle 'tpope/vim-rails.git'

        "comment handling. notably, the default <leader>c<space> toogles
        "comments
        Bundle 'scrooloose/nerdcommenter'

    "nerdtree
        Bundle 'scrooloose/nerdtree'
        "let NERDTreeKeepTreeInNewTab=0
        "let loaded_nerd_tree=1  "stop opening nerd tree.
        "delete all bookmarks: ``rm ~/.NERDtreebookmarks``

    "vim-session
        "allows me to load last session automatically...
        Bundle 'xolox/vim-session'
        let g:session_default_to_last = 1
        let g:session_autosave = 'yes'
        let g:session_autoload = 'yes'

    "newcomplcache. hardcore autocompletion.
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


        "<CR>: close popup
        "<s-CR>: close popup and save indent.
        inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
        inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup() "\<CR>": "\<CR>"
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

    "vim-markdown
        "syntax highlight
        "code folding
        Bundle 'plasticboy/vim-markdown'


    "msanders/snipmate.vim
        "allow you to define snippets: inster pieces of code, and then jump to
        "the point you want with tab. Also allows to force several placeholders
        "to be equal.
        Bundle 'msanders/snipmate.vim'

    "vim-scripts repos
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
    colorscheme vividchalk
        "colorscheme
    set guifont=9
        "font size

    "line numbers
        "set nonumber
        set number

    "line wrapping
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

    set ruler
    set noruler
        "at the right bottom I can see line, column and percentage of current file
        "in the same space for commands

    "buffers
        "The current buffer can be put to the background without writing to disk
        "When a background buffer becomes current again, marks and undo-history are remembered.
        "from http://items.sjbach.com/319/configuring-vim-right
        "set hidden
        "too dangerous!
        "
        ":au BufAdd,BufNewFile,BufRead * nested tab sball

    "tabs
        set guitablabel=%N)\ %t\ %M
        "format tab titles

    "gvim
        :set guioptions-=m  "remove menu bar
        :set guioptions-=T  "remove toolbar
        :set guioptions-=r  "remove right-hand scroll bar
        :set guioptions-=b  "remove right-hand scroll bar


"editing
    "allow backspacing over everything in insert mode
        set backspace=indent,eol,start

    "indentation
        set expandtab     "insert spaces instead of tabs
        set tabstop=4     "a tab is four spaces
        set shiftwidth=4  "number of spaces to use for autoindenting
        set autoindent    "always set autoindenting on
        set copyindent    "copy the previous indentation on autoindenting
        set shiftround    "use multiple of shiftwidth when indenting with '<' and '>'
        set smarttab      "insert tabs on the start of a line according to
                                            " shiftwidth, not tabstop

    "folding
        set foldmethod=indent   "fold based on indent
        set foldnestmax=3       "deepest fold is 10 levels
        set nofoldenable        "dont fold by default
        set foldlevel=3         "this is just what i use

    "conceal: the thing that renders greek, underline, etc
        "g:tex_conceal=""
        "stop it!!
        set cole=0

    "search
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

    "sources file if it is readable
    func! SoIfReadable(f)
        if filereadable(a:f)
            exe "so " . a:f
        en
    endf

    au BufRead,BufNewFile * cal SoIfReadable('so.vim')
        "sources ./proj.vim if it exists on file open
        "allows to define project specific mappings for example
        "this comes after FileType, and thus has higher precedence

    "#language speficif

        "to be split up into ftplugin if gest too large.
        "ftplugin.after is read after ftplugin, so you are sure that your
        "settings will be left after the distro's default

        "#data languages

        "#html

            au FileType html setlocal shiftwidth=4 tabstop=4
            au BufEnter,BufRead *.html cal MapAllBuff( '<F6>', ':w<CR>:sil ! firefox %<CR>' )

        "#compilable markup

            "#md #rst

                "au FileType *.md setlocal shiftwidth=4 tabstop=4
                au BufEnter,BufRead *.{md,rst} setlocal shiftwidth=4 tabstop=4
                au BufEnter,BufRead *.{md,rst} setlocal filetype=text
                au BufEnter,BufRead *.{md,rst} cal MapAllBuff( '<F5>', 'w<CR>:sil ! make<CR>' )

                au BufEnter,BufRead *.md  cal MapAllBuff( '<F6>', ':pu=''<span id=\"VIMHERE\"></span>''<CR>:w<CR>:sil ! make<CR>:d<CR>:w<CR>:sil ! make firefox RUN_NOEXT="%:r" ID="\#VIMHERE"<CR>' )
                "TODO this is broken still:
                au BufEnter,BufRead *.rst cal MapAllBuff( '<F6>', 'o<CR><ESC>k:pu=''.. _vimhere:''<CR>:w<CR>:sil ! make<CR>k:d<CR>:d<CR>:d<CR>:w<CR>:sil ! make firefox RUN_NOEXT="%:r" ID="\#vimhere"<CR>' )
                "au BufEnter,BufRead *.{md,rst} cal MapAllBuff( '<F6>', ':pu=''<span id=\"VIMHERE\"></span>''<CR>:w<CR>:silent ! mkdir -p _out; pandoc -s --toc % -o _out/%<.html<CR>:d<CR>:w<CR>:silent ! firefox _out/%<.html\#VIMHERE<CR>' )
                "au BufRead,BufNewFile *.{md,rst} noremap <buffer> <F6> <ESC>:! mkdir -p _out; pandoc -s --toc % -o _out/%<.html; firefox _out/%<.html<CR>

                au BufEnter,BufRead *.{md,rst} cal MapAllBuff( '<F7>', ':w<CR>:sil ! make<CR>:sil ! make firefox RUN_NOEXT="%:r"<CR>' )
                au BufEnter,BufRead *.{md,rst} cal MapAllBuff( '<F8>', ':w<CR>:sil ! make<CR>:sil ! make okular  RUN_NOEXT="%:r"<CR>' )

            "#latex


                au FileType tex setlocal shiftwidth=2 tabstop=2

                au BufEnter,BufRead *.tex cal MapAllBuff( '<F5>'  , ':w<CR>:! make<CR>' )
                au BufEnter,BufRead *.tex cal MapAllBuff( '<S-F5>', ':w<CR>:sil ! make clean<CR>' )
                au BufEnter,BufRead *.tex cal MapAllBuff( '<F6>'  , ':w<CR>:exe '':sil ! make run VIEW=''''"%:r"'''' LINE=''''"'' . line(".") . ''"''''''<CR>' )

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
                "au BufEnter,BufRead *.tex cal MapAllBuff( '<F4>', ':cal LatexForwardOkular("_out/")<CR>' )

        "#interpreted languages #python #bash

            au FileType python setlocal shiftwidth=4 tabstop=4

            au FileType python,sh cal MapAllBuff( '<F6>', ':w<CR>:cal RedirStdoutNewTabSingle( "./" . expand(''%'') )<CR>' )

        "#compile to executable languages

            "#c #cpp #lex #y #fortran #asm

            fu! FileTypeCCpp()
                cal MapAllBuff( '<F5>'  , ':w<CR>:make<CR>' ) "vim make quickfix
                cal MapAllBuff( '<S-F5>', ':w<CR>:sil ! make clean<CR>' )
                cal MapAllBuff( '<F6>'  , ':w<CR>:cal RedirStdoutNewTabSingle("make run")<CR>' )
                    "make run, stdout to a new file
                    "stdout is only seen when program stops.
                cal MapAllBuff( '<S-F6>', ':w<CR>:cal RedirStdoutNewTabSingle("make run RUN_ARGS=''\"\"''")<LEFT><LEFT><LEFT><LEFT><LEFT>' )
                    "same as above, but may pas command line args
                cal MapAllBuff( '<F7>'  , ':cnext<CR>' )
                cal MapAllBuff( '<F8>'  , ':cprevious<CR>' )
                cal MapAllBuff( '<F9>'  , ':w<CR>:cal RedirStdoutNewTabSingle("make profile")<CR>' )
                cal MapAllBuff( '<S-F9>', ':w<CR>:! make assembler<CR>' )
            endf

            au FileType c,cpp,fortran,asm cal FileTypeCCpp()

            au FileType c,cpp,asm setlocal shiftwidth=4 tabstop=4
            au BufEnter,BufRead *.{l,lex,y} setlocal shiftwidth=4 tabstop=4

            "because fortran has a max line length...
            au FileType fortran setlocal shiftwidth=2 tabstop=2

        "#vimscript

            "reaload all visible buffers. TODO: multiple windows per tabpage.
            fu! ReloadVisible()
                set noconfirm
                tabdo e
                set confirm
            endfu

            au FileType vim setlocal shiftwidth=2 tabstop=2
            "this will write all buffers, source this vimrc, and reaload open
            "buffers so that changes in vimrc are applied
            au FileType vim noremap <buffer> <F5> :wa<CR>:so %<CR>:sil cal ReloadVisible()<CR>

"#key bindings

    "here I put every mapping that I have made
    "that is not language specific
    "sorted by qwert order so that it is easy to find:
    "
    "Esc F1-F12
    "1234567890
    "qwertyuiop[]
    "asdfghjkl;'\
    "zxcvbnm,./

    "<leader> will become a ','. easier to type
    let mapleader = ","

    cal MapAll('<F2>',':NERDTreeToggle<CR>')
    cal MapAll('<F3>',':cal GuakeNewTabHere()<CR>')
    cal MapAll('<S-F3>',':ConqueTermTab bash<CR>')

    "noremap @a
        "macro saved on a register
    "noremap @@
        "redo last used macro

    "noremap #
        "noremap * backwards

    "noremap *
        "search for word under cursor
        "# for backwards

    "vnoremap ~
        "invert case

    inoremap <C-tab> <ESC>:tabnext<cr>
    nnoremap <C-tab> :tabnext<cr>
    vnoremap <C-tab> <ESC>:tabnext<cr>

    inoremap <C-S-tab> <ESC>:tabprevious<cr>
    nnoremap <C-S-tab> :tabprevious<cr>
    vnoremap <C-S-tab> <ESC>:tabprevious<cr>

    inoremap <C-w> <ESC>:tabclose<cr>
    nnoremap <C-w> :tabclose<cr>
    vnoremap <C-w> <ESC>:tabclose<cr>

    nnoremap <C-E> 5<C-E>
        "accelerate vertical scroll down

    nnoremap <C-Y> 5<C-Y>
        "accelerate vertical scroll up

        "select what to replace, type replacement, hit enter
        "detroys Z register

    "nnoremap R
        "redo u
    nnoremap R bve"zy:%s/\v<C-r>z/<C-r>z/g<left><left>
        "replacement starts as current word (w) under cursor
    vnoremap R "zy:%s/\v<C-r>z//g<left><left>
        "replace selection
    "nnoremap <C-R> BvE"zy:%s/<C-r>z/<C-r>z/g<left><left>
        "replacement starts as current word (W) under cursor
    vnoremap <C-R> "zy:%s/<C-r>z/<C-r>z/g<left><left>
        "replacement starts as current selection

    nnoremap tf :tabfirst<CR>
    nnoremap tl :tablast<CR>
    nnoremap tt :tabedit<Space>
    nnoremap tT :tabclose<CR>
    nnoremap tn :tabnew<CR>
    nnoremap tm :tabm<Space>
        "tab navigation in normal mode
        "in terminal, alt tab is not possible,
        "but should be used in gvim instead.

    nnoremap yY ^v$"+y
        "copy line to system clipboard

    nnoremap <C-Y> 5<C-Y>
        "accelerate vertical scroll up

    "vnoremap u
        "to lowercase
    "vnoremap U
        "to uppecase

    "nnoremap <C-i>
        "inverse

    "inoremap <C-o>:
        "do one normal command and return
    "nnoremap <C-o>
        "go to last location(:h jumplist)
        "may change buffers in cur window
        "<C-i> to inverse

    "{       previous
    "} go to next     latex paragraph (double newline)

    "<C-A>
        "Increment number under the cursor
    cnoremap <C-A> <C-R>+
    inoremap <C-A> <ESC>"+p`[v`]
    nnoremap <C-A> "+P`[v`]
    vnoremap <C-A> d"+P`[v`]
        "pAste from system clipboard before cursor (in the same place as you would edit with 'i')
        "the pasted item is selected in viusal mode if you want to indent it
        "so if you want to append to a Line to to insert mode first, 'A' to append and then <C-A>
        "does not affect vim local register
        "A not to conflict with c-v visual block mode or with terminal shortcuts
        "and is left hand only, allowing you to keep your right hand is no the mouse

    fu! RepeatChar(char, count)
      return repeat(a:char, a:count)
    endfu
    nnoremap <silent> s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
    nnoremap <silent> S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>
        "insert Single char and return to normal mode

    cnoremap <C-S> <C-A>
    "type bd *.xml<C-S> to delete all xml buffers

    "cut line to clipboard
    nnoremap dD ^v$"+ygv

    "gf
        "takes word under cursor
        "open in turrent window a file with same name as that word
        "searchs files under the special path variable (no g: prefix, but global)
        "  help path
        "looks in cur dir by default
        "usage: view header/inlcluded files

    "select Go to last Pasted text (to indent, or delete for example)
    nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

    "i use J for something else:
    nnoremap <C-k> J

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
    nnoremap k gk
    vnoremap k gk
    nnoremap K 4gk
    vnoremap K 4gk
    nnoremap L $
    vnoremap L $

    nnoremap ; :
        "remap ';' to ':', dispensing shift to start commands

    nnoremap zl zL
    nnoremap zh zH
        "remove useless zl that does single horizontal scroll

    "nnoremap <C-X>
        "decrement number under cursor!
    vnoremap X "+ygvd
        "cut to system clipboard

    vnoremap X "+ygvd
        "cut to system clipboard

    vnoremap C "+y
        "copy to system clipboard  "

    nnoremap <C-M> <plugin>NERDComToggleComment<CR>
        "toggle coMMent

    "ma
        "mark a on cur buf
    "mA
        "mark A on all open buffers
        "go to opens that buffer in cur buffer

    vnoremap < <gv
    vnoremap > >gv
        "keep selected after shift in visual mode

    nnoremap / /\v
    "cnoremap %s/ %s/\v

    inoremap <Down> <C-o>gj
    inoremap <Up> <C-o>g

    nnoremap <C-left> <C-w>h
    nnoremap <C-right> <C-w>l
    nnoremap <C-up> <C-w>k
    nnoremap <C-down> <C-w>j

    "noremap /<regex>
        "search for regex on cur buf
        "navigation:
            "n    next
            "N    previous
            "ggn  first
            "GN   last

"#sources

"- <http://andrewscala.com/vimscript/>

    "a few good straight to the point, important vimscript tips

"- http://www.ibm.com/developerworks/linux/library/l-vim-script-1/index.html

      "begginner tuts on vimscript

"#comments

    "start with '"'

"#spaces

    "are ignored like in c, except for newlines:

        "ec 1
        "ec 2

"#multiline commands

    "you can use the pipe char '|' to replace *some*, *but not all* newlines

        "ec 1 | ec 2

    "does not work for function definitions for example:

        ""fu F() | ec 1 | endf

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

":browse
    "open default system file browser popup

"#sil

    ":sil ls
    ":sil idontexist
        "silent, but shows vim errors

    ":sil! ls
    ":sil! idontexist
        "silent, don't show errors

    "there must be no space between '!' and sil!! otherwise sh command:

        ":sil ! ls
        ":sil ! idontexist

    ":sil! ! ls
    ":sil! ! idontexist

"#redir

    "redirect output of any *vim command* (ex :ec 1) output (for sh stdout (:! ls), use <#:r> )

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

"#shell

    "exclamation mark:

        "! ls; ls

    "#pass vim variable to bash command:

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

"let a = "adsf"
"put = a
    "paste variable into buffer

":find
":sfind
":tabfind
    "find in vim path var, and edit here, split, new tab

"#file operations

    ":q
        "close cur buffer
        "does not delete it from buffer list

    ":qa
        "close all windows

    ":on

        "close all windows except cur one

    ":w
        "save cur buffer
        "if file does not exit, create it

    "#buffers

        ":ls
            "list buffers

        ":b 2
            "load buffer 2
        ":b file.txt
            "load buffer file.txt
            "tab complete matches in middle

        ":sb 1
            "same as b, but split

        ":badd f1.txt
            "add buffer without loading it

        ":bd f1.txt
              "delete buffer by filename
        ":bd 12
              "delete buffer by number
        ":bd 3 4 5
        ":3,5bd
            "delete from 3 to 5

"execute normal mode commands:

    ":norm dd

"editing commands

    ":p
        "prints lines to command line

    ":pu='abc'
        "inserts abc on a new line after current line
    ":pu a
        "inserts content of register a
    ":pu! a
        "before cur line

    ":r file.md
          "inserts file here
    ":r !ls
        "inserts stdout in current line (read)

    ":d
        "delete cur line, put it on register

    ":y
        "yank
    ":y a
        "yank to register a

    ":s
        ":s/re/sub
            "sub
        ":s/re/sub/g
            "global
        ":s/re/sub/c
            "confirm before

    ":3t5
        "copy line 3 to line 5

    ":3m5
        "move line 3 to line 5

    ":g/re/p
        "global if line matches re

    ":g/^pattern/s/$/mytext
        "do s in each line that matches pattern

    "#ranges

        ":1,2d
        "deletes lines 1 and 2

        ".+1,$
        "cur line to end

        ":1,.-1d
        "delete all lines before the current line

        "%d
        "same as 1,$

        ":'a,'bd
        "delete lines from mark a to mark b, inclusive

        "/pattern/     next line where pattern matches
        "?pattern?     previous line where pattern matches
        "\/     next line where the previously used search pattern matches
        "\?     previous line where the previously used search pattern matches
        "\&     next line where the previously used substitute pattern matches
        "0;/that     first line containing "that" (also matches in the first line)
        "1;/that     first line after line 1 containing "that"

        "http://vim.wikia.com/wiki/Ranges

"autocommand au

    "<http://www.ibm.com/developerworks/linux/library/l-vim-script-5/index.html>

    "patterns:
      "*.py
      "*.py,*.pl
      "*.{py,pl}

"#map

    "map
          "command creates a key map that works in normal, visual, select and operator pending modes.
    "map!
          "command creates a key map that works in insert and command-line mode.

"#bufdo #tabdo #windo
    "do a command on all *

"#set

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
        "map a :ec expand('%')<CR>
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

"#quickfix

    "- :make    creates the error list
    "- :copen   open error list in window
    "- :cc      see the current error
    "- :cn      next error
    "- :cp      previous error
    "- :clist   list all errors

"#command

    "view existing and create new commands

    "`!` creates new. must start uppercase
    "command! -nargs=+ -complete=command Func call Func(<q-args>)
    "define a user command from a function
    "now you can cal  Func as df

    "com! -nargs=1 Pd :perldo

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
