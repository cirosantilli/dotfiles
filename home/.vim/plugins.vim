" # Vundle

  " Plugin manager.

  " Install:

      " sudo aptitude install -y vim git
      " git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
      " vim +PluginInstall +qall

  " Concurrence to Pathogen. Seems to be winning.

  " Use this! Easy install and plugin update via single vimrc lines + Git or GitHub repos.

  " View all avaliable bundles (searches GitHub?):

      " Plugins

  " # Install plugin

      " Add to `.vimrc`:

      " Plugin 'gitrepouser/reponame'

      " and run:

      " `PluginInstall`

  " Update all installed plugins:

      " PluginInstall!

  " Remove a plugin:

  " Required:

      set nocompatible
      filetype off
      set rtp+=~/.vim/bundle/Vundle.vim
      call vundle#begin()

  " Let Vundle manage Vundle:

      Plugin 'gmarik/vundle'

  " # inner workings

      " Vundle adds each plugin    to runpath, before ~/.vim/after
      "         plugin/after      , after

  " # overriding mappings

      " Using the default path maintained by vundle you can override

      " ftplugin mappings by:

      " - putting the mapping as an autocmd in your vimrc:

      " au FileType FT nn <buffer> a b

      " - putting the mapping inside ~/.vim/ftplugin/FT_something.vim

      " nn <buffer> a b

      " - putting the mapping inside ~/.vim/after/ftplugin/FT_something.vim

      " I don't think `ftplugin/after` mappings can be overriden

      " TODO

" # local-vimrc

" # auto source local .vimrc

" Alternatives: http://stackoverflow.com/questions/1889602/multiple-vim-configurations

  " MarcWebber

      " A bit buggish / hard to use correctly:

        "Plugin 'MarcWeber/vim-addon-local-vimrc'
        "autocmd BufEnter * SourceLocalVimrc

      " Start from root, ans source every file with a given basename (.vimrc by default).

      " Security is hash based: you have to accept only once for each filename / content hash.
      " Great feature.

    " # embear

      " Default file name: `.lvimrc`

          Plugin 'embear/vim-localvimrc'
          " Don't ask before loading. Less safe, but a pain otherwise.
          " I wish this had the MarcWeber hash feature...
          " TODO: seems to not load files if on.
          let g:localvimrc_ask = 0
          let g:localvimrc_sandbox = 0

      " augroup Cpp
      "   autocmd!
      "   autocmd FileType c,cpp setlocal noexpandtab
      " augroup END

" # AutoComplPop

  " Automatically opens Vim's built-in completion as you type.

      " Bundle 'vim-scripts/AutoComplPop'

  " The disadvantage of this is that if you hit ESC in the middle of a word,
  " it breaks current completion, but does not go to normal mode, so you need to
  " hit <ESC> twice which is unacceptable. One workaround is to differentiate <esc>
  " and <c-e>, which on regular autocomplete do the same thing (TODO make this work).

      " inoremap <esc> <esc><esc>

  " It is also a bit distracting to see all those popups open and close everywhere
  " for the simplest words.

  " It would be cool however if the popups kept opening automatically after the first <c-p>
  " until I select a choice.

" # cscope

  Plugin 'vim-scripts/cscope.vim'

" # taglist

    Plugin 'vim-scripts/taglist.vim'

  " Help:

      " help taglist.txt

  " Open a list of tags in the current file to serve as a navigation view:

      " TlistOpen

  " Enter click on line to jump to it.

" # neocomplcache

