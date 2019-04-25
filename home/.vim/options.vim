" Settings that control vim behaviour, mostly set with `set` and `autocmd`.

" # filetype

  " Some of those settings are set with vundle#end as they are required by vundle.

  " Must be hte first thing after vundle#end().

  " Set autodetect filetype and set it for buffers:

    "filetype on

  " This allows the following to work properly:

  " Plugins for given filetypes:

    "filetype plugin on

  " Indent for specific filetypes

    "filetype indent on

" # colorscheme

  " Silent because on the first run it is not yet installed.

  " Must come after vundle#end.

    silent! colorscheme vividchalk

" # modeline

  " If on, Vim will read options from one of the first comment `modelines` lines (default 5)
  " at the top of the file.

  " This is specially useful for setting filetypes on files without extension not shebang
  " such as Vagrantfiles with something of the type:

  "   # vi: set ft=ruby :

  " Default: 5.

    " set modeline=5

" # Search options

  " Control parameters of `/` search

    set hlsearch    " highlight search terms
    set incsearch   " match as you type each new character
    set ignorecase  " ignore case when searching
    set smartcase   " ignore case if search pattern is all lowercase,
                    " case-sensitive otherwise
    set showmatch   " set show matching parenthesis
    set wrapscan    " wrap around end of document (default)
    " set nowrapscan " do not wrap around

  " # path

    " Path of the `find` command.
    " The default path is useless because it does not find recursively,
    " so just wipe it.

      set path=./**/
      "set path=./**,/usr/include/**,/usr/local/include/**

  " Stop current highlighting:

    " noh

  " Will be automatically turned back on on next search

" # Tab completion options

  " # wildchar

    " Character that opens tab completion. Default: `<tab>`...

      " set wildchar=<tab>

  " # wildignore

    " Patterns to ignore on several types of expansion,
    " including command tab expansion.

    " Default value: empty.

    " Great to avoid expanding built files like .o and .pdf
    " when those are placed in the current directory, which
    " is a very common convention!

      set wildignore+=*.class,*.elf,*.jpg,*.jpeg,*.o,*.out,*.pdf,*.png,*.pyc,*.img

    " Then in the rare cases that you want to open those up,
    " just expand and change the extension, or change wildignore for a session.

" Working directory is always the same as the file being edited

  set autochdir

" Disable vim mouse capture.
" All mouse clicks to the terminal instead.
" Because the mouse is for newbs, and it breaks copy paste over putty,
" where +* registers are just broken.

  set mouse=

" # backup

" # swp

  set nobackup
  " set backupdir=~/tmp   "where to create backups if need be so
  " set writebackup
  " set backupskip=/tmp

  set noswapfile
  " set directory=~/tmp   "same as backupdir but for swaps

" Automatically load files that were modified externally

  set autoread

" Reduce standard message verbosity:

  set shortmess=atI

" Command tab completion

  set wildmenu
  " First tab lists all matching options, then if you don't enter any more characters,
  " the following tab loop through the matching options.
  "http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
  set wildmode=longest,list,full
  " command history size
  set history=1000

" # undo

  " Vim 7.3 added persistent undo: undo history is saved even for closed
  " buffers!

    set undofile                " Save undo's after file closes
    set undodir=$HOME/.vim/undo " Where to save undo histories
    set undolevels=1000         " How many undos
    set undoreload=10000        " Number of lines to save for undo

" Maintains at least 4 lines in view from the cursor

  set scrolloff=4

" Font size

  set guifont=8

" # number

" # LineNr

  " Show line numbers on left of page:

    set number

  " Show numbers relative to current line. Fun and insane:

    set norelativenumber

  " Minimum number of spaces to leave for line numbers. Automatically increases as needed.
  " so just use the minimum 1.

    set numberwidth=1

  " Color can be configured with:

    " highlight LineNr ctermfg=grey

  " # CursorLineNR

    " In more recent versions of Vim, hl-CursorLineNR can be used to highlight only the number
    " of the current line.

