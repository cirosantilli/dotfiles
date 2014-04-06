"#my functions

        " Executes shell cmd and redirects output to a new unnammed buffer in
        " a new tab next to the current one.
        "
        function! RedirStdoutNewTabSingle(cmd)
            tabnext
            if expand('%:p') != ""
                tabprevious
                execute "tabnew"
                setlocal buftype=nofile
                setlocal bufhidden=wipe
                setlocal noswapfile
            endif
            %delete
            execute "silent read !" . a:cmd
            set nomodified
        endfunction
        "command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

        " Map on all modes
        "
        function! MapAll(keys, rhs)
            exe 'noremap' a:keys a:rhs
            exe 'noremap!' a:keys '<ESC>'.a:rhs
        endfunction

        " Map on all modes in current buffer
        "
        function! MapAllBuff(keys, rhs)
            exe 'noremap <buffer>' a:keys a:rhs
            exe 'noremap! <buffer>' a:keys '<ESC>'.a:rhs
        endfunction

        " Open new Guake tab in cur dir
        "
        function! GuakeNewTabHere()
            exe ':sil ! guake -n ' . expand("%:p:h") . ' && guake -r ' . expand("%:p:h:t") . ' && guake -t'
        endfunction

        " Run cmd in guake tab.
        "
        " If done once already, reuses same tab for other cmds.
        "
        " This tab is named GVIM.
        "
        " Number of this tab is stored in g:guakeTab
        "
        " If the tab gets closed, there is currently no way simple to detect it, and this method breaks.
        "
        let g:guakeTab = ""
        function! GuakeSingleTabCmdHere(cmd)
            if g:guakeTab == ""
                sil ! guake -n ~; guake -r "GVIM"
                    "create new tab
                let g:guakeTab = substitute(system('guake -g 2>/dev/null'), '[\n\r]', '', 'g')
                    "store its number
            end
        "
"
"
"
    exe 'sil ! guake -s ' . g:guakeTab . ' && guake -e cd ' . expand("%:p:h") . ' && guake -e ' . a:cmd . ' && guake -t'
                "execute command on the new tab
        endfunction

        function! EchoReadable()
            if ! filereadable(expand('%:p'))
                echo expand('%:p')
                bdelete expand('%:p')
            end
        endfunction

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
        function! CodeToMd(comment)

            "for each removed indent, add a header level
            let a:find = '\v^(\s*)    (' . a:comment . '#+)'
            for a:n in range(line("'<"), line("'>"))
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