" Hardcore autocompletion. May be slow. Use its successor Neocomplete
" istead on vim 7.3+.

  " Bundle 'Shougo/neocomplcache'
  " let g:neocomplcache_enable_at_startup       = 1
  " let g:neocomplcache_enable_camel_case_completion  = 1
  " let g:neocomplcache_enable_smart_case       = 1
  " let g:neocomplcache_enable_underbar_completion  = 1
  " let g:neocomplcache_min_syntax_length       = 3
  " let g:neocomplcache_enable_auto_delimiter     = 1

  " " AutoComplPop like behavior.
  " let g:neocomplcache_enable_auto_select = 0

  " " SuperTab like snippets behavior.
  " imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)": pumvisible() ? "\<c-n>": "\<TAB>"

  " " Plugin key-mappings.
  " imap <c-k>   <Plug>(neocomplcache_snippets_expand)
  " smap <c-k>   <Plug>(neocomplcache_snippets_expand)
  " inoremap <expr><c-g>   neocomplcache#undo_completion()
  " inoremap <expr><c-l>   neocomplcache#complete_common_string()


  " " <cr>: close popup
  " " <s-CR>: close popup and save indent.
  " inoremap <expr><cr>  pumvisible() ? neocomplcache#close_popup() : "\<cr>"
  " inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup() "\<cr>": "\<cr>"
  " " <TAB>: completion.
  " inoremap <expr><TAB>  pumvisible() ? "\<c-n>": "\<TAB>"

  " " <c-h>, <BS>: close popup and delete backword char.
  " inoremap <expr><c-h> neocomplcache#smart_close_popup()."\<c-h>"
  " inoremap <expr><BS> neocomplcache#smart_close_popup()."\<c-h>"
  " inoremap <expr><c-y>  neocomplcache#close_popup()
  " inoremap <expr><c-e>  neocomplcache#cancel_popup()

  " " Enable omni completion.
  " au FileType css setlocal omnifunc=csscomplete#CompleteCSS
  " au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  " au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  " au FileType python setlocal omnifunc=pythoncomplete#Complete
  " au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " " Enable heavy omni completion.
  " if !exists('g:neocomplcache_omni_patterns')
  " let g:neocomplcache_omni_patterns = {}
  " end
  " let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
  " "au FileType ruby setlocal omnifunc=rubycomplete#Complete
  " let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  " let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
  " let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

  " " For snippet_complete marker.
  " if has('conceal')
  " set conceallevel=2 concealcursor=i
  " end

" # neocomplete.vim

  " Sucessor of neocomplcache, but requires a super up to date VIM version.

  " Bundle 'Shougo/neocomplete.vim'

" # snipmate

  " Two repos:

  " - original, innactive since 2011.

    " Plugin 'msanders/snipmate.vim'

  " - fork, more active.

      Plugin 'MarcWeber/vim-addon-mw-utils'
      Plugin 'tomtom/tlib_vim'
      Plugin 'garbas/vim-snipmate'

  " Next install some snippets.

  " Tons of filetypes:

      Plugin 'honza/vim-snippets'

  " Ruby:

    " Plugin 'kaichen/vim-snipmate-ruby-snippets'

  " <tab> expand in insert mode based on characters before cursor.

  " Useful to expand common programming contructs.

  " After expansion, allows to tab navitate to insivible fields.

  " On fields can complete multiple places (e.g.: variable name in a for loop).

  " Once you leave insert mode, all the magic ends, which makes this only useful for small fields.

  " One alternative is to write characters and jump erase to them like Vim LaTeX,
  " but then you risk to forget to erase the added charactesr.

  " snippet file format

      " Define snippet. Must be in `snippets/<filetype>.snippets`

      " snippet <div
      "  <div>
      "    ${2}
      "  </div>
      " #  Comment.
      " snippet <p
      "  <p>
      "    ${1}
      "  </p>

      " Only use hard tabs in snippets files. This encodes indent independently of tabwidth.

      " Show popup with multiple options for a given trigger:

      " snippet a desc 0
      "  0
      " #  Comment.
      " snippet a desc 1
      "  1

      " Evaluate expresion at snippet expansion. Use anchor from clipboard:

      " snippet ac
      "    <a href="`@+`">${0}</a>

      " Use default value as last another value:

      " snippet ac
      "    <a href="${1}">${0:$1}</a>

      " Use default value as expression;

      " snippet ac
      "    <a href="`@+`">${0:`@+`}</a>