" # wrapping

    set nowrap
    set nolinebreak                       " Break only at characters in breakat or not.
    " set breakat=                         " At which characters it is possible to break. Default is good.
    " let &showbreak = '>'.repeat(' ', 8)  " What to show on the new broken line.
    set nolist

  " # textwidth

    " After given column width, Vim will automatically insert a newline (hard wrap)
    " after the first space.

    " 0 to disable.

    " If you use filetype needs and autocommand because most of the default filetypes set this to true.
    " I prefer to highlight long lines and break lines mysefl.

      autocmd Bufenter * set textwidth=0

  " # wrapmargin

    " Like `textwidth`, but counts the number of columns from the right of the screen.

    " Only takes effect if `textwidth=0`.

    " Disabled by `wrapmargin=0`.

      set wrapmargin=0

  " # colorcolumn

  " # Print margin

    " Highlight given columns differently to help manually maintaining column width. E.g.:

      " set colorcolumn=80,100

    " Disable:

      " set colorcolumn=

" # startofline

  " If true, commands like `G` and `gg` go the first column.

  " Else, they keep the current column if possible.

    set startofline

" # formatoptions

  " Do not automatically continue comments that start on the first line
  " when using enter (it will still happen when using `o`).

  " As of 7.3, this would overriden by most pesky default ftplugins.

    " set formatoptions-=r

  " Same as above but for `o`:

    set formatoptions-=o

" Stop adding spaces after `.` on `J` and `:j`:

  set nojoinspaces

" # ruler

  " The ruler is at the right bottom where there is info about:
  " line, column and percentage of current file in the same space for commands.

    set ruler

" # statusline

" # laststatus

  " Line that always shows at the bottom, above the command line.

  " Can contain whatever you want.

  " Enable / disable statusline:

      set laststatus=0

  " Disable because it takes on extra line. If only I could format the *command line* instead.

  " Set what you want it to contain. Accepts % substitutions.

  " Filename:

      " set statusline+=%f

  " Current highlight group name:

      " set laststatus=2
      set statusline=%{synIDattr(synID(line('.'),col('.'),1),'name')}

" # tabwindow

  " Format tab titles:

    set guitablabel=%N)\ %t\ %M
    " set guitablabel=%!expand(\"\%:p\")
    " set guitablabel=%!pathshorten(expand(\"\%:p\"))

  " %N: tab number from left to right
  " %t: basename of loaded buffer
  " %M: modify status (a '+' if modified)

  " TODO rename a single tab: http://superuser.com/questions/715928/vim-change-label-for-specific-tab
  " file is somewhat close, but it actually renames the buffer: next write will write to the new file name.

" # switchbuf

  " Controls how buffers are opened. Used by several commands, including `quickfix` and `sbuffer`.

  " - `newtab`: open buffers on a new tab. But it does not work very we
  " - `usetab`: if an existing window exists with buffer, use it

      set switchbuf=newtab

  " For a plugin that defines some mappings, see: https://github.com/yssl/QFEnter

" # showtabline

  " When to show the tabs:

  " - 0: never
  " - 1: only if there are 2 or more tabs
  " - 2: always

" Allow backspacing over everything in insert mode:

  set backspace=indent,eol,start

" # Indentation

  set expandtab     " Insert spaces instead of tabs.
  set tabstop=4     " A tab viewed as N spaces.
  " set softtabstop " TODO
  set smarttab      " Insert tabs on the start of a line according to
                    " shiftwidth, not tabstop.
  set shiftwidth=4  " Number of spaces to use for autoindenting.
  set autoindent    " Always set autoindenting on.
  set copyindent    " Copy the previous indentation on autoindenting.
  set shiftround    " Use multiple of shiftwidth when indenting with '<' and '>'.

" # ff

" # fileformat

" # fileformats

  " `fileformat` determine what will be the line terminator for the current buffer:
  " `unix`, `dos` or `mac`.

  " Vim tries auto-detect this value on new buffers. Auto-detect can only yield values in `fileformats`.

  " `fileformat` gives a default if auto-detect fails.

  " When you do `set ff=X`, the buffer is modified such that every
  " current EOF string is replaced by the new one.

  " When searching for CR when `dos` is set does not find CR on LF CR pairs:
  " only rogue CRs.

" # EOL

  " System independant end of line. `\n` on Linux, `\r` on Mac OS X, `\n\r` on Windows.

" # eol

" # endofline

" # binary