"#plugins

    "#vundle

        " Plugin manager.

        " Install:

            "sudo aptitude install -y vim git
            "git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
            "vim +PluginInstall +qall

        " Concurrence to Pathogen. Seems to be winning.

        " Use this! Easy install and plugin update via single vimrc lines + git or github repos.

        " View all avaliable bundles (searches github?):

            "Plugins

        "#install plugin

            " Add to `.vimrc`:

                "Plugin 'gitrepouser/reponame'

            " and run:

                "`PluginInstall`

        " Update all installed plugins:

            "PluginInstall!

        " Remove a plugin:

        " Required:
        filetype off

        set rtp+=~/.vim/bundle/vundle/
        call vundle#rc()

        "let Vundle manage Vundle:

                Plugin 'gmarik/vundle'

        "#inner workings

            "Vundle adds each plugin        to runpath, before ~/.vim/after
            "                 plugin/after            , after

        "#overriding mappings

            " Using the default path maintained by vundle you can override

            "ftplugin mappings by:

            "- putting the mapping as an autocmd in your vimrc:

                "au FileType FT nn <buffer> a b

            "- putting the mapping inside ~/.vim/ftplugin/FT_something.vim

                "nn <buffer> a b

            "- putting the mapping inside ~/.vim/after/ftplugin/FT_something.vim

            "I don't think `ftplugin/after` mappings can be overriden

            "TODO

    "#local-vimrc #auto source local .vimrc

        function! F()
            echo 'global'
        endfunction

        Plugin 'MarcWeber/vim-addon-local-vimrc'
        "TODO: without this it does not work! With this I get cannot redefine XXX such that is is defined with `!`
        "here and in the local vimrc
        "autocmd BufEnter,BufRead * SourceLocalVimrcOnce

        " Alternatives: http://stackoverflow.com/questions/1889602/multiple-vim-configurations

        " Start from root, ans source every file with a given basename (.vimrc by default).

        " Security is hash based: you have to accept only once for each filename / content hash.

    "#AutoComplPop

        " Automatically opens Vim's built-in completion as you type.

            "Bundle 'vim-scripts/AutoComplPop'

        " The disadvantage of this is that if you hit ESC in the middle of a word,
        " it breaks current completion, but does not go to normal mode, so you need to
        " hit <ESC> twice which is unacceptable. One workaround is to differentiate <esc>
        " and <c-e>, which on regular autocomplete do the same thing (TODO make this work).

            "inoremap <esc> <esc><esc>

        " It is also a bit distracting to see all those popups open and close everywhere
        " for the simplest words.

        " It would be cool however if the popups kept opening automatically after the first <c-p>
        " until I select a choice.

    "#neocomplcache

        " Hardcore autocompletion. May be slow. Use its successor Neocomplete
        " istead on vim 7.3+.

            "Bundle 'Shougo/neocomplcache'
            "let g:neocomplcache_enable_at_startup             = 1
            "let g:neocomplcache_enable_camel_case_completion  = 1
            "let g:neocomplcache_enable_smart_case             = 1
            "let g:neocomplcache_enable_underbar_completion    = 1
            "let g:neocomplcache_min_syntax_length             = 3
            "let g:neocomplcache_enable_auto_delimiter         = 1

            "" AutoComplPop like behavior.
            "let g:neocomplcache_enable_auto_select = 0

            "" SuperTab like snippets behavior.
            "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)": pumvisible() ? "\<c-n>": "\<TAB>"

            "" Plugin key-mappings.
            "imap <c-k>     <Plug>(neocomplcache_snippets_expand)
            "smap <c-k>     <Plug>(neocomplcache_snippets_expand)
            "inoremap <expr><c-g>     neocomplcache#undo_completion()
            "inoremap <expr><c-l>     neocomplcache#complete_common_string()


            "" <cr>: close popup
            "" <s-CR>: close popup and save indent.
            "inoremap <expr><cr>  pumvisible() ? neocomplcache#close_popup() : "\<cr>"
            "inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup() "\<cr>": "\<cr>"
            "" <TAB>: completion.
            "inoremap <expr><TAB>  pumvisible() ? "\<c-n>": "\<TAB>"

            "" <c-h>, <BS>: close popup and delete backword char.
            "inoremap <expr><c-h> neocomplcache#smart_close_popup()."\<c-h>"
            "inoremap <expr><BS> neocomplcache#smart_close_popup()."\<c-h>"
            "inoremap <expr><c-y>  neocomplcache#close_popup()
            "inoremap <expr><c-e>  neocomplcache#cancel_popup()

            "" Enable omni completion.
            "au FileType css setlocal omnifunc=csscomplete#CompleteCSS
            "au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            "au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            "au FileType python setlocal omnifunc=pythoncomplete#Complete
            "au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

            "" Enable heavy omni completion.
            "if !exists('g:neocomplcache_omni_patterns')
                "let g:neocomplcache_omni_patterns = {}
            "end
            "let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
            ""au FileType ruby setlocal omnifunc=rubycomplete#Complete
            "let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            "let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
            "let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

            "" For snippet_complete marker.
            "if has('conceal')
                "set conceallevel=2 concealcursor=i
            "end

        "#neocomplete.vim

            " Sucessor of neocomplcache, but requires a super up to date VIM version.

                "Bundle 'Shougo/neocomplete.vim'

    "#msanders/snipmate.vim

        " <tab> expand in insert mode based on characters before cursor.

        " Useful to expand common programming contructs.

        " After expansion, allows to tab navitate to insivible fields.

        " On fields can complete multiple places (e.g.: variable name in a for loop).

        " Once you leave insert mode, it stops.

            Plugin 'msanders/snipmate.vim'
            Plugin 'kaichen/vim-snipmate-ruby-snippets'

    "#syntastic

        " Does syntax checking using external checkers.

            Plugin 'scrooloose/syntastic'

        " You must then install the external syntax checkers you will use.

        " LIst of compatible syntax checkers: <https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers>

        " Ones I have tried and approved on Ubuntu:

            "gem install ruby-lint

        " This is specially useful when your are going to do a run / compile that takes some time,
        " allowing you to catch silly mistakes before wasting that time.

        " Checks that checkers often do include:

        " - opening without closings (braces, `do` `end`, etc.)
        " - unset / unused variables
        " - shadows variable

        " Check is done at save time.

        " C++11:

            let g:syntastic_cpp_compiler = 'g++'
            let g:syntastic_cpp_compiler_options = ' -std=c++11'

        " C++11 syntax. TODO not working?

            "Plugin 'https://github.com/vim-scripts/Cpp11-Syntax-Support'

    "#fugitive

        " Insaney powerful git Vim frontend:

            Plugin 'tpope/vim-fugitive'

        " Tutorial: https://github.com/tpope/vim-fugitive

        " Most useful commands:

        " - Gdiff <ref>: vimdiff between commits. To exit simply close the old one.
        " - Gmove <name>: rename buffer and `git mv`
        " - Gremove <name>: close rename buffer and `git rm`
        " - Gbrowse <ref>: open GitHub URL corresponding to file in browser.
        " - Gblame <ref>: vplist a git blame. Corresponds line by line with the buffer. Both scroll together.
        " - Gstatus <ref>: tons of per file quickfix like functionality like:
        "     - `-`: git add file on line under cursor
        "     - `O`: open file on line under cursor in new tab
        "     - `D`: open Gdiff on file under cursor on the window below
        "     - `cc`: Gcommit
        "     - `cA`: Gcommit| --amend --reuse-message=HEAD

        " Open diff for current file in a new tab.
        "
        " Requires:
        "
        "     Plugin 'vim-scripts/AnsiEsc.vim'
        "
        function! Gdf()
            tabnew
            setlocal buftype=nofile
            setlocal bufhidden=wipe
            setlocal noswapfile
            execute 'read ! git diff --color ' . expand('%:p')
            AnsiEsc
        endfunction
        command! Gdf call Gdf()

        command! Gad execute '!git add ' . expand('%:p')
        command! Gadnpsf execute '!git add ' . expand('%:p') . ' && git commit --amend --no-edit && git push -f'
        command! Gps !git push
        command! Gpsf !git push -f

    "#AnsiEsc

        " Show ansi escapes as color.

           Plugin 'vim-scripts/AnsiEsc.vim'

        " Toogle interpret on:

            "AnsiEsc

        " Toogle interpret off:

            "AnsiEsc

    "#easymotion

        " List on place all possitions and jump to them with a single key stroke.

        " Very fast for non structured moves!

        " - <leader><leader>w        beginnings  of words and lines
        " - <leader><leader>W                       Words
        " - <leader><leader>e        ends           words
        " - <leader><leader>E        ends           Words
        " - <leader><leader>f{char}  given chars
        " - <leader><leader>j        lines down
        " - <leader><leader>n        last search down

            "h easymotion

        Plugin 'Lokaltog/vim-easymotion'

        let g:EasyMotion_mapping_f = '<leader>/'
        let g:EasyMotion_mapping_F = '<leader>?'
        let g:EasyMotion_mapping_w = '<leader>w'
        let g:EasyMotion_mapping_W = '<leader>W'

    "#nerdtree

        " File manager.

            Plugin 'scrooloose/nerdtree'

            "h nerdtree

        " let NERDTreeKeepTreeInNewTab=0
        " let loaded_nerd_tree=1  "stop opening nerd tree.

        " - ?: help

        " - u: root up a dir
        " - C: change root to selected dir
        " - o: toogle open close dir
        " - x: close current level

        " - - t: open in new tab and to to it
              "For file,  opens normal buffer
              "For dir,   opens another nerdtree with root there
        " - T: same as t but stay on current nerd tree

        " - - p: go to parent of current
        " - P: go to root
        " - K: first   sibling current level
        " - J: last    sibling current level
        " - <c-k>: previous sibling
        " - <c-j>: next sibling

        " - m: enter a menu that allows you to: copy, delete, etc.
             "selected node. <esc> to exit this menu

        " - A: toogle maximize

        " - B: show bookmark list and move cursor to first one
        " - o: move root to selected bookmark
        " - D: delete selected bookmark

        " The following commands can only be used from inside the NERDTree window:

        " - :Bookmark <name>: create bookmark at node under cursor with given name
        " - :BookmarkToRoot <name>: move root to bookmark with given name
        " - :ClearBookmark <name>: delete bookmark

        " Bookmarks are stored under `~/.NERDTreeBookmarks`.
        " The only way to remove bookmarks to directories that don't exist is to edit that file.

    "#conque-term

        " Github mirror of the Google code main repo:

            Plugin 'rosenfeld/conque-term'

        " - runs terminal inside vim
        " - hit esc and you can edit history as a vim buffer
        "     hit i, and you're back to terminal mode
        " - after C-D, shell history remains on normal buffer and you can vim edit it
        "
        " :ConqueTerm bash
        " :ConqueTermSplit mysql -h localhost -u joe -p sock_collection
        " :ConqueTermTab Powershell.exe
        " :ConqueTermVSplit C:\Python27\python.exe
        "
        " BETA feature, didn't work for me:

            " :let term = conque_term#open('bash', ['tabnew'])
            "
            ":cal my_terminal.write("make run\n")
            ":cal my_terminal.writeln("make run")
            "
            "let term = conque_term#get_instance()
            ""most recent
            "
            "let term = conque_term#get_instance(3)
            ""specific instance
            ":ConqueTermTab bashx make run
            ":ConqueTermTab bashx make run; exit

    "#vim-session

        " Manage sessions. Save and load tabs, windows, buffers, etc.

            " Required by vim-session and other xolox plugins:

                Plugin 'xolox/vim-misc'

            Plugin 'xolox/vim-session'

        " Help:

            "h session

        " List all sessions:

            "OpenSession <tab>

        " Save session:

            "SaveSession <session_name>

        " Delete session:

            "DeleteSession <session_name>

        " Config:

            let g:session_verbose_messages = 0
            let g:session_autosave = 'yes'
            let g:session_autosave_to = 'default'
            let g:session_autoload = 'yes'

    "#FuzzyFinder

        " Find things like Files and Buffers really quickly.

        " Specially interesting is the completioin mode which transforms:
        " `abc` into a regexp `a.*b.*c`.

            Plugin 'L9'
            Plugin 'FuzzyFinder'

    "#ctrlp

        " Fuzzy finder in files or buffers.

        " Seems more pupular than FuzzyFinder now.

        " Tutorial: https://github.com/kien/ctrlp.vim

            Plugin 'kien/ctrlp.vim'

    "#ack.vim

        " Vim ack integration

           Plugin 'mileszs/ack.vim'

        " Usage:

          ":Ack a.c

        " Does `ack a.c` on current directory and opens up a quickfix window with matches.

        " You can therefore use any quickfix shortcut such as `:cn` to jump
        " between matches.

        " Inside the quickfix window, the following mappings can be used (the
        " standard quickfix ones seem to be off):

        " - `o`: open file in current buffer and jump to line
        " - `T`: open in new tab and jump to line

    "#nerdcommenter

        " Does the right type of comment for each recognized filetype.

            Plugin 'scrooloose/nerdcommenter'

        " Default mappings start with `<leader>c`.

        " Toogle comment on current/selected lines:

            "<leader>c<space>

        " To use the functions provided in the plugin you must do:

            "call NERDComment('n', 'uncomment')

        " as explained in `:h NERDComment`.

    "#surround

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
        "< ({ [ work multiline, ' " ` dont
        "linewise visual mode + S<p class="important">: surround lines with p.

            Plugin 'tpope/vim-surround'

    "#autoclose

        " Automatically closes parenthesis, HTML tags, etc., and puts the cursor in the middle.

            Plugin 'Townk/vim-autoclose'

        " Completion is somewhat smart:

        " - does not complete inside strings

    "#align

        " Better documented than tabular, and more vim like interface.

            Plugin 'junegunn/vim-easy-align'

        " Test with:

            "apple   =red
            "grass+=green <cursor>
            "sky-=   blue

        " Align at `=`:

            "vip<enter>=
            "<leader>aip=

    "#tabular

        " Easily align at certain characters.

            Plugin 'godlygeek/tabular'

        " Align current paragraph (lines without \n\n) at a regexp (comma in the example):

            "Tabularize /,

        " Try it on:

            "abc, 0
            "ab, 0 <cursor>
            "a, 0

            "abcd, 0

    "#vis

        " Visual block only replace.

            Plugin 'taku-o/vim-vis'

        " Select visual bloc, then `:B s/a/b/g` so that replace acts only on selected block.

    "#repeat

        " Allows for dot `.` repetition of custom commands.

            Plugin 'tpope/vim-repeat'

        " Used in plugins from tpope and others.

        " - surround

    "#markdown

        "#plasticboy markdown

            " Offers;

            " - syntax highlighting
            " - code folding
            " - header navigation mappings

                Plugin 'plasticboy/vim-markdown'

            " Disable folding:

                "let g:vim_markdown_folding_disabled=1
                let g:vim_markdown_initial_foldlevel=6

            " There is also a version by tpope, but plasticboy seems better:

                "Bundle 'tpope/vim-markdown'

        "#instant markdown

            " Preview server on localhost:8090.
            "
            " Recompiles everytime you type with redcarpet.
            "
            " Tons of external dependencies. I'd rather just compile and do `firefox output.html` for now.

                "Plugin 'suan/vim-instant-markdown'

    "#sparkup

        " HTML mappings.

            Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

    "#vim latex

        " Plugin 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
        " Plugin 'jcf/vim-latex'
        " could not install with vundle. next best option then
        " set runtimepath+=$HOME/.vim/plugin/vim-latex

    "#rope-vim

        " Python refactoring.

            Plugin 'klen/rope-vim'

    "#coffee-script

            Plugin 'kchmck/vim-coffee-script'

    "#rename.vim

        " Rename current file.

            Plugin 'danro/rename.vim'

        " Usage:

            ":reaneme <newname>

    "#colorscheme

        Plugin 'tpope/vim-vividchalk'
        colorscheme vividchalk

"#general

    " Leave vi compatibility to get better features.

        set nocompatible

    "#filetype

        " Set autodetect filetype and set it for buffers:

            filetype on

        " This allows the following to work properly:

        " Plugins for given filetypes

            filetype plugin on

        " Syntax highlighting

            syntax on

        " indent for specific filetypes

            filetype indent on

    "#modeline

        " If on, Vim will read options from one of the first comment `modelines` lines (default 5)
        " at the top of the file.
        "
        " This is specially useful for setting filetypes on files without extension not shebang
        " such as Vagrantfiles with something of the type:
        "
        "   # vi: set ft=ruby :
        "
        " Default: on.

            "set modeline

    "#search

        " Control parameters of `/` search

            set hlsearch    " highlight search terms
            set incsearch   " match as you type each new character
            set ignorecase  " ignore case when searching
            set smartcase   " ignore case if search pattern is all lowercase,
                            " case-sensitive otherwise
            set showmatch   " set show matching parenthesis
            set wrapscan    " wrap around end of document (default)
            "set nowrapscan " do not wrap around

        " Stop current highlighting:

            "noh

        " Will be automatically turned back on on next search

    " Working directory is always the same as the file being edited

        set autochdir

    " Allow to use the mouse:

        set mouse=a

    "#backup #swap

        set nobackup
        "set backupdir=~/tmp     "where to create backups if need be so
        "set writebackup
        "set backupskip=/tmp

        set noswapfile
        "set directory=~/tmp     "same as backupdir but for swaps

    " Automatically load files that were modified externally

        set autoread

    " Reduce standard message verbosity:

        set shortmess=atI

    " Command tab completion

        set wildmenu
        set wildmode=list:longest
        set history=1000    " command history size

    "#undo

        " Vim 7.3 added persistent undo: undo history is saved even for closed
        " buffers!

            set undofile                " Save undo's after file closes
            set undodir=$HOME/.vim/undo " Where to save undo histories
            set undolevels=1000         " How many undos
            set undoreload=10000        " Number of lines to save for undo

    " Maintains at least 4 lines in view from the cursor

        set scrolloff=4

    " Font size

        set guifont=9

    "#number

        " Show line numbers on left of page:

            set number

        " Show numbers relative to current line. Fun and insane:

            set norelativenumber

        " Minimum number of spaces to leave for line numbers. Automatically increases as needed.
        " so just use the minimum 1.

            set numberwidth=1

    "#highlight

        " Highlight current line and column. Makes line too unreadable on certain dark themes.

            set nocursorline
            set nocursorcolumn

        " TODO make only the line number bold: http://stackoverflow.com/questions/8247243/highlighting-the-current-line-number-in-vim

    "#wrapping

        set nowrap
        set linebreak                           " Use breakat or not
        "set breakat=                           " At which characters it is possible to break.
        set wrapmargin=0                        " Wrapping margin left at the right.
        "let &showbreak = '>'.repeat(' ', 8)    " What to show on the new broken line.
        set nolist

    " Maximum line width. Inserts newline automatically at first space.  0 to disable.

    " If you use filetype needs and autocommand because most of the default filetypes set this to true.
    " I prefer to highlight long lines and break lines mysefl.

        autocmd Bufenter * set textwidth=0

    "#formatoptions

        " Do not automatically continue comments that start on the first line
        " when using enter (it will still happen when using `o`).

        " As of 7.3, this would overriden by most pesky default ftplugins.

            "set formatoptions-=r

        " Same as above but for `o`:

            "set formatoptions-=o

    " Stop adding spaces after `.` on `J` and `:j`:

        set nojoinspaces

    "#highlight

        "Only last match works. This was probably designed for interactive usage.

        "2match is a second option.

        "3match is reserved.

        "General solution: only exists with plugins as of 2013:
        "<http://superuser.com/questions/211916/setting-up-multiple-highlight-rules-in-vim>

            " Highlight tralling whitestpace.
            "
            " Also possible with set list + listchars, but this is better.

                augroup TraillingWhitespaceAucmd
                    autocmd BufEnter * highlight TraillingWhitespace ctermbg=brown guibg=brown
                    autocmd BufEnter * match TraillingWhitespace /\s\+$/
                augroup END

                augroup LineTooLongAucmd
                    autocmd BufEnter * highlight LineTooLong ctermbg=darkgrey guibg=#101010
                    autocmd BufEnter * 2match LineTooLong /\%75v.*/
                augroup END

    "#ruler

        " The ruler is at the right bottom where there is info about:
        " line, column and percentage of current file in the same space for commands.

            set ruler
            "set noruler

    "#tabwindow

        " Format tab titles:

            set guitablabel=%N)\ %t\ %M
            "set guitablabel=%!expand(\"\%:p\")
            "set guitablabel=%!pathshorten(expand(\"\%:p\"))

        "%N: tab number from left to right
        "%t: basename of loaded buffer
        "%M: modify status (a '+' if modified)

    " Allow backspacing over everything in insert mode:

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

    "EOL

        " System independant end of line. `\n` on linux, `\r` on Mac OS X, `\n\r` on Windows.

    "#eol #endofline #newline at end of file #binary

        " If `eol` and `binary` are on (default), Vim adds an <EOL> at the end of file if it does not have one already.
        "
        " `eol` is automatically set when opening a new file if it ends in <EOL>. Therefore, if `binary` is on,
        " Vim maintains the file state.
        "
        " The downsides of having `binary` are that:
        "
        " - you cannot view or remove the <EOL> easily.
        "
        "    Workaround: `!truncate -1 %` (-2 on Windows...)
        "
        " - if you forget to set the default behavior for new files to match the projects standards, you may break them.
        "       and there will be no immediate visual indiation of that (except for `git diff`).
        "
        "    Workaround: never create, always copy existing files, or use a local vimrc that sets binary.
        "
        " - it is confusing for the initiates
        "
        " If you keep the default magic you have the upside that:
        "
        " - don't have to worry about different per project / per file type conventions.
        "
        " We feel that this default was a good design choice by Vim,
        " specially once you understand that there is magic going on.
        "
        " When you open a non-empty file that does not end in a newline, it shows [noeol] on the status line.
        " You can see this anytime by doing `e`.

        "set binary

    "#binary file edit

        "TODO how to edit a binary file?

    "#encoding #fileenconding #utf8 #bomb

        "http://stackoverflow.com/questions/16507777/vim-set-encoding-and-fileencoding-utf-8

    "#fold

        "#foldmethod

            " There are a few diferent methods.

            " - `expr`: based on any expression or function. Most powerful.

                "set foldmethod=indent

        "#foldlevel

            " How deep fold currently is:

                "set foldlevel=3

            " Level 0 is the maximum fold level.

            " This can be modified by many default mappings such as
            " zr, zR, zm and, zM

        " Deepest allowed fold:

            "set foldnestmax=3

        "#foldenable

            " It true, fold is turned off:

                set nofoldenable

            " `zi` toogles this by default.

            " Useful to turn fold on and off. The current foldlevel is kept.

    "#conceal

        " The thing that renders onscreeen Greek, underline, etc. in LaTeX for example.

        " g:tex_conceal=""

            set conceallevel=0

    "#spell

        " On the fly spell checker that underlines errors.

        " Features:

        " - to add word under cursor to the dictionary
        " - view correction suggestions and possibly correct
        " - jump to next incorrect word
        " - for code filetypes, only checks spelling on comments and strings.
        " - for markup filetypes such as HTML or latex, ignores keywords such `<html>`

        " Main help page:

            "`help spell`

        " Enable for all files by default:

            "set spell

        " Set language:

            "set spelllang=en_us

        " Do both at once (works for any option in general):

            "set spell spelllang=en_us

        " Enable only for certain filetypes:

            autocmd BufEnter,BufRead *.{md,rst,html,haml,tex} setlocal spell spelllang=en_us

        " Keymaps

        " - `]s`: move to next misspelled word
        " - `z=`: show and select from suggestion list
        " - `zg`: add word to dict

    "#matchit

        " allows '%' to jump between open 'if' 'else', 'do', 'done', etc. instead.
        " of just parenthesis like chars
        " marcros/matchit.vim has been a standard file for years

            runtime macros/matchit.vim

    "#sessions #views

        " Vim has a built-in session system.

        " This sytem is made more confortable by plugins such as vim-session, but the backend is the same.

        " Create a session file called Session.vim

            "mksession

        " Overwrite if existing:

            "mksession!

        " Custom name:

            "mksession Custom_name.vim

        " What exactly to save is controlled by the vim

        " This saves a lot of trash to the sessionoptions option, such as:
        " - global variables, which are already set from your vimrc
        " - options which you only changed once, and do not to pass to the next session.

            set sessionoptions=blank,buffers,help,tabpages

    "#gvim specific

        set guioptions-=m  "remove menu bar
        set guioptions-=T  "remove toolbar
        set guioptions-=r  "remove right-hand scroll bar
        set guioptions-=b  "remove right-hand scroll bar

        " Normally, pressing alt focuses on the menu in gvim, but vim NEEDS no menu,
        " vim only needs vimrc!

            set winaltkeys=no

"#language speficification

    " The right place for those is in a ftplugin, but I'm lazy to put such small settings in files...

    " #data languages

    " #html

        autocmd FileType html,haml setlocal shiftwidth=2 tabstop=2
        autocmd FileType html,haml call MapAllBuff('<F6>', ':w<cr>:sil ! firefox %<cr>')
        autocmd FileType html,haml call MapAllBuff('<S-F6>', ':w<cr>:sil ! chromium-browser %<cr>')

    " #css and family

        autocmd BufEnter,BufRead *.{css,sass,scss} setlocal shiftwidth=2 tabstop=2

    " #javascript #js #coffe

        autocmd BufEnter,BufRead *.{js,coffee} setlocal shiftwidth=2 tabstop=2

    "#compilable markup

        "#md #rst

            "au FileType *.md setlocal shiftwidth=4 tabstop=4
            autocmd BufEnter,BufRead *.{md,rst} setl shiftwidth=4 tabstop=4
            "au BufEnter,BufRead *.{md,rst} setl filetype=text
            autocmd BufEnter,BufRead *.rst call MapAllBuff('<F5>', 'w<cr>:sil ! make<cr>')

            "TODO this is broken still:
            autocmd BufEnter,BufRead *.rst call MapAllBuff('<F6>', 'o<cr><ESC>k:pu=''.. _vimhere:''<cr>:w<cr>:sil ! make<cr>k:d<cr>:d<cr>:d<cr>:w<cr>:sil ! make firefox RUN_NOEXT="%:r" ID="\#vimhere"<cr>')

            "make and open with firefox on curent point without a makefile
            let s:out_dir = '_out'
            autocmd BufEnter,BufRead *.{md,rst} call MapAllBuff('<S-F6>', ':pu=''<span id=\"VIMHERE\"></span>''<cr>:w<cr>:silent ! mkdir -p ' . s:out_dir . '; pandoc -s --toc % -o ' . s:out_dir . '/%<.html<cr>:d<cr>:w<cr>:silent ! firefox ' . s:out_dir . '/%<.html\#VIMHERE<cr>')
            "au BufRead,BufNewFile *.{md,rst} noremap <buffer> <F6> <ESC>:! mkdir -p _out; pandoc -s --toc % -o _out/%<. html; firefox _out/%<.html<cr>

            autocmd BufEnter,BufRead *.{md,rst} call MapAllBuff('<F7>', ':w<cr>:sil ! make<cr>:sil ! make firefox RUN_NOEXT="%:r"<cr>')

            "clean default output dir
            autocmd BufEnter,BufRead *.{md,rst} call MapAllBuff('<S-F7>', ':sil !rm -r ' . s:out_dir . '<cr>')
            autocmd BufEnter,BufRead *.{md,rst} call MapAllBuff('<F8>', ':w<cr>:sil ! make<cr>:sil ! make okular  RUN_NOEXT="%:r"<cr>')

            " Markdown *cannot* be indented, and GFM forces us to have
            " infinitely long lines. because single newlines become line breaks.
            autocmd BufEnter,BufRead *.{md,rst} setlocal wrap

            " Make index

        "#latex #tex

            autocmd FileType tex setlocal shiftwidth=2 tabstop=2

            autocmd BufEnter,BufRead *.{tex,md} call MapAllBuff('<F5>'  , ':w<cr>:! cd `git rev-parse --show-toplevel` && make<cr>')
            autocmd BufEnter,BufRead *.{tex,md} call MapAllBuff('<S-F5>', ':w<cr>:! cd `git rev-parse --show-toplevel` && make clean<cr>')
            autocmd BufEnter,BufRead *.{tex,md} call MapAllBuff('<F6>'  , ':w<cr>:exe '':sil ! cd `git rev-parse --show-toplevel` && make view VIEW=''''"%:r.pdf"'''' LINE=''''"'' . line(".") . ''"''''''<cr>')
            "au BufEnter,BufRead *{.tex,.md} call MapAllBuff('<F6>'  , ':w<cr>:exe '':sil ! cd `git rev-parse --show-toplevel` && make view VIEW=''''"%:p"'''' LINE=''''"'' . line(".") . ''"''''''<cr>')

            "this works
            "but the problem is: in which dir is the output file?
            "this is something only the makefile knows about.
            function! LatexForwardOkular(pdfdir)
                let pdf = a:pdfdir . expand('%:r') . '.pdf'
                let synctex_out = system('synctex view -i "' . line(".") . ':1:' . expand('%') . '" -o "' . pdf . '"')
                let page = 1
                for l in split(synctex_out, '\n')
                    if l =~ '^Page:'
                        let page = substitute(l, '^Page:\(\d\+\)$', '\1', '')
                    end
                endfor
                exe 'sil! ! nohup okular --unique -p ' . page . ' ' . pdf . ' &'
            endfunction
            "au BufEnter,BufRead *.tex call MapAllBuff('<F4>', ':cal LatexForwardOkular("_out/")<cr>')

    "#interpreted languages #python #bash #perl #ruby

        autocmd FileType python,perl setlocal shiftwidth=4 tabstop=4
        autocmd FileType sh,ruby setlocal shiftwidth=2 tabstop=2
        autocmd BufEnter,BufRead *.{erb,feature,ru} setlocal shiftwidth=2 tabstop=2
        autocmd FileType sh,python,perl,ruby call MapAllBuff('<F6>', ':w<cr>:cal RedirStdoutNewTabSingle("./" . expand(''%''))<cr>')

    "#compile to executable languages

        "#c #c++ #cpp #lex #y #fortran #asm #s #java

        function! FileTypeCCpp()
            call MapAllBuff('<F5>'  , ':w<cr>:make<cr>') "vim make quickfix
            call MapAllBuff('<S-F5>', ':w<cr>:sil ! make clean<cr>')
            call MapAllBuff('<F6>'  , ':w<cr>:cal RedirStdoutNewTabSingle("make run")<cr>')
                "make run, stdout to a new file
                "stdout is only seen when program stops.
            call MapAllBuff('<S-F6>', ':w<cr>:cal RedirStdoutNewTabSingle("make run RUN_ARGS=''\"\"''")<LEFT><LEFT><LEFT><LEFT><LEFT>')
                "same as above, but may pas command line args
            call MapAllBuff('<F7>'  , ':cnext<cr>')
            call MapAllBuff('<F8>'  , ':cprevious<cr>')
            call MapAllBuff('<F9>'  , ':w<cr>:cal RedirStdoutNewTabSingle("make profile")<cr>')
            call MapAllBuff('<S-F9>', ':w<cr>:! make assembler<cr>')
        endfunction

        autocmd FileType c,cpp,fortran,asm,s,java call FileTypeCCpp()

        autocmd FileType c,cpp,asm setlocal shiftwidth=4 tabstop=4
        autocmd BufEnter,BufRead *.{l,lex,y} setlocal shiftwidth=4 tabstop=4

        "because fortran has a max line length...
        autocmd FileType fortran setlocal shiftwidth=2 tabstop=2

    "#vimscript

        "reaload all visible buffers.
        "TODO: multiple windows per tabpage.
        function! ReloadVisible()
            set noconfirm
            tabdo e
            set confirm
        endfunction

        autocmd FileType vim setlocal shiftwidth=4 tabstop=4
        "this will write all buffers, source this vimrc, and reaload open
        "buffers so that changes in vimrc are applied
        autocmd FileType vim noremap <buffer> <F5> :wa<cr>:so %<cr>:sil call ReloadVisible()<cr>

        " Save and source current script:
        autocmd FileType vim noremap <buffer> <F6> :w<cr>:so %<cr>

"#mappings

    " Here are all the:

    " - cheats on default meanings
    " - custom mappings

    " Sorted by qwerty order so that it is easy to find:

        "Esc F1-F12
        "1234567890
        "qwertyuiop[]\
        "asdfghjkl;'<cr>
        "zxcvbnm,./
        "<space>

    " Language specific mappings may be in language specific sections.

    "#leader

        " Good key to start your personally defined maps.

        " Set the current leader:

            let mapleader = ',' "default
            "let mapleader = '\'

        " Use current leader:

            "nn <leader>a b

        " Redefining it after changing a mapping has no effect on already defined
        " maps, but will affect commands that are defined afterwards:

            "let mapleader = ','
            "noremap <leader>a b
            "let mapleader = '\'
            "noremap <leader>d e

        " Here, `,a` and `\d` have gotten mappings!

        " Tab navigation in normal mode.
        " In terminal, alt tab is not possible, but should be used in GVim.

            nn <leader>tt :tabedit<space>
            nn <leader>tb :tabedit<cr>:b<space>
            nn <leader>tm :tabmove<space>

        " Currently using another shortcut for this:

            "nn <leader>tT :tabclose<cr>

            nn <leader>ss :SaveSession<space>
            nn <leader>so :OpenSession<space>

    "#f keys

            call MapAll('<F2>',     ':cal GuakeNewTabHere()<cr>')
            call MapAll('<S-F2>',   ':ConqueTermTab bash<cr>')
            call MapAll('<F3>',     ':NERDTreeToggle<cr>')

    "#` #~

        " Invert selection case:

            "vn ~

        " Jump to last modification made on current buffer:

            "nn `.
            "vn `.

    "#@ #2

        " Do macro saved on a register:

            "noremap @a

        "redo last used macro:

            "noremap @@

    "## #3

        "noremap * backwards:

            "noremap #

    "#% #4

        " Swap with L:

            nn $ L
            vn $ L

    "#% #5

        " Goes between open close pairs

            "nn %

            "h %

        " Pairs are defind by:

            "set mps?

        " Very useful command

        " Individual pairs and more can be done with `[`

        " As of 7.3, in HTML works by default for:

        " - HTML tags.
        " - less than and more than sign pairs.

    "#^ #6

        " Go to first non whitespace char of line:

            "unmap ^

        "toogle between current and alternate file:

            "unmap c-^

        " Swap with H:

            noremap ^ H

    "#*

        " Search for word under cursor for backwards:

            "noremap *

        " Replacement starts as current word (w) under cursor
        " (analogy to `*` which searches for word under cursor):

            nn <leader>* bve"zy:%s/<c-r>z/<c-r>z/g<left><left>

    "#( #) #0

        "- (previous sentence
        "-) next

        "what is a sentence?

        "something that ends in '.', '?' or '!'

           "h sentence

    "#=

        " Indent current lines:

            "map ==

    "#tab

        " Next and previous tab:

            call MapAll('<c-tab>',   ':tabnext<cr>')
            call MapAll('<c-s-tab>', ':tabprevious<cr>')

    "#q

        " Start/end recording commands in register a:

            "nn qa

        " Enter ex mode:

            "nn Q

        " Same as command mode, except you can do several ex commands
        " without exiting ex command mode

        " Visual block mode:

            "nn c-q

        " Same as `c-v` in gvim, but used for terminal control

        " Close current window and move left:

            call MapAll('<c-q>', ':q<cr>:tabprevious<cr>')

        " Useful because I don't use subwindows (each window becomes too small),
        " and often I open up Scrap tabs to the right of the current tab (program | program output),
        " so when I close the program output I want to go back to the program source.

    "#w

        " Move across windows:

            "<c-w>h
            "<c-w>j
            "<c-w>k
            "<c-w>l

        " Rationale: better with a direct control key mapping.

        " Close current window:

            call MapAll('<c-w>', ':q<cr>')

        " Close current tab (possibly multiple windows):

            "call MapAll('<c-w>', ':tabclose<cr>')

    "#e

        " Scroll up one line (don't move cursor (unless it would go out of view)):

            "nn <c-e>

        " Scroll down: TODO

        " Mnemonic: Extra lines!!

    "#r

        " Replace mode (insert but overwritting):

            "nn R

        " Useful in rare cases such as when editing row aligned text.

        " Redo:

            "nnoremap <c-r>

    "#t

        " Like `f`, but stops right before char.

            "nn t

        " Repeated uses do nothing

        " Mnemonic: unTill

        " Major use case: delete untill char, but don't delete char. Ex:

        " Buffer:

            "f(a,b,c,d)
            "  ^

        " You want to delete up to `d`, but keep the `)`

        " Solution: `dt)`

    "#y

        " Same as c-e, upwards:

            "nn <c-y>

        " Mnemonic: close to c-u (on qwertyu)

        " Same as yy, therefore useless.

            "nn Y

        " Copy to system clipboard:

           nnoremap Y "+y
           vnoremap Y "+y

        " Very useful to copy paste to browser or terminals.

        " Accelerate vertical scroll up:

            "nn <c-Y> 5<c-Y>

        " Copy line to system clipboard:

           nnoremap yY ^"+y$

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

    "#p

        " Paste:

            "nn p

        " Open *ins-completion* popup:

            "nn! <c-p>

        " See `:h ins-completion`.

    "#[ #]

        " Miscelaneous commands, mostly section motions.

        " - } go to next     latex paragraph (double newline)
        " - {       previous

        " - ]] go to next     `}` at current level
        " - [[ go to previous `}` at current level
        " - ][       next     `{`
        " - ][       previous `{`

        " What is a section? defined by `se sects?`.

            "h sect

        " - c-] go to location of link under cursor used in Vim docs TODO how to make one of those?

        " - [(last unmatched open par. Same for),[,],{,}.=, but not for <>
        " - [z fold move

        " Some nice ones from the famous `https://github.com/tpope/vim-unimpaired`:

        " Exchange current line(s) with the line above / below:

            function! s:Move(cmd, count, map) abort
                normal! m`
                exe 'move'.a:cmd.a:count
                norm! ``
                silent! call repeat#set("\<Plug>unimpairedMove".a:map, a:count)
            endfunction

            function! s:MoveSelectionUp(count) abort
                normal! m`
                exe "'<,'>move'<--".a:count
                norm! ``
                silent! call repeat#set("\<Plug>unimpairedMoveSelectionUp", a:count)
            endfunction

            function! s:MoveSelectionDown(count) abort
                normal! m`
                exe "'<,'>move'>+".a:count
                norm! ``
                silent! call repeat#set("\<Plug>unimpairedMoveSelectionDown", a:count)
            endfunction

            nnoremap <silent> <Plug>unimpairedMoveUp :<C-U>call <SID>Move('--',v:count1,'Up')<CR>
            nnoremap <silent> <Plug>unimpairedMoveDown :<C-U>call <SID>Move('+',v:count1,'Down')<CR>
            noremap <silent> <Plug>unimpairedMoveSelectionUp :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
            noremap <silent> <Plug>unimpairedMoveSelectionDown :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>

            nmap [e <Plug>unimpairedMoveUp
            nmap ]e <Plug>unimpairedMoveDown
            xmap [e <Plug>unimpairedMoveSelectionUp
            xmap ]e <Plug>unimpairedMoveSelectionDown

        " Next / previous file in current directory:

            function! s:entries(path)
            let path = substitute(a:path,'[\\/]$','','')
            let files = split(glob(path."/.*"),"\n")
            let files += split(glob(path."/*"),"\n")
            call map(files,'substitute(v:val,"[\\/]$","","")')
            call filter(files,'v:val !~# "[\\\\/]\\.\\.\\=$"')

            " filter out &suffixes
            let filter_suffixes = substitute(escape(&suffixes, '~.*$^'), ',', '$\\|', 'g') .'$'
            call filter(files, 'v:val !~# filter_suffixes')

            return files
            endfunction

            function! s:FileByOffset(num)
            let file = expand('%:p')
            let num = a:num
            while num
                let files = s:entries(fnamemodify(file,':h'))
                if a:num < 0
                call reverse(sort(filter(files,'v:val < file')))
                else
                call sort(filter(files,'v:val > file'))
                endif
                let temp = get(files,0,'')
                if temp == ''
                let file = fnamemodify(file,':h')
                else
                let file = temp
                while isdirectory(file)
                    let files = s:entries(file)
                    if files == []
            " TODO: walk back up the tree and continue
                    break
                    endif
                    let file = files[num > 0 ? 0 : -1]
                endwhile
                let num += num > 0 ? -1 : 1
                endif
            endwhile
            return file
            endfunction

            function! s:fnameescape(file) abort
            if exists('*fnameescape')
                return fnameescape(a:file)
            else
                return escape(a:file," \t\n*?[{`$\\%#'\"|!<")
            endif
            endfunction

            nnoremap <silent> <Plug>unimpairedDirectoryNext :<C-U>edit <C-R>=<SID>fnameescape(<SID>FileByOffset(v:count1))<CR><CR>
            nnoremap <silent> <Plug>unimpairedDirectoryPrevious :<C-U>edit <C-R>=<SID>fnameescape(<SID>FileByOffset(-v:count1))<CR><CR>
            nmap ]f <Plug>unimpairedDirectoryNext
            nmap [f <Plug>unimpairedDirectoryPrevious

        " Add blank lines above / below:

            function! s:BlankUp(count) abort
                put!=repeat(nr2char(10), a:count)
                ']+1
                silent! call repeat#set("\<Plug>unimpairedBlankUp", a:count)
            endfunction

            function! s:BlankDown(count) abort
                put =repeat(nr2char(10), a:count)
                '[-1
                silent! call repeat#set("\<Plug>unimpairedBlankDown", a:count)
            endfunction

            nnoremap <silent> <Plug>unimpairedBlankUp :<C-U>call <SID>BlankUp(v:count1)<CR>
            nnoremap <silent> <Plug>unimpairedBlankDown :<C-U>call <SID>BlankDown(v:count1)<CR>

            nmap [<Space> <Plug>unimpairedBlankUp
            nmap ]<Space> <Plug>unimpairedBlankDown

        "Move between lines with same indentation <http://vim.wikia.com/wiki/Move_to_next/previous_line_with_same_indentation>:

        "- l and ]l jump to the previous or the next line with the same indentation level as the current line.
        "- [L and ]L jump to the previous or the next line with an indentation level lower than the current line. 

            " Jump to the next or previous line that has the same level or a lower
            " level of indentation than the current line.
            "
            " exclusive (bool): true: Motion is exclusive
            " false: Motion is inclusive
            " fwd (bool): true: Go to next line
            " false: Go to previous line
            " lowerlevel (bool): true: Go to line with lower indentation level
            " false: Go to line with the same indentation level
            " skipblanks (bool): true: Skip blank lines
            " false: Don't skip blank lines
            function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
            let line = line('.')
            let column = col('.')
            let lastline = line('$')
            let indent = indent(line)
            let stepvalue = a:fwd ? 1 : -1
            while (line > 0 && line <= lastline)
                let line = line + stepvalue
                if ( ! a:lowerlevel && indent(line) == indent ||
                    \ a:lowerlevel && indent(line) < indent)
                if (! a:skipblanks || strlen(getline(line)) > 0)
                    if (a:exclusive)
                    let line = line - stepvalue
                    endif
                    exe line
                    exe "normal " column . "|"
                    return
                endif
                endif
            endwhile
            endfunction

            " Moving back and forth between lines of same or lower indentation.
            nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
            nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
            nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
            nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
            vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
            vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
            vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
            vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
            onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
            onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
            onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
            onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>

    "#|

        "go to column number:

            "unmap \n|

    "#a

        " Increment integer number under the cursor!

            "<c-A>

        " pAste from system clipboard before cursor (in the same place as you would edit with 'i')

        " The pasted item is left selected in viusal mode if you want to indent it

        " So if you want to append to a Line to to insert mode first, 'A' to append and then <c-A>

        " Does not affect any vim local register

        " Rationale:

        " - c-A not to conflict with c-v visual block mode or with terminal shortcuts
        " - is left hand only, allowing you to keep your right hand is no the mouse
        " - the default <c-a> command is not that useful

            cnoremap <c-A> <c-R>+
            inoremap <c-A> <ESC>"+p`[v`]
            nn <c-A> "+P`[v`]
            vn <c-A> d"+P`[v`]

    "#s

        " Same as cl:

            "nn

        " Useless, and therefore must be replaced.

        " Substitude starting with selection/selection/:

            vn s "zy:%s/<c-r>z/<c-r>z/g<left><left>

        " Substitude starting with selection//

            vn S "zy:%s/<c-r>z//g<left><left>

        " Substitute on all file very magic:

            nn <leader><leader>s :%s/\v/g<left><left>

        " Substitute on all file very non-magic:

            nn <leader><leader>S :%s/\V/g<left><left>

        " Type bd *.xml<c-S> to delete all xml buffers

            "cnoremap <c-S> <c-A>

        " Save current buffer:

            noremap  <c-s> <esc>:w<cr>
            noremap! <c-s> <esc>:w<cr>a

        " Insert single char. Can be repeated with `.`

            function! RepeatChar(char, count)
                return repeat(a:char, a:count)
            endfunction
            nn <silent> s :<c-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<cr>
            nn <silent> S :<c-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<cr>

    "#d

        " Cut line to system clipboard:

            nn dD ^v$"+ygv

        " Takes word under cursor
        " open in turrent window a file with same name as that word
        " searchs files under the special path variable (no g: prefix, but global)

            "help path

        "looks in cur dir by default
        "usage: view header/inlcluded files

            "nn gf

    "#f

        "one screen Forward:

            "nn <c-f>

    "#g

        " Leader for lots of miscelaneous commands

        " - gg: go to first line
        " - G:  go to last line
        " - {num}G:  go to line num
        " - ge: go to end of last word!
        " - gE:
        " - gv: go to visual mode and reselect previous visual selection.

            " Also restores visual mode type (char, bloc, line)

            " You can also set that selection programatically:

                "call setpos("'<", [0, 2, 1])
                "call setpos("'>", [0, 3, 2])
                "normal! gv

        " - `gx`: open URL (local file / internet) under cursor using appropriate program.

            " If does not start with a protocol, assumes file: relative to current dir.

                let g:netrw_browsex_viewer = "xdg-open"

        " - {num}gt: go to tab num 1 based.

        " - `g<c-g>`: `wc` like output.

        " Select Go to last Pasted text (to indent, or delete for example)

            nn <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

        " Show current file name and position:

            "nunmap <c-g>

        " Useless if you have `set ruler`.

    "#h

        " Swap H and L by ^ and $ because:

        " - H and L are useless and very easy to type.
        " - ^ and $ are very useful and hard to type.
        " - H and L are good mnemonicts for the begining and end of line, in relation to `h` and  `l`.

        " This also frees `D` and `C`, since it is not very easy to replace them by `dL` and `cL`.
        " It also removes the need for the common mapping `Y`, which is simple to do via `yy`.

            noremap H ^

        " Make help open on a new window:

            cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'

    "#j

        " Use screen lines instead of real lines:

            nn j gj
            vn j gj

        " Accelerate down

            nn J 5j
            vn J 5j

        " Join lines:

            "unmap J

        " Same as j:

            "nn <c-j> j

        " therefore useless.

        " If the line ends in certain characters such as a dot `.`, `J` and `:j` add a extra space.

        " Check out `h 'joinspaces'`.

        " Join commented lines:

            function! JoinCommentedLines()
                normal! j
                call NERDComment('n', 'uncomment')
                normal! k
                j
            endfunction

            command! J call JoinCommentedLines()

    "#k

        " Use screen lines instead of real lines:

            nn k gk
            vn k gk

        " Accelerate up

            nn K 5k
            vn K 5k

        " Search word under cursor using a given program:

            "unmap K

        " Default is `man`.

        " Not *very* useful.

        " Nop:

            "map <c-k> <nop>

    "#l

            noremap L $

        "#TODO make this a motion so I can `yL` to yank

            "function! MoveRight()
                "normal! $
            "endfunction

            "nn L :set opfunc=MoveRight<CR>g@

    "#; #:

        " Repeat last f, F, t or T (like n,N)

            "nn ;

        " Comma to repeat in reverse direction.

        " Enter command mode:

            "nn :

        "swap ';' and ':', dispensing shift to start commands:

            nn ; :
            nn : ;

        "noremap <c-;> asd

    "#enter #cr

        " - <c-m> is equivalent to <cr> becuse of terminals: http://stackoverflow.com/questions/3935970/vim-how-to-map-ctrl-m-without-affecting-return-keypress-as-well
        " - <cr> and <enter> are the same thing, so just use <cr> always
        " - <s-cr> is hard to mapa problem: http://stackoverflow.com/questions/16359878/vim-how-to-map-shift-enter

        " Make enter similar to `o` on normal mode, except that it does not
        " continue comments (because of formatoptions `-=r` ):

            "nn <cr> :let b:old_formatoptions = &formatoptions<cr>:set formatoptions-=r<cr>A<cr><esc>:let &formatoptions=b:old_formatoptions<cr>

    "#z

        "remove useless zl that does single horizontal scroll:

            nn zl zL
            nn zh zH

        " Open close fold under cursor:

            "unmap zo
            "unmap zc

        " Recursivelly:

            "unmap zO
            "unmap zC

        " Toogle fold:

            "unmap za
            "unmap zA

        " All folds (m more, M max, r reduce, R min)

            "unmap zm
            "unmap zM
            "unmap zr
            "unmap zR

        " Toogle all folds max or min:

            "unmap zi

        " Move over folds:

            "unmap [z       "start  of current
            "unmap ]z       "end    of current
            "unmap zj       "start  of next
            "unmap zk       "end    of next

    "#x

        " Delete char under cursor:

            "nn x

        " Delete char before cursor:

            "nn X

        " Decrement number under cursor (oposite of <c-a>):

            "nn <c-X>

        " Enter c-x mode

            "in <c-x>

        " Increment number under cursor:

            nn <c-x> <c-a>

        " Cut to system clipboard:

            vn X "+ygvd

    "#v

        " Enter line visual mode:

            "nn <c-v>

        " Enter block visual mode:

            "nn <c-v>

        " Next entered character will be literal (like in a terminal);

            "in <c-v>

        " Useful for example to insert a literal tab character if tabexpand is on:

            "<c-v><tab>

        " Swap visual and line visual:
        "
        " Visual line is more useful because on a single line it is often easier to predict
        " up to where the jump can be done on a single motion.

            nnoremap v V
            nnoremap V v
    "#c

    "#m

        " LISTEN UP: <c-m> is equivalent to <cr> because of terminals.

        " For your sanity, never remap <c-m>, always use <cr>.

            "nn <c-m> DONT DO THIS!!

        "make mark a on cur buf

            "ma

        "mark A on all open buffers
        "go to opens that buffer in cur window:

            "mA

    "#< #>

        " Keep text selected after shift in visual mode:

            vn < <gv
            vn > >gv

        " Ctrl maps cannot be used.

    "#/

        "search forwards:

            "nn /

        "very magic is more useful than normal:

            nn / /\v

    "#directionals

        " Better keep them plain (not gj), in order not to break stuff like
        " omnicompletion.

            "inoremap <down> <c-o>gj
            "inoremap <up> <c-o>g

        "move across windows:

            nn <c-left> <c-w>h
            nn <c-right> <c-w>l
            nn <c-up> <c-w>k
            nn <c-down> <c-w>j

        "rationale:

        "- control instead of double key for sequences that are often pressed repeatedly
        "- `c-w` is a bit useless, remap it to something better

"#invocation

    " Run Vim commands from the command line:

        "vim +PluginInstall +qall

    " Same as:

        "vim -c PluginInstall -c qall

    " Same as doing form inside of Vim:

        "PluginInstall
        "qall

"#vimrc

    " Default location: ~/.vimrc.

    " Starting on Vim 7.4: `~/.vim/vimrc` will also be a possible location, thus clearing up your home a bit.

    " Start vim with a given vimrc:

        "vim -u vimrc a.txt

    " Good way to test plugins with a minimum vimrc.

"#modes

    " Vim is a modal editor, so the first thing you should learn are its modes.

    " The following modes and mode groups exist:

    " - n: normal only
    " - v: visual and select
    " - o: operator-pending
    " - x: visual only
    " - s: select only
    " - i: insert
    " - c: command-line
    " - l: insert, command-line, regexp-search (and others. Collectively called "Lang-Arg" pseudo-mode)

    "#command mode

        " Is what you get when you type `:`

        " Can tab complete

        " After a tab, left and right arrows navigate possible tab complete commands.

        " After a tab, up returns to the normal command mode

    "#visual mode

        " Visual mode is for newbs.

        " You use visual mode when you cannot predict which keys will lead you to a point on the screen.

        " This means that you have to do an extra `v` and then enter many keys to get where you want.

        " The less you can use visual mode, the stronger you are.

    "#select mode

        " Looks like visual but allows different commands.

        " Enter select mode:

            " gh

        " TODO examples of how commands work

    "#operator pending mode

        " Mode that comes after an operator such as `y`, `d` or `c` was entered.

        " It expects a motion like `hjkl`, *not* an operator as the name may suggest.

        " This is specially important if you want to remap movements.

        " For example, if we do:

            " nnoremap ^ H

        " Then:

            "yH

        "  Will *not* copy up to the beginning of the line. `H` will have its normal meaning
        " and go to the top of the screen, becase after the `y` is entered, we are in `o` mode.

        " If however use use:

            " onoremap ^ H

        " It will work.

        " The best option for this particular example is probably `noremap`, which would remap `nvo`.

    "#ex mode

        " Is what you get when you type `Q`

        " It is like command mode, except you stay in it after executing a command until you type 'visual'

"#motions #operators

        "h motion.txt
        "h text-objects.txt

    " Operators are things like `c`, `d` or `y`.

    " Motions are things that can come after operators like `hjkl` and text objects like `iw`,
    " and indicate where and how (charwise, wordwise, linewise) operators will act.

    " In order to become a Vim master, you must understand the most important motions,
    " including the venerable text objects, which allow you to operate from the middle.

    "#text objects

        "t: HTML tag

"#vimscript

    " Is the built-in language for scripting Vim.

"#version

    " The version command `:version` shows extensive version info, incuding installed
    " extensions, just like `vim --version`.

    " The function `version`, returns a version integer such as `703` for
    " version `7.3`, therefore suitable for conditional execution:

        "if version < 600
        "else
        "endif

"#sources

    "- <http://andrewscala.com/vimscript/>

        "a few good straight to the point, important vimscript tips

    "- http://www.ibm.com/developerworks/linux/library/l-vim-script-1/index.html

        "begginner tuts on vimscript

"#help

    "#help command

        " The most important of all commands

        " See the default help page given by the `helpfile` option:

            "h

        " Can tab complete. Type:

            "h ma

        " Hit <tab> and see what I mean.

        " For comands use colon:

            "h :t

        " For options use single quotes:

            "h 'more'

        " For functions, parenthesis:

            "h range()

        " For default mappings, use:

            "h a
            "h A
            "h CTRL-A
            "h c_CTRL-A " c for Command mode

        " To select the language, use the helplang option.

        " help uses tags like ctags. To navigate, to over a link and hit `C-]`.

    "#helpgrep

        " grep all the help files for expressions.

    "#helpfile

        " File to open when `help` is given no optoins:

            "help

            " set helpfile?

    "#helpheight

        " Default height of the help window:

            " set helpheight?

    "#helplang

        " Language in which to view the documentation by default:

            "set helplang?

        " Contains two letter language codes like `en`.

        " Non English help files should be of form `.??x` instead of `txt`.
        " where `??` is the 2 letter language code.

    "#helptags

        " Generate help tags for a given directory recursivelly.

        " Considers all `.txt` files.

    "#create help files

        " Help files end in the extension `.txt` or `.??t` where `??` is the 2
        " letter language code.

        " The only semantically special thing about helpfile syntax are the tags
        " (link targets) which are written between asterisks:

            "*link-here*

        " Links are of the form:

            "|link-here|

        " and appear without the pipes `|` and in a different color when
        " viewing the file with the `help` command.

        " To generate the tags for a directory do:

            "helptags ~/.vim/doc/

        " This will create a file called `doc/tags`

        " Help searches for all tag fiels named `docs/tags` in the 'runtimepath' option.

        " Now you can open any of the tags in any of the files with:

            "h link-here

        " The rest is just convention:

        " At the beginning of the file use:

            "*filename.txt*

        " So that people can open that file.

        " TOC:

            "==============================================================================
            "CONTENTS                                                   *MYPlugin-contents*

                "1.Intro...................................|NERDTree|
                    "1.1.Functionality provided............|NERDTreeFunctionality|

        "- h1 (80 lines long)

            "==============================
            "1.Header name         *h1-tag*

        "- h2 (80 lines long):

            "------------------------------
            "1.1Header name         *h2-tag*

"#ex command #command

    " Is anything that can come after you type ':'

    " In vimscript every line must start with a command.

    " In `.vim` script files, you don't need to add the ':'

    " Examples: `:w`, `:d`, `:let`, `:cal`, `:norm`, etc.

    " Many commands have one ore more short versions which
    " is are prefix of the full version. Examples:

        ":delete
        ":d

        ":join
        ":j

    " It is recommended that you use the full version in scripts
    " for greate consistensy and readability, and only use
    " short version for interactive sessions.

    " Every vimscript statement starts with a command.

    "- variables

        " You must assign them with the `let` command:

            "let a = 1

        " and *never* as:

            ""a = 1

        " because `a` is not a command, but a variable.

        " You can use a inside of other commands directly:

            "echo a

    "- functions

            "function! F()
                "echo 1
              "endfunction

        " `F` is not a command, so you **cannot** do:

            ":F()

        " You can however call a function with the `call` command:

            ":call F()

    " It is possible to define your own commands.

    " Things that are not commands:

    "- `h`, `j`, `k` and `l` (movements). This is called aa *normal mode command*.
        "Thoes can be accessed from a vimscript via the `normal` command.

    " You can create you own commands with `command`.

    "#command command #:command

        " View all user defined commands (including those in plugins):

            "command!

        " Only those that start with start

            "command start

        " Define a new command.

        " `!` to override existing without error. It is usually the better to use
        " it always and leave end result to precedence.

        " `-nargs=0` is the default:

            "command! Echoa echo 'a'
            "Echoa

            "command! -nargs=0 Echoa echo 'a'
            "Echoa

        " `-nargs=1` is special because it considers the spaces into the argument:

            "command! -nargs=1 Echo1 echo <args>
            "Echo1 'a' 'b'

        " Output: `a b`.

            "command! -nargs=1 Echo1 echo "<args>"
            "Echo1 a b c

        " Output: `a b c`.

        " There seems to be now way to refer to an specific argument:
        " best workaround seems to be to define a function and use `<f-args>`

        " Other possible values for `-nargs` are: `*`, `?` and `+`, analogous
        " to regexp meaning.

        " Name must start with uppercase letter. For this reason, it is not possible to override
        " built-in commands which start with lowercase. The best workaround seems to be using cnoreabbrev;
        " <http://stackoverflow.com/questions/7513380/vim-change-x-function-to-delete-buffer-instead-of-save-quit/7515418#7515418>

            ":cabbrev e <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'E' : 'e')<CR>

        " Define command only on current buffer:

            "command! -buffer Test echo 1

"#comments

    " Start with '"'

"#spaces

    " Are mostly ignored like in c, except for newlines!

        "echo 1
        "echo 2

    " Therefore, you don't need `;` everythwere, but you need to get newlines right

    "multiline commands in script: start *next* line with `\` backslash:

        "ec
        "\ 1

"#multiline commands

    " You can use the pipe char '|' to replace *some*, *but not all* newlines

        "echo 1 | echo 2

    " For example, does *not* work for function definitions:

        "funcction F() | echo 1 | endfunction

"#scope

    "- `g`: global. This is the default scope, even inside functions.

    "- `s`:       local to current    script file

    "- `w`:                           editor window

    "- `t`:                           editor tab

    "- `b`:                           editor buffer

        " Try:

            "let b:buffer = 1

        " Change buffers and:

            "let b:buffer = 2

        " Come back to first buffer and:

            "if b:buffer != 1 | throw 'assertion failed' | end

    "- `l`: defined inside a function function.

            "function! F()
                "let l:var = 1
                "echo l:var
            "endfunction

        " Always use this for variables inside functions to avoid conflict with
        " globals.

    "- `a`: a parameter passed to the current function

            "function! F(param)
                "echo a:param
                "let a:param = 1
                "echo a:param
            "endfunction

    "- `v`: vim predefined

    "#sid

        " Make helper functions or variables that are unique to the script
        " and cannot be called from outside.

        " Example, in a plugin:

            "function! s:F()
                "retu 1
              "endfunction

            "nn <buffer> call <SID>F()

        " Now F can only be called as a helper inside the plugin
        " and not directly to users of the plugin.

        " The advantage of this is that you can make unique short names
        " for script only functions.

"#variables

    " Must use let always to assign:

        "let a = 2 | if a != 2 | throw 'assertion failed' | end

    "can reassign:

        "let a = "abc"
        "let a = 1

    "#exists

        " Check if variable is set or not:

            "if !exists('asdf')
            "    let asdf = 'qwer'
            "endif

"#environment variables

    " Just prefix with a dollar `$`.

    " For example, the home variable, inherited from the calling environment:

        "echo $HOME

    " Empty if not defined

    " Some environment variables are given default values if undefined at startup.

    " Shared root:

        "echo $VIM

        "echo $VIMRUNTIME

    " Environment variables can also be assigned to:

        "let $a = b
        "echo $a
        "!echo $a

"#list

    " Literals:

        "let a = [ 1, 2, 3 ]

    " Equality:

        if [1,2] != [1,2] | throw 'assertion failed' | end
        if [1,2] == [2,1] | throw 'assertion failed' | end

    " Get index of item:

        if (index([1,2], 1) != 0) | throw 'assertion failed' | end
        if (index([2,1], 1) != 1) | throw 'assertion failed' | end
        if (index([1,2], 3) >= 0) | throw 'assertion failed' | end

    " Contains:

        if (index([1,2], 3) >= 0) | throw 'assertion failed' | end

    " Unpack:

        "let [a,b] = [1,2]
        "if a != 1 | throw 'assertion failed' | end
        "if b != 2 | throw 'assertion failed' | end

    " Can be used to return multiple values from function.

    "range:

        if range(3) != [ 0, 1, 2 ] | throw 'assertion failed' | end

    "#filter

        "done in place:

            "a = range(4)
            "filter(a, 'v:val > 1')
            "if a != [2,3] | throw 'assertion failed' | end

        "copy:

            "a = range(4)
            "let b = filter(filter(a, 'v:val > 1'))
            "if a != range(4) | throw 'assertion failed' | end
            "if b != [2,3]    | throw 'assertion failed' | end

"#dicttionary #map data type

        "let d = {1: 'one', 'two': 2}
        "if d.1 != 'one' | throw 'assertion failed' | end
        "if d.two != 2 | throw 'assertion failed' | end

    " Canot use the literal notation for keys inside variables:

        "let key = 1
        "if d.key != 'one' | throw 'assertion failed' | end

    "#get

        "Can be used to get from variable key:

            "let d = {1: 'one', 'two': 2}
            "let key = 1
            "if get(d, key) != 'one' | throw 'assertion failed' | end

        "Can take default value:

            "let d = {1: 'one', 'two': 2}
            "if get(d, 3, 'three') != 'three' | throw 'assertion failed' | end

    "#keys

        " Get a list of the keys in arbitrary order:

            "let d = {1: 'one', 'two': 2}
            "echo keys(d)

"#string

    " Escape

    " :ec 'That''s enough.'
    " :ec '\"'
        "exactly \ and "
        "the only escape inside single quotes is '' for '

    "special chars

        " C-like:

            "echo "\n"

        " Control chars:

            "echo "\<s-v>"

        " Appear like ^V

        " Must use double quotes:

            "echo '\n'

        " Outputs literal '\n'

    " Compare:

        " Note the insanity:

            "abc" ==# "Abc"	  "evaluates to 0
            "abc" ==? "Abc"	  "evaluates to 1
            "abc" ==  "Abc"	  "evaluates to 1 if 'ignorecase' is set, which is
                              "the default!

        " therefore: **always use either ==# or ==? when comparing strings!!**,
        " since `==` can be broken by an option.

    "cat:

        "if "ab" . "cd" != 'abcd' | throw 'assertion failed' | end

    "#repeat

        "cat a given number of times.

            "if repeat('ab', 3) != 'ababab' | throw 'assertion failed' | end

    "string to int:

        "if 10  + "10"    != 20   | throw 'assertion failed' | end
        "if 10  + "10.10" != 20   | throw 'assertion failed' | end
        "if 1.1 + "1.1"   != 2.1  | throw 'assertion failed' | end

    " Substring, range:

        "let a = 'abc'
        "if a[0]     != 'a'  | throw 'assertion failed' | end
        "if a[0:1]   != 'ab' | throw 'assertion failed' | end
        "if a[1:]    != 'bc' | throw 'assertion failed' | end
        "if a[-1]    != 'c'  | throw 'assertion failed' | end

    "equality:

        "if "ab" != "ab" | echo "fail" | end

    "test regex match:

        "if "ab" !~ "a." | echo "fail" | end

    "length:

        "if len("abc") != 3 | throw 'assertion failed' | end

    "split:

        "if split("a,b,c", ",") != [ 'a', 'b', 'c' ] | throw 'assertion failed' | end

    "join:

        "if join(["a", "b", "c"], ",") != 'a,b,c' | throw 'assertion failed' | end

    " int to string is done automatically (weak typing):

        "if 1 . '2' != '12'  | throw 'assertion failed' | end
        "if '1' . 2 != '12'  | throw 'assertion failed' | end
        "if 1 . '' != '1'    | throw 'assertion failed' | end

    "#repeat

        " Like Python string multiplication:

            "if repeat('a', 3) != 'aaa'  | throw 'assertion failed' | end

"#if

        "if 0
            "echo 0
        "elseif 1
            "echo 1
        "en

    "single line:

        "if 0 | echo 0 | elseif 1 | echo 1 | else | echo 2 | end

    "#boolean operations

        " Like in C, all that matters is =0 or !=0:

            "if !0     != 1 | throw 'assertion failed' | end
            "if !1     != 0 | throw 'assertion failed' | end
            "if !-1    != 0 | throw 'assertion failed' | end
            "if 0 && 1 != 0 | throw 'assertion failed' | end
            "if 0 || 1 != 1 | throw 'assertion failed' | end

"#for

        "for i in [1, 3, 2] | echo i | endfor

"#range function

        "if range(1, 3) != [1, 2, 3] | throw 'assertion failed' | end
        "if range(3, 1, -1) != [3, 2, 1] | throw 'assertion failed' | end

    " Loop all lines of a file modifying them with any function.

        "for i in range(1, line('$'))
            "let l:line = getline(i)
            "let l:line =  substitute(l:line, 'a\(.\), '\1', '')
            "setline(i, l:line)
        "endfor

"#while

        "let i = 0
        "while i < 3
            "echo i
            "let i = i + 1
        "endwhile

    " There is no do-while loop

"#function

    " Must start with uppercase char

    " '!' means can override existing func

    " Cannot use | for single line

        "function! F(a, b)
            "retu a:a + a:b
        "endfunction

        "if F(1, 2) != 3 | throw 'assertion failed' | end

    "#vararg

            "function! F(a, b, ...)
                "for i in range(a:0)
                    "echo a:{i}
                "endfor
              "endfunction

        " - a:0 contains the number of varargs. This does not cound regular
        "     arguments.
        " - a:1 contains the vararg arg.
        " - a:2 contains the second arg, and so on.

    "#call

        " Command to call function.

        " Ignores return value.

        " Only side effects can be useful therefore.

    "#multiple return values

        " Put them inside a list, and unpack at return time:

            "function! F()
                "return [1,2]
            "endfunction

            "let [a,b] = F()
            "if [a,b] != [1,2] | throw 'assertion failed' | end

    " No return val returns 0:

        "function! F()
        "endfunction

        "if F() != 0 | throw 'assertion failed' | end

    "#default values

        " Concept does not exist in the language.

        " Workaround;

            "function! F(a, ...)
                "if a:0 > 0
                    "let l:b = a:1
                "else
                    "let l:b = 10
                "endif

                "if a:0 > 1
                    "let l:c = a:2
                "else
                    "let l:c = 100
                "endif

                "return a:a + l:b + l:c
            "endfunction

            "if F(1) != 111 | throw 'assertion failed' | end
            "if F(2, 20) != 122 | throw 'assertion failed' | end
            "if F(3, 30, 300) != 333 | throw 'assertion failed' | end

    "#assign function to a variable

        " Must use the `function` function:

            "function! F()
                "return 1
            "endfunction

            "let A = function('F')

            ""ERROR: must be capital
                ""let a = function('F')

            "if A() != 1 | throw 'assertion failed' | end

        " Also works:

            "echo function('F')()
            "call function('F')()

"#exceptions

    " Throw:

        "throw 'abc'

    " Try catch finnaly:

        "try:
            "throw 'abc'
        "catch: /a./
            "echo 'a.'
        "catch:
            "echo 'default'
        "finally:
            "echo 'finnally'
        "endt
"#so

    "exe from given file (Source)

    "source this file:

        "so %

    "any vim output (ex `ec 1`) done in that file will be interpreted as an error.

    "#fini

        "stop sourcing script

            "fini
            "echo 1

"#command line

    " The line at the bottom (where `:` commands appear) is called the Vim
    " comand line or command prompt.

    "#echo

        " Print things to the Vim prompt:

            "echo 1
            "echo 'abc'
            "let a = 1
            "echo a

    "#cmdheight

        " Option that controls the height of the command prompt.

            "set cmdheight?
            "set cmdheight=2
            "set cmdheight=1

    "#hit enter to continue

        " If a command generates more message lines than the prompt height, Vim stops
        " everythig and require you to press hit enter to continue:

            "echo 1 | echo 2

    "#shortmess

        "TODO controls ammount of messages output.

    "#more

        " If the `more` boolean option is set,
        " and if there are more lines output to the prompt than
        " total terminal lines, those lines are put into a (very limited) pager:

            "for i in rante(0, 1000) | echo i | endfor

    "#silent

        " The `silent` command takes any command and ignores its prompt output.

        " Silent still shows vim exceptions and waits for confirmation:

            ":silent echo idontexist

        " If you add '!', then it also ignores errors:

            ":silent! echo idontexist

        " There must be no space between '!' and sil!! otherwise you get a shell command:

            ":silent ! ls
            ":silent ! echo idontexist

"#input

    " Take user input from the command prompt until he hits enter.

        "echo input("question\nhere:")

"#redir

    " Redirect output of any *vim command* (ex :ec 1) output (for sh stdout (:! ls), use <#r>)

    " Redir to var a:

        "redir =>a | echo 1 | redir END
        "if a != 1 | throw 'assertion failed' | end

    " Append ro var a:

        "redir =>>a

    " Redir to register a:

        "redir @a
            "echo 1
        "redir END

"#shell commands

    " Excecute shell commands:

        "! ls; ls

     "pass vim variable to bash command:

        "let a = 1
        "exe "! echo " . a

    "#system

        " Exec sh command and get stdout

            "let a = system('ec asdf')
            "echo a
                "asdf

            "let a = system('sort', "b\na")
            "echo a
                "a
                "b

            ":echo v:shell_error
                "constains return status of last command executed by shell after
                "- ``:!``
                "- ``:r !``
                "- calling ``system()``

    "#exit status of shell command

        " Is stored in `v:shell_error`

        " Same as `$?`

        " Works after:

        "- !
        "- r !
        "- system

"#buffer

    " Buffers are RAM memory versions of files, possibly without saved to disk changes

    " They may be open on one or more windows or not.

    " When you exit Vim, buffers are lost by default, unless you have some plugin that saves and restores them
    " such as vim session.

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

        " Show buffer list:

            "ls

        " Status:

        "- a: Active == loaded and   visible
        "- h: Hidden == loaded but invisible
        "- `%`: current.
        "- `#`: previous.

    " Add file to buffer list but don't load it:

        " bad f1.txt

    "#buffer command

        " Very useful because of the tab complete!

        " Load buffer in the buffer list and make it visible in cur window

        " Does not however add new buffers to the buffer list.

        " By number 2:

            "b 2

        " By path:

            "b file.txt

        " Tab complete matches in middle of file paths for open buffers.

        " If there is a single match for a substring of path, <enter> opens it.

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

        " Unload current but don't remove it from buffer list.

            ":bunload

        " Closes *all* windows in which it was visible.

    "#bdelete

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

    "#bwipe

        "Wipe. like `bdelete`, but also removes all bufer metadata data like marks.

    "#hidden option

        "TODO

    "#w

        "save cur buffer to disk:

            "w

        "if file does not exit, create it.

    "#alternate file

        " Then you open a buffer on top of another on a window, "for example with `:b`,
        " the old buffer is remembered and is called the *alternate file*.

        " You can toogle between the current and alternate file with <c-*>.

            ":b

        " This behaviour can be orverriden with `keepalt`.

    " Wipe all buffers without corresponding existing files:

        function! b:WipeBuffersWithoutFiles()
            let l:bufs = filter(
                range(1, bufnr('$')),
                'bufexists(v:val) && '.
                \'empty(getbufvar(v:val, "&buftype")) && '.
                \'!filereadable(bufname(v:val))'
            )
            if !empty(l:bufs)
                execute 'bwipe' join(l:bufs)
            endif
        endfunction

        "call it at every startup (TODO does not work)

            "call s:WipeBuffersWithoutFiles()

        "command WBWF call s:WipeBuffersWithoutFiles()

    "#scratch buffer

        " To create a buffer which contains only output which you want to
        " browse with Vim such as program output, use:

            "tabnew
            "setlocal buftype=nofile
            "setlocal bufhidden=wipe
            "setlocal noswapfile

        " It is not possible to save this buffer to a file,
        " and this buffer cannot conflict with any other since it has not
        " name.

        " Tabs containing this buffer show `[Scratch]` as the tab title.

        " If you want to save the contents of a scratch buffer to a file,
        " just use `w filename`.

    "#readonly

        " If true prevents file modification.

        " Less strict than modifiable.

    "#readonly

        " If false, prevents any buffer modification.

"#window

    " A window is a view of a buffer.

    " Multiple windows can be present in a single tab via splits.

    " A buffer may be visible in multiple windows.

    " Modifying a buffer in any window automatically modifies its view in other windows.

    " Close cur window:

        ":q

    " Does not delete its buffer from buffer list.

    " If this was the last visible window of the buffer,
    " also unloads the buffer.

    "  Close all windows and quit vim:

        ":qa

    "#only

        " Close all windows except cur one

    "#lines #columns

        " Total tab width, size of terminal window, not affected by splits.

        " Modifying it on GVim resizes the X window:

            "set lines=30
            "set columns=50

    "#winwidth #winheight

        " Minimal window width.

        " Set number of columns:

            "set winwidth=50

        " Minimum half of current window:

            "let &winwidth=(&columns/2)

    "#resize

        " Many options:

            "help window-resize

        " Set number of lines in window. Does not change window size: blank lines are added to end.

        " Fixed value:

            "resize 10

        " Relative values:

            "resize -5
            "resize +5

    "#winwidth() #get window width #winheight

        " Current window:

            "echo winwidth(0)
            "echo winheight(0)

        " Given window:

            "echo winwidth(2)
            "echo winheight(2)

    "#split #vsplit

        " Create an horizontal split with same bufer:

            "split

        " Set height of the new window:

            "50split

        " Vertical;

            "vsplit

        " Make both scroll at the same time;

            "vsplit
            "set scrollbind
            "norm <c-w>l
            "set scrollbind

    "#vertical

        " Execute command that would open an horizontal split but open a vertical split instead.

            "vertical help

"#tab

    " A tab is a collection of split windows.

    "#tab command


        "#tab command #:tab

            " Execute command, and if it would open a new window open a new tab
            " instead.

            " Ex: open help in a new tab instead of a new window.

                "tab help

"#exe

    " Execute string as a vim command

        "exe "let a = 10"

    " Multiple args are concatenated separated by space:

        "exe "echo 1 |" "echo 1"

    " Application: pass parameters to functions.

"#normal

    " Execute normal mode command:

        "normal! dd

    " This does *not* leave current mode and goes to normal mode, unless you tell it too
    " but has all the side effects of useing the commnad on normal mode.

    " With [!] execute normal mode command *without* mappings activated:

        "map a b

    " b:

        "normal! a

    " a:

        "normal! a

    " **always use this!!** unless you really want to use the user commands...  which is a rare case

    " Multiple commands:

        "normal! jj

    " Goes twice down.

    " Special chars:

        "exe "norm! \<s-v>"

    " Goes to line visual mode

"#editing commands

    "#print

        " Prints lines to prompt.

        " Current line:

            print

        "#number

            " Also print line number.

                number

    "#put

        " Insert `'abc'` on a new line after current line:

            "put = 'abc'

        " Insert from variable:

            "let a = 'abc'
            "put = a

        " Inserts content of register a:

            "put a

        " Put pefore cur line:

            "put! a

    "#delete

        " Delete lines, put them on register.

            "1,3d

    "#read

        " Inserts contents of file here (Read).

            "r a.txt

            "r !ls

    "#yank

        " Paste (Yank):

            "y

        " Yank to register a:

            "y a

        " Yank current line (same as yy so useless):

            "Y

        " Yank to clipboard;

            "map Y "+y

    "#t #copy

        " Copy line 3 after line 5 and before old line 6 (line 3 becomes the
        " new line 6):

            ":3t5

    "#move

        " Move line 3 to line 5:

            ":3m5

    "#join

        " Join current and next line:

            "j

        " Removes leading spaces of second line.

    "#global #:g

        " Does an arbitrary command on all lines that match a regexp.

        " Print all lines that match a regexp to command line:

            ":g/re/p

        " do `s/find1/replace` in each line that matches regexp `find0`.

            ":g/^find0/s/find1/replace

"#range

    " For many commands you can specify a line range of action

    " Lines 1 and 2:

        ":1,2p

    " From cur line to end:

        ".+1,$p

    " All lines before the current line

        ":1,.-1p

    " All lines:

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

"#autocmd

    "<http://www.ibm.com/developerworks/linux/library/l-vim-script-5/index.html>

    "execute command automatically on an event.

    "#events

        "list all events:

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

    " Map keys and key sequences to other sequences of keys. and view what they are mapped to.

    " Main help file:

        ":h map

    "#modes

        " First learn what one character mode descriptions mean in the modes section.

        " With:

            "help map-modes

        " We see that:

        " - `:map`  does `nvo` == normal + (visual + select) + operator pending
        " - `:vmap`  does `xs` == visual + select
        " - `:xmap`  only `x`  == visual visual only
        " - `:smap`  only `s`  == select only
        " - `:map!` does `ic`  == insert + command
        " - `:lmap` does `icl` == insert + command + LangArgs

            " TODO lmap is doing nothing for me. How does it work?

        " Test them out:

            "nmap <F9> echo 'nmap'<CR>
            "nmap <F9> echo 'vmap'<CR>
            "imap <F9> echo 'imap'<CR>
            "cmap <F9> echo 'cmap'<CR>

    "#no versions

        " Don't remap recursivelly

        " Always use this to avoid lots of confusion =)

        " A and b become c:

            "map! a b
            "map! b c

        " A becomes b, b become c:

            "noremap! a b
            "noremap! b c

    "#! versions

        " Without exclamation: map on all command like modes: normal, visual, ...
        " With               :            insert            : insert, command, ...

            "noremap  a b
            "noremap! a b

        " But cannot use exclamation with mode also:

            "noremap! a b

        " Makes no sense

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

                "function! F()
                    "echo 1
                  "endfunction

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

            "Control keys that can be mapped

                "http://vimhelp.appspot.com/vim_faq.txt.html#faq-20.5

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

            " Non-examples:

            " - c-c: terminate process
            " - c-s: stop foreground process
            " - c-q: resume after c-s
            " - c-z: stop foreground process and put it on background
            " - c-d: eof
            " - c-v c-X: enter a literal control char

    "#which keys are a good idea to map

        "very useful manual section:

            "h map-which-keys

        "summary:

        "- use `<c-` or `<s-` for commands that must be done repeatedly several times

            "instead of two key combinations like `<leaders>a`

    "Allow map and motions to work together:

        "h map-operator

"#abbreviate #noreabbrev

    " Lists and creates abbreviations.

    " Abbreviations expand only if the character that follows them is non
    " alphanumeric.

    " For sanity always use hte nore version, which is analogous to mappings.

    " Example:

        "noreabbrev a abc

    " Now if you type:

        "a<space>
        "a.
        "ab<space>

    " You get repectively:

        "abc<space>
        "abc.
        "ab<space>

    " Abbreviate only on command mode:

        "cnoreabbrev a abc

    " Remove abbreviations for given trigger (including command mode ones):

        "unabbreviate a

"#bufdo #tabdo #windo

    " Do a command on all buffers, tabs or windows.

"#set #options

    " Set allows to view and modify options, which are global variables
    " that control Vim's operation.

    " Main help page:

        "h options

    " To get help on options, surround them with single quotes as:

        "h 'filetype'

    " View value of an option

        "set ft?

    " Set value on non boolean option:

        "set ft=vim

    " Set value of boolean option to true:

        "set expandtab

    " Set value of boolean option to false:

        "set noexpandtab

    " All non-negated boolean options support a `<no>name` version.

    " Toogle value of boolean optoin (only applicable to boolean options):

        "set wrapscan!

    " Get value of option programatically / to a variable.

        "echo &ft

    " Set variable from option (USE `let`!!):

        "let &option=variable

    " Just add ampersand.

    "#setlocal

        " Sets option only for cur buffer.

        " Only some options can have local values.

        " Should always be used instead of `:set` in ftplugin files which are
        " sourced for every file of a given type.

    "#misc options

        " This is a list of options that did not fit anywhere else,
        " by order or decreasing utility.

        "#modified

            " Determies if the current buffer has been modified or not since
            " last save. by default, modified buffers get a plus sign `+`
            " added to their titles.

                "set modified

        "#buftype

            " Sets the type of the buffer.

            " - `nofile`: buffer has no coresponding file. Cannot be saved.

                " Useful for buffers that will contain temporary data buffers.

        "#bufhidden

            " Determines what to do with bufferst that don't show in any
            " window.

            " - `wip`: does a `bwipe`. Good option for temporary buffers.

"#builtin functions

    "#file operations #path operations

        "check file exists and is radable:

            "if filereadable("SpecificFile")
                "echo "SpecificFile exists"
            "en

        "#dirname

            "for a file or directory not enting in slash:

                "if fnamemodify('/a/b', ':h') != '/a' | throw 'assertion failed' | endif
                "if fnamemodify('/a/b/', ':h') != '/a/b' | throw 'assertion failed' | endif

            "whatch out for trailling slashes since that changes the meaning...

            "don't use `:p` since this makes no sense and does not work if the path does not exists!

        "ls path

            ":echo globpath(path, '*')

        "find .:

            ":echo split(globpath('.', '**'), '\n')

        "os path join: vim autoconverts `/` in paths to the correct os separator (ex Windows `\`)

        "#pathshortlen

            "Converts:

                "/path/to/file.txt

            "To:

                "/p/t/file.txt

            "Useful wiht setguilabel.

    "#expand #%:p #filename-modifiers

            "echo expand('%:r')

        " In shell commands the expand function can be omitted:

            "!echo %:p

        " For the possible things you can expand see:

            "h filename-modifiers

        " Important ones. Test path: `/a/b/f.ext`

        "- p: full path
        "- r: basename without extension
        "- e: extension

    "#position #line

        " Get cur line number:

            "echo line(".")

        " Get last line number in buffer:

            "echo line("$")

        " Get first line of last visual selection:

            "echo line("'<")

        "last one:

            "echo line("'>")

        "get cur column

            "echo column(".")

        "get cur line number, column, buffer

            "getpos():

        "returns:

            "[bufnum, lnum, col, off]

        "setpos() with same args to set (last can be ommitted):

            "setpos (0,2,3)

        "if buf number 0 means in current buffer

        "another way to set position:

            "cursor(line, col)

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
            "function! SetSelection(x, y, x2, y2, ...)
                "let valid_mode_strings = ["v","\<s-v>","\<c-v>"]

                "if a:0 > 0
                    "if index(valid_mode_strings, a:1) >= 0
                        "let mode = a:1
                    "el
                        "th 'bad mode argument: ' . a:1 . ' valid options: ' . join(valid_mode_strings, ', ')
                    "en
                "el
                    "let mode = 'v'
                "en

                "let oldpos = getpos('.')

                "if setpos('.', [0,a:x,a:y]) != 0
                    "exe "norm! \<esc>"
                    "th 'bad position argument: ' . a:x . ' ' . a:y . ' ' . a:x2 . ' ' . a:y2
                "en

                "exe 'norm! ' . mode

                "if setpos('.', [0,a:x2,a:y2]) != 0
                    "exe "norm! \<esc>"
                    "call setpos('.', oldpos)
                    "th 'bad position argument: ' . a:x . ' ' . a:y . ' ' . a:x2 . ' ' . a:y2
                "en
              "endfunction

    "#mode()

        " Get current mode representation string:

            "echo mode()

        " Set mode:

            "normal! v

            "execute "normal! " . mode

    "#visualmode()

        " Get string representing type of last visual mode on cur buffer:

        " - `v`:   charcter
        " - `V`:   line
        " - `^V`:  block

        " This can be used with `normal!` to set back to last visual mode:

            "execute 'normal! ' . visualmode()

    "#buffer content

        "#getline

            " Get content of current buffer lines.

            " Get content of cur line:

                "echo getline(".")

            " Get a list of line strings from line 1 to line 3:

                "echo getline(1, 3)

            " All lines of buffer:

                "echo getline(1, line("$"))

        "#append

            " Insert lines into the buffer.

            " Insert a new first line:

                "call append(0, "new line 1")

            " Insert multiple lines:

                "call append(0, ["new line 1", "new line 2"])

            " Must use a list for that.

            " Also consider the `put` command.

    "#search

        "same as '\' but:

        "- is a function
        "- does not set last jump mark (for use with `<c-o>` for example)

        "returns:

        "- line number if match
        "- 0 if no match

        "it is therefore preferable in vimscript.

            "call search('a')
            "call search('\va')

        "don't move cursor:

            "call search('a', 'n')

        "backwards:

            "call search('a','b')

        "wrap around end (default):

            "call search('a','w')

        "don't wrap around end:

            "call search('a','W')

        "end of match:

            "call search('ab','e')

        "stops at 'b' instead of 'a'

        "start search from under cursor

            "call search('a','c')

        "by default, if you are over an 'a' char and to search a,
        "you will move to next match. But not with 'c'.

        "get column too:

            "searchpos('a')

        "get line and pos of match start and end:

            "TODO

        "search for pairs like 'if' 'else':

            "searchpair(TODO)

    "#getreg

        " Get value of a register from vimscript:

            "normal! '"ay'
            "echo getreg('a')

"#regex

    " Pearl like but... not really.

    " By default must escape some chars for them *to be* magic but not others...

    " But you can change that with modifying chars and using one of the four flavors:

    " - magic
    " - non magic
    " - very magic
    " - very non magic

    " I only recommend using very magic and very non-magic for you own sanity
    " since in those modes it is easy to remember what is what.

    " Note however that very magic is even more magic than Perl! (e.g.: `<` and
    " `>` are word boundaries).

    " For explanations

        ":h regex

    "#very non magic

        " Becomes not a regex, everything is literal, unless escaped by \:

        " Default regex:

            "/.*

        " Very non-magic:

            "/\V\.\*

    "#very magic

        " You can change the flavour with \v! with \v, meaning Very magic,
        " only: [A-Za-0-9_] are not magic and thigs really work like in perl!

        " Example:

        " Default regex:

            "/\(a\+\)

        " Very magic regex:

            "/\v(a+)

        " You should always use very magic.

        " Points in which very magic is more magic than Perl

        " - `<` and `>` for word boundaries. This is insanely useful to find single character variables: `<x>`.
        " - `=` TODO same as `?`?

    "#change default flavor

        " Cannot be done: <http://stackoverflow.com/questions/3760444/in-vim-is-there-a-way-to-set-very-magic-permanently-and-globally>

        " Would break too may plugings.

    "#classes

        " - \w   alpha (a-zA-z)
        " - \n     a newline character (line ending)
        " - \s   whitespace except newline
        " - \S   non-whitespace
        " - \_s     a whitespace (space or tab) or newline character
        " - \_^     the beginning of a line (zero width)
        " - \_$     the end of a line (zero width)
        " - \_.     any character including a newline

    "#escaping in default mode

        " If you really use default mode, here the escape list follows.

        " Escape to be literal:

        " - .      wildcard
        " - a*     repetition
        " - [abc]  char classes
        " - ^      begin
        " - $      end

        " Escape to be magic:

        " - a\+
        " - a\(b\|c\)
        " - a\|b
        " - a\{1,3}
        " - a\{-}        non greedy repeat. Analogous to {,}, mnemonic: match less because of `-` sign.
        " - \<           word boundary left
        " - \>           word boundary right
        " - \1           mathing group 1. can be used on search
        " - /\(\w\)\1  search equal adjacent chars

    "#s

        " Replace in buffer.

        " Capture group:

            ":s/\(a\)/\1/

        " Set first letter of each line to uppercase:

            ":s/.*/\u&

        " Sets first letter of each line to lowercase:

            ":s/.*/\l&

        "#multiline

            " `\n` vs `\r` confusion: <http://stackoverflow.com/questions/71417/why-is-r-a-newline-for-vim>

            " When searching `\n` is a newline char, `\r` <CR>

            " When replacing `\n` is the null byte and `\r` a newline char

            " Replace two or more newlinews for two newlines:

                ":%s/\n\n+/\r\r/

        " Confirm each match replace before doing it:

            ":%s/a/a/c

        " Options:

        " - y: yes
        " - n: no
        " - a: replace all remaining
        " - q: quit
        " - l: last == yes and quit

    "#substitute

        " Regexp replace in vimscript:

        " Arguments are:

        " - test string
        " - regexp find
        " - replace
        " - replace flags

            "if substitute('abc', 'a\(.\)c', '\1', '') != 'b' | throw 'assertion failed' | end

    "#=~ #!~

        " Check if string matches regex:

            "if 'abc' =~ 'a.c' | | else | throw 'assertion failed' | end
            "if 'abc' !~ 'a.c' |          throw 'assertion failed' | end

    "#match

        " Returns start of match index. If no match return `-1`.

            "if match('abc', '\v.c') != 1 | throw 'assertion failed' | end
            "if match('abc', '\v.b') != 0 | throw 'assertion failed' | end
            "if match('abc', '\vd')  != -1 | throw 'assertion failed' | end

    "#matchlist

        " Get list of matches, first the full match, then capturing groups.

        " This is the best way to use capturing groups.

            "let matches = matchlist('abcde', '\v(a.)c(.e)')
            "if matches[0] != 'abcde' | throw 'assertion failed' | end
            "if matches[1] != 'ab'    | throw 'assertion failed' | end
            "if matches[2] != 'de'    | throw 'assertion failed' | end

        " If no match is found, return the empty list `[]`:

            "if matchlist('abcde', '\vac') != [] | throw 'assertion failed' | end

    "#matchstr

        " Get matching string. Same as `matchlist()[0]`.

            "if matchstr('abc', '\v.c') != 'bc' | throw 'assertion failed' | end
            "if matchstr('abc', '\v.b') != 'ab' | throw 'assertion failed' | end

    "#perldo

        " If compiled with perl support (`vim --version | grep perl`),
        " you can use `perldo` for replacements with pure Perl regexps:

        " Ex:

            ":pe $a = 'b'
            ":perldo s/$a(.)/c\1/g

"#quickfix #makeprg

    " Try it out:

        "set makeprg='cat'
        "make %
        "copen

    " - :make    runs commands based on the `makeprg` option on a shell and captures its output.
    "
    "       The default value for `makeprg` is `make`, so by default `:make` runs `make`.
    "
    "       See h makeprg
    "
    " - :copen   open everything that came out of the :make command or :vimgrep command, one per line.
    "
    "       Works well with tab:
    "
    "           tab copen
    "
    "       <enter> jumps to the line of the error on the buffer.
    "
    " - :cc      see the current error
    " - :cn      jump to next error on buffer.
    " - :cp      jump to previous error
    " - :clist   list all errors

    " On the quickfix window:

    " - <enter>:   jump to file and line of error under cursor

    " Options:

    " - `switchbuff`: Controls how buffers are opened.

        " - `newtab`: open buffers on a new tab
        " - `usetab`: if an existing tab exists with buffer, use it

           set switchbuf+=usetab,newtab

    "#grep #vimgrep

        " Same as `:make` , but specialized to generating output by grepping files.

        " `errorformat` is replaced by `grepformat`.

        " - mimgrep uses Vim's internal regexes and is threrefore more portable
        " - grep uses the external utility.

        " Perfect for file navigation. On a markdown file, try:

            "vimgrep '^#' %
            "tab copen

        " And you now have a navigable index!

    "#errorformat #grepformat

        " Those options affect **only** how the input is parsed, not how the quickfix looks.

        " There seems to be no way of doing that: <http://stackoverflow.com/questions/11199068/how-to-format-vim-quickfix-entry/11202758#11202758>

"#python vim scripting

    " You can script vim with python instead of vimscript!!!

    " This is a **GREAT** feature!!! no more vimscript for me except for the most simple tasks!!!

    " h python-vim

    " For this to work you need:

    " - python!
    " - vim compiled with python support

    " Separate commands go to the same python session:

        "py a = 1
        "py a = a + 1
        "py assert a == 2

    " Commands:

        ":py vim.command('p')               "execute an Ex command

    " Normal mode commands:

        ":py vim.command('normal j')        "down one line

    " Window:

        ":py w = vim.windows[n]             "gets window "n"
        ":py cw = vim.current.window        "gets the current window
        ":py w.height = lines               "sets the window height
        ":py w.cursor = (row, col)          "sets the window cursor position
        ":py pos = w.cursor                 "gets a tuple (row, col)

    " Buffer:

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

        " Evaluate a vim expression and get its result into python

        " Returns:

        " - a string if the Vim expression evaluates to a string or number
        " - a list if the Vim expression evaluates to a Vim list
        " - a dictionary if the Vim expression evaluates to a Vim dictionary

        " Pass a vim integer variable to python:

            ":let a = 1
            ":py a = int(vim.eval('a'))
            ":py assert a + 1 == 2

    "#python to vim

        "

    " Multiline python code:

"py << EOF
"def f():
    "print 1
"EOF

    "function! PythonTest()
        "py f()
      "endfunction

"#configuration #startup #initialization

    "<http://www.22ideastreet.com/debug/vim-directory-structure/>

    " Help on startup sequence:

        ":h startup

    " Show the order in which scripts are run (including filetype plugins that
    " were not run for the current filetype):

        ":scriptnames

    "#where something is set

        " See verb.

    "#verb

        " Verbose info on commands.

        " Often shows which file last set something!

        " Very useful to debug.

        " Maps:

            "verb map a

        " Options:

            "verb set ft?

    "#plugins

        " One very important thing that is executed **after** reading `.vimrc`:

            "runtime! plugin/**/*.vim

        " This is how plugins are loaded automatically.

    "#runtimepath #rtp

            "set rtp?

        " Vim source path

        " Comma separated list of palces where TODO

        " Important stuff that is there by default on linux:

        "- `/usr/share/vim` and some subdirs. Installation default.
        "- `~/.vim/`.       User managed.
        "- `~/.vim/after/`. User managed. Comes after plugins.

        "#runtime

            "- search in rtp
            "- so all files found
            "- no error if non found
            "- wildcards work:

                "ru plutin/*.vim

"#ftplugin #filetype

    " Plugins that autocmd sources only for particular types of files

        "h ftplugin

    " For those to work, you must first detect the type of file:

    " List all known filetypes:

        ":echo glob($VIMRUNTIME . '/ftplugin/*.vim')

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

            "filetype
            "filet

        "turn on filetype detection:

            "filetype on

        "this ources $VIMRUNTIME/filetype.vim, which in short does lots of
        "au for lots of known file types.

        "detect filetype for current file again using the default scripts:

            "filetype detect

    "#create new filetype

        "very well explained here:

            "h new-filetype

    "#default ftplugin sourcing

        " Vim comes with good defaults for loading plugins only for given filetypes.

        " Turn on ftplugins detection:

            "ftplugin on

        " This ources $VIMRUNTIME/ftplugin.vim which in short executes all files inside

            ":ru! /ftplugin/

        " With vim extensions .vim in this directory and subdirectories
        " when the buffer of the right filetype enters.

        " For example for `c` files the following would all be sourced (in alphabetical path order)

            "c.vim
            "c_extra.vim
            "c/settings.vim

        " '_' is required to separate c form the arbitrary rest of the name

        " As explained in the help:

        " - always use setlocal      instead of set
        " -            map <buffer>             map

    "#override defaults

        " This is currently a pain.

        " One possibility, is to use:

            "autocmd BufEnter *
            "autocmd FileType html

        " Directlyl into your vimrc.

        " Another possibility is to:

            "autocmd BufEnter so ~/.vimrc.after

        " And put everything that you want sourced after ftplugins in that file.

        " Another possibility is to use `after/ftplugin`, but the problem with 
        " that option is that it only works for single files.

    "#default indent sourcing

        " Exact same idea as ftplugin, but replace plugin by indent.

"#ins-complete #autocompletion #complete

    " While there are many hardcore autocompletion plugins, Vim does come with a
    "and simple autocomplete method.

    " For help see

        ":h ins-completion

    " Test with the following:

        "viado
        "vitelo

        "vi<cursor>

        "vishnu
        "vim

    " There are many methods of opening the autocomplete popup, most of which start with <c-x>.
    " except the most useful ones =):

    " - <c-p> (Previous) and <c-n> (Next) determine what do scan based on the 'complete' option

        " By default, `'complete'` searches for tons of things in a reasonable default order, first in current buffer,
        " and also includes matches in other open windows, buffers.

        " See:

            "set complete?
            "help 'complete'

        " To know exactly what is searched for.

    " Once the popup is open, you can:

    " - <c-p> and <c-n>: navigate matches
    " - <esc> cancels the completion.
    " - <c-y> (Yes?) accepts the completion and inserts nothing
    " - <bs>  remove characters from the current suggestion, and reopen the completion

    " Any other character typed accepts the completion, and inserts the character.
    " Common options then are `<space>`, `.` or other punctuation chars.

    " The greates downside of this method is that the popup does not open automatically,
    " and if you want to continue typing the word to reduce the match list it simply completes.

    "#pumvisible()

        " Check if autocomplete PopUp Menu is visible. Useful to define mappings that only apply on the menu
        " as shown at:
        " <http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE>

    " The main downsides of the built-in autocopmletion are:

    " - it is hard to correct the completion

    "#ofu

        " TODO

            " set ofu=syntaxcomplete#Complete

"#find

    ":find
    ":sfind
    ":tabfind
    "find in vim path var, and edit here, split, new tab

"#ftp

    " Vim has built-in ftp! =)

    " Open file browser:

        "vim ftp://username@host:port/

    " You will be asked for password

    " Navigate file browser (TODO):

    " Open file:

        "vim ftp://username@host:port/path/to/file.html

"#diff

    " Open vertical split representing diff between current file and the other:

        "vert diffsplit <otherfile>

    " From the command line:

        "vimdiff a b

"#tags

    "<http://vim.wikia.com/wiki/Browsing_programs_with_tags>

    " List and jump to definitions of functions or variables.

    "#generate tags

        " Before jumping to tags, you have to generate them with an external program.

        " Tags must be placed in a file called tags in the current directory (TODO check)

        "` Tags` is a POSIX possibility. `exuberant-ctags` is more complete non standard possibility

        " Generate tags in all subdirs POSIX 7 compliant:

            "for d in `find . -type d`; do cd $d && ctags *.h; done

        " TODO write an append code for this that puts tags on current dir.

        " Using gnu ctags:

            "ctags -R

        " Will generate a t

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