" # lint

" # syntastic

  " Does syntax checking using external checkers.

      Plugin 'scrooloose/syntastic'
      let g:syntastic_always_populate_loc_list = 0

  " You must then install the external syntax checkers you will use.

  " LIst of compatible syntax checkers: <https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers>

  " Ones I have tried and approved on Ubuntu:

      " gem install ruby-lint

  " TODO get working:

      " npm install -g coffee-lint

  " This is specially useful when your are going to do a run / compile that takes some time,
  " allowing you to catch silly mistakes before wasting that time.

  " Checks that checkers often do include:

  " - opening without closings (braces, `do` `end`, etc.)
  " - unset / unused variables
  " - shadows variable

  " Check is done at save time.

  " C++11:

      let g:syntastic_cpp_compiler = 'g++'
      let g:syntastic_cpp_compiler_options = ' -std=c++14'

  " C++11 syntax. TODO not working?

      " Plugin 'https://github.com/vim-scripts/Cpp11-Syntax-Support'

" # fugitive

  " Insaney powerful git Vim frontend:

      Plugin 'tpope/vim-fugitive'

  " Tutorial: https://github.com/tpope/vim-fugitive

  " Most useful commands:

  " -   Ggrep like :grep, from git toplevel.
      " TODO: don't jump to match like grep! https://github.com/tpope/vim-fugitive/issues/773

  " -   Gdiff <ref>: vimdiff between commits. To exit simply close the old one.

  " -   Gmove <name>: rename buffer and `git mv`

  " -   Gremove <name>: close rename buffer and `git rm`

  " -   Gbrowse <ref>: open GitHub URL corresponding to file in browser.

  " -   Gblame <ref>: vplist a git blame. Corresponds line by line with the buffer. Both scroll together.

  " -   Gstatus <ref>: tons of per file quickfix like functionality like:

      " - `-`: git add file on line under cursor
      " - `O`: open file on line under cursor in new tab
      " - `D`: open Gdiff on file under cursor on the window below
      " - `cc`: Gcommit
      " - `cA`: Gcommit| --amend --reuse-message=HEAD

  " Open diff for current file in a new tab.

  " Requires:

      " Plugin 'vim-scripts/AnsiEsc.vim'

  function! Gdf(path)
      tabnew
      setlocal buftype=nofile
      setlocal bufhidden=wipe
      setlocal noswapfile
      silent execute 'read ! git diff --color ' . a:path
      AnsiEsc
  endfunction

  " Git diff for current file.
  command! Gdf call Gdf(expand('%:p'))

  " Git diff for entire repository.
  command! Gdfr call Gdf('')

  command! -nargs=* Gcm execute '!git add ' . expand('%:p') ' && git commit -m "<args>"'
  command! -nargs=* Gcob execute '!git checkout -b "<args>"'

  " Git add commit and push.
  command! Gad execute '!git add ' . expand('%:p')
  command! Gacm execute '!git add ' . expand('%:p') . ' && git commit -m bak && git push'
  command! Gadnpsf execute '!git add ' . expand('%:p') . ' && git commit --amend --no-edit && git push -f'
  " Ggrep and open quickfix in a new tab.
  command! -nargs=1 Ggr Ggrep! <args> | tab copen
  command! Gps !git push
  command! Gpsf !git push -f

  command! Gcod !git checkout --conflict=diff3 -- %
  command! Gcoo !git checkout --ours -- %
  command! Gcot !git checkout --theirs -- %

  command! -nargs=* Gcmbr execute '!git add ' . expand('%:p') ' && git commit -m "<args>" && git push && git browse-remote'

" # AnsiEsc

  " Show ANSI escapes as color.

      Plugin 'vim-scripts/AnsiEsc.vim'

  " Toogle interpret on:

      " AnsiEsc

  " Toogle interpret off:

      " AnsiEsc

  " Implemented based on conceal.