" # newline at end of file

  " If `eol` and `binary` are on, Vim adds an <EOL>
  " at the end of file if it does not have one already.

  " `eol` is automatically set when opening a new file if it ends in <EOL>.
  " Therefore, if `binary` is on, Vim maintains the file state,
  " which is what you should to.

  " If `binary` is off, `eol` is not used.

  " The downsides of having `binary` are that:

  " -   you cannot view or remove the <EOL> easily.

  "     Workaround: `!truncate -1 %` (-2 on Windows...)

  " -   if you forget to set the default behavior for new files
  "     to match the projects standards, you may break them
  "     and there will be no immediate visual indiation of that
  "     (except for `git diff`).

  "     Workaround: never create, always copy existing files,
  "     or use a local vimrc that sets binary.

  " -   it is confusing for new Vim users.

  " If you keep the default magic you have the upside that:

  " -   don't have to worry about different per project
  "     / per file type conventions.

  " This default is a good design choice by Vim,
  " specially once you understand that there is magic going on.

  " When you open a non-empty file that does not end in a newline,
  " it shows [noeol] on the status line. You can see this anytime by doing `e`.

  " Setting binary automatically sets some other options, e.g. `expandtab` to off.

    set nobinary

" # Binary file edit

  " TODO how to edit a binary file?

" # encoding #fileenconding #utf8 #bomb

  " http://stackoverflow.com/questions/16507777/vim-set-encoding-and-fileencoding-utf-8

" # fold

  " # foldmethod

    " There are a few diferent methods.

    " - `expr`: based on any expression or function. Most powerful.

        " set foldmethod=indent

  " # foldlevel

    " Set how deep fold currently is:

      " set foldlevel=3

    " Level `0` menas everything is folded.

    " This can be modified by many default mappings such as
    " zr, zR, zm and, zM

  " Deepest allowed fold:

    " set foldnestmax=3

  " # foldenable

    " It true, fold is turned off:

      set nofoldenable

    " `zi` toogles this by default.

    " Useful to turn fold on and off. The current foldlevel is kept.

  set cmdheight=1
  set title

" # conceal

  " The thing that renders onscreeen Greek, underline, etc. in LaTeX for example.

  " g:tex_conceal=""

    set conceallevel=0

" # spell

  " On the fly spell checker that underlines errors.

    let s:spellfile = $HOME . "/.vim/spell/en.utf-8.add"
    let &spellfile = s:spellfile
    " In which file types to spellcheck.
    augroup Spell
      autocmd!
      autocmd Filetype gitcommit,haml,html,latex,markdown,rst,tex setlocal spell spelllang=en
    augroup END

  " After editing the spell file, use this to generate
  " the machine readable file that Vim really uses:

    execute 'silent mkspell! ' . s:spellfile . '.spl ' . s:spellfile

  " I do it every time at startup to synchronize changes
  " across my multiple devices.

  " Features:

  " - to add word under cursor to the dictionary

  " - view correction suggestions and possibly correct

  " - jump to next incorrect word

  " - for code filetypes, only checks spelling on comments and strings.

  " - spell can be done only at certain syntax highlighing regions. This allows for example to
  "   check spell only in comments of `.c` files, or ignore `<div>` tags in HTML.

  " Main help page:

  "   help spell

  " Enable for all files by default:

  "   set spell

  " Set language:

  "   set spelllang=en_us

  " Enable only for certain filetypes:

  "   autocmd BufEnter *.{md,rst,html,haml,tex} setlocal spell spelllang=en_us

  " Keymaps:

  " - `]s`: move to next misspelled word

  " - `z=`: show and select from suggestion list

  " - `zg`: add words under cursor to dict (Good).

  " - `zw`: add word negated to dict `word/!` and comment out if existing by replacing first char.

    " Rationale: performance. Deleting a line requires to rewrite the entire file:
    " appending and replacing one char not.

    " This mess can be cleaned up with:

    " :runtime spell/cleanadd.vim

  " - `zug` and `zuw`: undo `zg` and `zw`, removing entry from spellfile.

    " Those words are added to a separate file from the main dictionary,
    " determined by the spellfile option.

    " zw does not simply remove words: it adds it as wrong as `word/!`

  " # spellfile

    " Where words added via `zg` and `zw` will be stored.

    " If empty, use the first writable directory of `runtimepath` and add a `spell` subdir to it.

    " Must end in `.{encoding}.add`:

      " set spellfile=$HOME/.vim/spell/en.utf-8.add

    " This file is plaintext.

    " # mkspell

    " To speed things up, Vim uses a binary cache file with extension `.spl`. in the same directory.

    " For a spellfile with name `en.utf-8.add`, the corresponding `.spl` is: `en.utf-8.add.spl`.

    " Note that `add` is still part of the filename!

    " The cache is updated automatically by `zg` and `zw`.

    " Renerate the cache after manually editing the `.add` file:

      " mkspell! ~/.vim/spell/en.utf-8.add.spl ~/.vim/spell/en.utf-8.add

      " # Syntax

      " Comments:

        " # Comment

      " Use two number signs `##` for manual comments:

        " ## Comment

      " as comments with a single sign can be removed with the cleanup script.

      " Mark word as wrong:

        " word\!

      " Smart case: words with at least one capital are automatically case sensitive.
      " Every word also matches the same word with all capitals.

      " Fix case given word:

        " word\=

      " TODO: is there a map that does `gz` bu adds as /= ?
      " TODO: how to prevent Git from marking fixed case words
      "       that start with lowercase as wrong if at start of sentence?

      " Optionally add an s to the end of the word.

      "   word\S

      " TODO how to set possessive apostrophe to correct automatically, i.e.: `abc's` correct if `abc` correct?

    " Chinese spelling

      " To ignore it: http://unix.stackexchange.com/questions/192817/complete-language-abbreviation-list-for-vims-set-spelllang-option

      " On recent Vim versions, the magic `cjk` value for `spelllang` ignores Chinese.