" # easymotion

  " List on place all possitions and jump to them with a single key stroke.

  " Very fast for non structured moves!

  " - <leader><leader>w    beginnings  of words and lines
  " - <leader><leader>W             Words
  " - <leader><leader>e    ends       words
  " - <leader><leader>E    ends       Words
  " - <leader><leader>f{char}  given chars
  " - <leader><leader>j    lines down
  " - <leader><leader>n    last search down

      " h easymotion

  Plugin 'Lokaltog/vim-easymotion'

  let g:EasyMotion_mapping_f = '<leader>/'
  let g:EasyMotion_mapping_F = '<leader>?'
  let g:EasyMotion_mapping_w = '<leader>w'
  let g:EasyMotion_mapping_W = '<leader>W'
  let g:EasyMotion_mapping_b = '<leader>b'
  let g:EasyMotion_mapping_B = '<leader>B'

" # nerdtree

  " File manager.

  " Note that vim already comes with nertw which contains much of this functionality.

      "Plugin 'scrooloose/nerdtree'

      " h nerdtree

      " let NERDTreeKeepTreeInNewTab=0
      " let loaded_nerd_tree=1
      let NERDTreeMinimalUI=1
      let NERDTreeChDirMode=2

  " - ?: help

  " - u: root up a dir
  " - C: change root to selected dir
  " - o: toogle open close dir
  " - x: close current level

  " - - t: open in new tab and to to it
      " For file,  opens normal buffer
      " For dir,   opens another nerdtree with root there
  " - T: same as t but stay on current nerd tree

  " - - p: go to parent of current
  " - P: go to root
  " - K: first   sibling current level
  " - J: last  sibling current level
  " - <c-k>: previous sibling
  " - <c-j>: next sibling

  " - m: enter a menu that allows you to: copy, delete, etc.
      " selected node. <esc> to exit this menu

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

" # conque-term

  " Runs terminal inside vim.

  " GitHub mirror of the Google code main repo:

      "Plugin 'rosenfeld/conque-term'

  " - hit esc and you can edit history as a vim buffer
  "   hit i, and you're back to terminal mode

  " - after C-D, shell history remains on normal buffer and you can vim edit it

  " :ConqueTerm bash
  " :ConqueTermSplit mysql -h localhost -u joe -p sock_collection
  " :ConqueTermTab Powershell.exe
  " :ConqueTermVSplit C:\Python27\python.exe

  " BETA feature, didn't work for me:

      " :let term = conque_term#open('bash', ['tabnew'])

      " :cal my_terminal.write("make run\n")
      " :cal my_terminal.writeln("make run")

      " let term = conque_term#get_instance()
      " "most recent

      " let term = conque_term#get_instance(3)
      " "specific instance
      " :ConqueTermTab bashx make run
      " :ConqueTermTab bashx make run; exit

" # vimux

  " Requires you to be running vim from inside tmux already!

  " tmux integration.

      "Plugin 'benmills/vimux'

  " Split a tmux pane and run given command on it:

      " call VimuxRunCommand("ls")

  " Reuses split if it exists already.

" # session

  " Manage sessions. Save and load tabs, windows, buffers, etc.

      " Required by vim-session and other xolox plugins.
      Plugin 'xolox/vim-misc'
      Plugin 'xolox/vim-session'
      let g:session_autoload = 'yes'
      let g:session_autosave = 'yes'
      let g:session_autosave_to = 'default'
      let g:session_verbose_messages = 0

  " Vim already has `mksession` and viminfo, this just wraps it to make it
  " a bit more convenient, and I use it to handle autoload / autoclose of a default session.

  " Help:

      " h session

  " List all sessions:

      " OpenSession <tab>

  " Save session:

      " SaveSession <session_name>

  " Delete session:

      " DeleteSession <session_name>

" # FuzzyFinder

  " Find things like Files, Buffers and other things really quickly.

      Plugin 'L9'
      Plugin 'FuzzyFinder'

  " Transforms input `abc` into a regexp `a.*b.*c`.

  " Open in new tab with enter:

      let g:fuf_keyOpenTabpage = '<CR>'

  " Alias the most useful commands to shorter versions:

      " Buffers: files that you have opened once.
      command! -nargs=* Fb FufBuffer <args>
      " Files or directories in current directory.
      command! -nargs=* Ff FufFile <args>
      " Coverage: recursively in current directory.
      command! -nargs=* Fc FufCoverage <args>

  " Once the list appears, navigate with Up and Down: letters will add to the search.

" # BufExporer

    " Plugin 'jlanzarotta/bufexplorer'

" # ctrlp

  " Fuzzy finder in files or buffers.

  " Seems more pupular than FuzzyFinder now.

      Plugin 'kien/ctrlp.vim'

  " Find file in... where?:

      " Ctrl-p

" # ack.vim

  " Vim ack integration

      Plugin 'mileszs/ack.vim'

  " Usage:

      " :Ack a.c

  " Does `ack a.c` on current directory and opens up a quickfix window with matches.

  " You can therefore use any quickfix shortcut such as `:cn` to jump
  " between matches.

  " Inside the quickfix window, the following mappings can be used (the
  " standard quickfix ones seem to be off):

  " - `o`: open file in current buffer and jump to line
  " - `T`: open in new tab and jump to line

" # NERDcommenter

  " Does the right type of comment for each recognized filetype.

      Plugin 'scrooloose/nerdcommenter'

  " Default mappings start with `<leader>c`.

  " Toogle comment on current/selected lines:

      " <leader>c<space>

  " To use the functions provided in the plugin you must do:

      " call NERDComment('n', 'uncomment')

  " as explained in `:h NERDComment`.

  " Wether to add inner spaces or not.
  " Generally, comments look better with the spaces:

      let g:NERDSpaceDelims = 1

  " But sometimes I want to differentiate comments from neighbouring code,
  " and do that by making the code have no spaces.

      augroup NerdCommenter
      autocmd!
      function! NERDSpaceDelimsOff()
          let a:NERDSpaceDelimsOld = g:NERDSpaceDelims
          let g:NERDSpaceDelims = 0
          call NERDComment('n', 'toggle')
          let g:NERDSpaceDelims = a:NERDSpaceDelimsOld
      endfunction
      autocmd Bufenter * noremap <leader>m<space> :call NERDSpaceDelimsOff()<cr>
      augroup END