" # matchit

  " Allows '%' to jump between open 'if' 'else', 'do', 'done', etc. instead.
  " of just parenthesis like chars
  " marcros/matchit.vim has been a standard file for years

    runtime macros/matchit.vim

" # sessions

    set sessionoptions=blank,buffers,folds,globals,help,options,resize,tabpages,winpos,winsize
    set viminfo=

" # 'shell'

  " Path of the shell to use for ~ commands:

    " set shell?

" # shellcmdflag

  " Flags to pass for the shell called with !.

  " Last flag should always be `-c` for bash to actually execute the command.

  " `-i` makes the shell interactive, so it will read your aliases under ~/.bashrc.

    set shellcmdflag=-c

" # gvim specific

" # GUI specific

  if has('gui_running')

      " TODO Maximize screen at startup.
      " http://stackoverflow.com/questions/4722684/how-do-i-start-gvim-with-a-maximized-window
      " Possibilities:
      " - `gvim -geometry 9999x9999` but on Ubuntu 12.04 cannot launch Vim from command line.
      " - `set lines=999 columns=999`, but this crashes vim on Ubun1u 12.04.

      set guioptions-=m  " Remove menu bar.
      set guioptions-=T  " Remove toolbar.
      set guioptions-=r  " Remove right-hand scroll bar.
      set guioptions-=b  " Remove right-hand scroll bar.

    " Normally, pressing alt focuses on the menu in gvim, but vim needs NO menu:
    " Vim only needs vimrc!

      set winaltkeys=no

    " TODO: start gvim fullscreen:

    " - http://superuser.com/questions/140419/how-to-start-gvim-maximized
    " - http://askubuntu.com/questions/2140/is-there-a-way-to-turn-gvim-into-fullscreen-mode
    " - http://stackoverflow.com/questions/14044004/gvim-7-3-in-fullscreen-mode

    " wmctrl -xa gvim -b toggle,fullscreen has the following downsides:

    " - hides the full file path on the window title.
    "   I'd like to show it on the command line, but seems impossible?
    " - Alt + tab does not show the window list on Ubuntu 15.10,
    "   although it still changes windows.

  endif

" Autosave every N miliseconds or when losing focus.

  " Vim becomes too slow when I'm doing a compilation and editing files at the same time.

  "set updatetime=1000
  "let g:AutoSaveOn = 1
  "augroup AutoSave
      "autocmd!
      "autocmd! CursorHoldI,CursorHold,BufLeave * if g:AutoSaveOn | silent! :update | endif
  "augroup END

" # highlight

  " Required for the highlight command to work:

    syntax on

  " Once syntax is on, the `highlight` command can be used. It has the form:

    " highlight group-name key=val ...

  " # gui

  " # cterm

  " # term

    " There are three types of highlight arguments:

    " - term:
    " - cterm: TODO vs term
    " - gui: GVim

    " For both cterm and gui, foreground `fg` and background `bg` colors can be set.

    " For all ot them, `term`, `cterm` and `gui` options can be set: a comma separate list
    " with options such as underline and boldface:

    "   highlight CursorLine term=underline cterm=bold gui=italic

    " gui can have more colors as it is free from terminal color limitations.

    "   highlight CursorLine ctermfg=red
    "   highlight CursorLine guifg=red

    " TODO is it possible to use cterm colors for gui? http://vim.wikia.com/wiki/Using_GUI_color_settings_in_a_terminal

    " TODO what is:

    "   set term?

  " Disable highlight for one group:

    " highlight clear CursorLine

  " Multiple highlight commands stack up:

    " highlight CursorLine ctermfg=red
    " highlight CursorLine ctermbg=red

  " changes both bg and fg

  " Settings for multiple terminals can be set on a single command:

    " highlight CursorLine ctermfg=red guifg=blue

  " Get the highlight group under the cursor:

  " http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor

  "     set statusline=%{synIDattr(synID(line('.'),col('.'),1),'name')}

  " # match

    " Only last match works. This was probably designed for interactive usage.

    " `2match` is a second option.

    " `3match` is reserved.

    " General solution: only exists with plugins as of 2013:
    " <http://superuser.com/questions/211916/setting-up-multiple-highlight-rules-in-vim>

    " #Trailing whitespace

      " Highlight tralling whitestpace.

      " Also possible with set list + listchars, but this is better.

        augroup TrailingWhitespaceAucmd
          autocmd!
          autocmd BufEnter * highlight TrailingWhitespace ctermbg=brown guibg=brown
          autocmd BufEnter * match TrailingWhitespace /\s\+$/
        augroup END

    " #Highlight lines that are too long

        augroup LineTooLongAucmd
          autocmd!
          autocmd BufEnter * highlight LineTooLong ctermbg=darkgrey guibg=#101010
          " Must come after language specifics as it depends on wrap state.
          " autocmd BufEnter * if !&wrap | 2match LineTooLong /\%>74v.\+/ | endif
          autocmd BufEnter * 2match LineTooLong /\%>74v.\+/
        augroup END

  " # cursorline

  " # cursorcolumn

    " Highlight current line and column.

    " The styles are given by the CursorLine and CursorColumn highlights, help at hl-CursorLine.

    " Makes line too unreadable on certain dark themes.

      set nocursorline
      set nocursorcolumn

  " # synIDAttr #synID

    " Get name of syntax region under cursor:

      " echo synIDattr(synID(line('.'),col('.'),1),'name')

    " Add it to your status line. Great way to make small syntax developments:

      " set laststatus=2
      set statusline=%{synIDattr(synID(line('.'),col('.'),1),'name')}

  " # syntax

    " Tutorials on creating vim synta files:

    " http://vim.wikia.com/wiki/Creating_your_own_syntax_files

    " Try to use the standard names whenever possible:

      " help group-name

    " Defines syntax rules.

    " Does a bunch of different things depending on the subcommand you give it, so watch out.

" - -s to skip errors like symlinks with missing targets
" - recursive by default, but if you pass filenames to it it won't recurse
set grepprg=grep\ -HIRns\ $*

" Semicolon makes vim search all parent directories, don't remove it.
set tags=tags;

" Change dirctory automatically to the current dir:
let g:netrw_keepdir=0

" http://stackoverflow.com/questions/12243233/how-to-auto-load-cscope-out-in-vim
augroup Cscope
  autocmd!
  function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
      let path = strpart(db, 0, match(db, "/cscope.out$"))
      set nocscopeverbose " suppress 'duplicate connection' error
      exe "cs add " . db . " " . path
      set cscopeverbose
    endif
  endfunction
  autocmd BufEnter * call LoadCscope()
augroup END

" https://stackoverflow.com/questions/18589352/how-to-disable-vim-bells-sounds/41524053#41524053
if exists("&bellof")
  set belloff=all
endif