" # surround

  " https://github.com/tpope/vim-surround

  " Intelligent ''', '"', and html tags conversion

  " - `ds"`: delete surrouding
  " - `cs"'`: change double to single quotes on cur word
  " - `cs'<q`: change apostrophe quote to xml <q html elemtn
  " - `cst"`: change tag to
  " - `ysiw]`: add surrounding ] to word
  " - `ysiw[`: add surrounding space + ] to word
  " - `ysiw<em`: add surrounding <em> to word
  " - `ysiwtem`: idem
  " - `ysiw\tabuar{lc`: latex envs
  " - `< ({[` work multiline, `'"` dont
  " - linewise visual mode + `S<p class="important">`: surround lines with p.

      Plugin 'tpope/vim-surround'

" # autoclose

  " Automatically closes parenthesis, HTML tags, etc., and puts the cursor in the middle.

      Plugin 'Townk/vim-autoclose'

  " Completion is somewhat smart:

  " - does not complete inside strings

  " Breaks Ubuntu ibus Chinese input: https://github.com/Townk/vim-autoclose/issues/38

" # align

  " Better documented than tabular, and more vim like interface.

      Plugin 'junegunn/vim-easy-align'

  " Test with:

      " apple   =red
      " grass+=green <cursor>
      " sky-=   blue

  " Align at `=`:

      " vip<enter>=
      " <leader>aip=

" # tabular

  " Easily align at certain characters.

      Plugin 'godlygeek/tabular'

  " Align current paragraph (lines without \n\n) at a regexp (comma in the example):

      " Tabularize /,

  " Try it on:

      " abc, 0
      " ab, 0 <cursor>
      " a, 0

      " abcd, 0

" # vis

  " Visual block only replace.

      Plugin 'taku-o/vim-vis'

  " Select visual bloc, then `:B s/a/b/g` so that replace acts only on selected block.

" # repeat

  " Allows for dot `.` repetition of custom commands.

      Plugin 'tpope/vim-repeat'

  " Used in plugins from tpope and others.

  " - surround

" # markdown

" # plasticboy markdown

  " Offers;

  " - syntax highlighting
  " - code folding
  " - header navigation mappings

  Plugin 'plasticboy/vim-markdown'

  " Disable folding:

  " let g:vim_markdown_folding_disabled=1
  let g:vim_markdown_initial_foldlevel = 6
  let g:vim_markdown_math = 1
  let g:instant_markdown_autostart = 0

  " There is also a version by tpope, but plasticboy seems better.
  " tpope's is present in the default Vim distribution.

  " Bundle 'tpope/vim-markdown'

  " Turn off a map:

  "map <Plug> <Plug>Markdown_OpenUrlUnderCursor

" # Instant markdown

  " Preview server on localhost:8090.

  " Recompiles everytime you type with redcarpet.

  " Tons of external dependencies. I'd rather just compile and do `firefox output.html` for now.

  " gem install pygments.rb
  " gem install redcarpet -v 2.3.0
  " npm -g install instant-markdown-d
  Plugin 'suan/vim-instant-markdown'
  let g:instant_markdown_autostart = 0

  " Start server with:

  " InstantMarkdownPreview

" # dockerfile

  Plugin 'ekalinin/Dockerfile.vim'

" # .gradle files (Groovy).

  Plugin 'tfnico/vim-gradle'

" # node

  Plugin 'moll/vim-node'

" # sparkup

  " HTML mappings.
  Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" # latex

  Plugin 'git://git.code.sf.net/p/vim-latex/vim-latex'

  " Docs: http://vim-latex.sourceforge.net/documentation/latex-suite.html#section-mappings

  " # C-j

      " Jump to the next <++> marker.

  " # F5

      " # Inside document

      " Environment autocomplete.

      " If the environment is known, a special complete happens,
      " else, just a default environment opens:

          " asdf<F5>

      " Expands to:

          " \begin{adsf}
          "  <cursor>
          " \end{adsf}<++>

      " Outside of document

  " Uses several insert mode mappings, like SEE for section.

" # QFEnter

  " http://stackoverflow.com/questions/6852763/vim-quickfix-list-launch-files-in-new-tab
  " http://vi.stackexchange.com/questions/6996/how-to-make-enter-open-new-tabs-for-the-quickfix-window-when-it-is-opened-with

      "Plugin 'yssl/QFEnter'

" # rope-vim

  " Python refactoring.

      "Plugin 'klen/rope-vim'

" # coffee-script

    Plugin 'kchmck/vim-coffee-script'

" # rename.vim

  " Rename current file.

      Plugin 'danro/rename.vim'

  " Usage:

      " :reneme <newname>

" # colorscheme

  " When the command is run, it loads the colorscheme, which unsets user defined highlights.

  " Therefore this should come before user highlight modifications.

      Plugin 'tpope/vim-vividchalk'
      " Using colorscheme here does not work. Must do it after vundle#end().

" # Vader

  " Unit tests, pure vim.
  Plugin 'junegunn/vader.vim'
  augroup Vader
    autocmd!
    autocmd FileType vader call MapAllBuff('<F6>', ':write<cr>:Vader<cr>')
  augroup END

" # editorconfig

  " Cross editor per project, prefiletpye, configuration parameters inside `.editorconfig` files.

  " http://editorconfig.org/

      " Plugin 'editorconfig/editorconfig-vim'

  " trim-space automatically removes trailine whitespaces on :w!
  " Too intrusive!

call vundle#end()
filetype plugin indent on
