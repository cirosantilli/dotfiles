" Settings that apply only to some filetypes.

" The right place for those is in a ftplugin file,
" but I'm lazy to put such small settings in separate files.

" Note that `filetype.vim` (without `s`) is a magic name in the runtime path,
" and should be avoided.

augroup Setfiletype
  autocmd!
  " http://stackoverflow.com/questions/16337811/vim-configuration-to-turn-on-syntax-for-conf-files
  autocmd BufRead,BufNewFile *.conf,mimeapps.list setfiletype dosini
  " OpenCL. TODO not working, lisp is stronger!
  autocmd BufRead,BufNewFile *.cl setfiletype c
augroup END

" # Data languages

" # HTML

" # XML

    function! FtHtml()
      call MapAllBuff('<F6>', ':w<cr>:silent !xdg-open % &<cr>')
      function! HeaderIncrease()
        silent! %substitute/<h5/<h6/g
        silent! %substitute/<h4/<h5/g
        silent! %substitute/<h3/<h4/g
        silent! %substitute/<h2/<h3/g
        silent! %substitute/<h1/<h2/g
        silent! %substitute/<\/h5/<\/h6/g
        silent! %substitute/<\/h4/<\/h5/g
        silent! %substitute/<\/h3/<\/h4/g
        silent! %substitute/<\/h2/<\/h3/g
        silent! %substitute/<\/h1/<\/h2/g
      endfunction
    endfunction

    augroup Html
      autocmd!
      autocmd FileType haml,html,xml setlocal shiftwidth=4 tabstop=4
      autocmd FileType html,xml call MapAllBuff('<F6>', ':write<cr>:silent !xdg-open % &<cr>')
      autocmd FileType haml call MapAllBuff('<F6>', ':write<cr>:call RedirStdoutNewTabSingle("haml " . expand(''%''), "html")<cr>')
      autocmd FileType html call FtHtml()
    augroup END

    augroup Svg
      autocmd FileType svg call MapAllBuff('<F6>', ':write<cr>:silent !xdg-open % &<cr>')
    augroup END

  " # CSS family

    augroup Css
      autocmd!
      autocmd BufNew,BufRead *.{css,sass,scss} setlocal shiftwidth=2 tabstop=2
    augroup END

  " # JavaScript

  " # js

  " # CoffeeScript

    augroup Javascript
      autocmd!
      autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
      autocmd FileType coffee call MapAllBuff('<F6>', ':write<cr>:call RedirStdoutNewTabSingle("coffee " . expand(''%''))<cr>')
      autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
      autocmd FileType javascript call MapAllBuff('<F6>', ':write<cr>:call RedirStdoutNewTabSingle("node " . expand(''%''))<cr>')
      autocmd FileType coffee,javascript call MapAllBuff('<F7>', ':write<cr>:call RedirStdoutNewTabSingle("grunt")<cr>')
    augroup END

  " # YAML

    augroup Yaml
      autocmd!
      autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
    augroup END

" # Compilable markup

  " # Markdown

  " # md

  " # rst

    augroup Markdown
      autocmd!
      " autocmd FileType *.md setlocal shiftwidth=4 tabstop=4
      autocmd BufNew,BufRead *.{md,rst} setlocal shiftwidth=4 tabstop=4
      " autocmd BufNew,BufRead *.{md,rst} setlocal filetype=text
      autocmd BufNew,BufRead *.rst call MapAllBuff('<F5>', 'w<cr>:sil ! make<cr>')

      " TODO this is broken still:
      autocmd BufNew,BufRead *.rst call MapAllBuff('<F6>', 'o<cr><ESC>k:pu=''.. _vimhere:''<cr>:w<cr>:sil ! make<cr>k:d<cr>:d<cr>:d<cr>:w<cr>:silent ! make firefox RUN_NOEXT="%:r" ID="\#vimhere"<cr>')

      " Make and open with firefox on curent point without a makefile.
      let s:out_dir = '_out'
      autocmd BufNew,BufRead *.{md,rst} call MapAllBuff('<S-F6>', ':pu=''<span id=\"VIMHERE\"></span>''<cr>:w<cr>:silent ! mkdir -p ' . s:out_dir . '; pandoc -s --toc % -o ' . s:out_dir . '/%<.html<cr>:d<cr>:w<cr>:silent ! firefox ' . s:out_dir . '/%<.html\#VIMHERE<cr>')
      " autocmd BufNew,BufRead *.{md,rst} noremap <buffer> <F6> <ESC>:! mkdir -p _out; pandoc -s --toc % -o _out/%<. html; firefox _out/%<.html<cr>

      autocmd BufNew,BufRead *.{md,rst} call MapAllBuff('<F7>', ':w<cr>:sil ! make<cr>:sil ! make firefox RUN_NOEXT="%:r"<cr>')

      " Clean default output dir.
      autocmd BufNew,BufRead *.{md,rst} call MapAllBuff('<S-F7>', ':sil !rm -r ' . s:out_dir . '<cr>')
      autocmd BufNew,BufRead *.{md,rst} call MapAllBuff('<F8>', ':w<cr>:sil ! make<cr>:sil ! make okular  RUN_NOEXT="%:r"<cr>')

      " Markdown *cannot* be indented, and GFM forces us to have
      " infinitely long lines. because single newlines become line breaks.
      autocmd BufNew,BufRead *.{md,rst} setlocal wrap

      function! FiletypeMarkdown()
        " Enter a good mode to edit markdown tables.
        " Always shows leftmost column.
        function! s:TableMode()
          setlocal nowrap
          vsplit
          vertical resize 35
          normal! ^
          set scrollbind
          wincmd l
          set scrollbind
          set cursorline
          setlocal nostartofline
          highlight clear LineTooLong
        endfunction
        command! -buffer TableMode call s:TableMode()
      endfunction
      autocmd FileType markdown call FiletypeMarkdown()
    augroup END

  " # LaTeX

  " # TeX

    augroup Latex
      autocmd!
      autocmd FileType tex setlocal shiftwidth=2 tabstop=2 foldlevel=999

      " autocmd BufEnter,BufRead *.{tex} call MapAllBuff('<F5>'  , ':w<cr>:! cd `git rev-parse --show-toplevel` && make<cr>')
      " autocmd BufEnter,BufRead *.{tex} call MapAllBuff('<S-F5>', ':w<cr>:! cd `git rev-parse --show-toplevel` && make clean<cr>')
      " Okular forward search.
      " TODO why does `make &&` not work?!?! I have to use `make;`!
      autocmd BufEnter,BufRead *.{tex} call MapAllBuff('<F6>', ':write<cr>:execute "silent !make; okular --caption OkularVIM --unique %:p:r.pdf\\#src:" . line(".") . "%:p && wmctrl -a OkularVIM &"<cr>')
      " With special Makefile that does SyncTeX for us:
      " autocmd BufEnter,BufRead *.{tex,md} call MapAllBuff('<F6>', ':w<cr>:exe '':sil ! cd `git rev-parse --show-toplevel` && make view VIEW=''''"%:r.pdf"'''' LINE=''''"'' . line(".") . ''"''''''<cr>')
      " au BufEnter,BufRead *{.tex,.md} call MapAllBuff('<F6>'  , ':w<cr>:exe '':sil ! cd `git rev-parse --show-toplevel` && make view VIEW=''''"%:p"'''' LINE=''''"'' . line(".") . ''"''''''<cr>')

      " This works but the problem is: in which dir is the output file?
      " This is something only the Makefile knows about.
      function! LatexForwardOkular(pdfdir)
        let pdf = a:pdfdir . expand('%:r') . '.pdf'
        let synctex_out = system('synctex view -i "' . line(".") . ':1:' . expand('%') . '" -o "' . pdf . '"')
        let page = 1
        for l in split(synctex_out, '\n')
          if l =~ '^Page:'
            let page = substitute(l, '^Page:\(\d\+\)$', '\1', '')
          end
        endfor
        execute 'sil! ! nohup okular --unique -p ' . page . ' ' . pdf . ' &'
      endfunction
      " au BufEnter,BufRead *.tex call MapAllBuff('<F4>', ':cal LatexForwardOkular("_out/")<cr>')
    augroup END

" # Interpreted languages

" # Bash

" # Python

" # Perl

" # Ruby

" # Tcl

  augroup Interpreted
    autocmd!
    autocmd BufNew,BufRead SConstruct,SConscript set filetype=python
    autocmd BufNew,BufRead Vagrantfile setlocal filetype=ruby
    autocmd FileType python,perl setlocal shiftwidth=4 tabstop=4
    autocmd FileType sh,ruby setlocal shiftwidth=2 tabstop=2
    autocmd BufNew,BufRead *.{erb,feature,ru} setlocal shiftwidth=2 tabstop=2
    autocmd FileType perl,python,r,ruby,sh,tcl call MapAllBuff('<F6>', ':w<cr>:cal RedirStdoutNewTabSingle("./" . expand(''%''))<cr>')
    " TODO: Space to Newline.
    "autocmd FileType sh command! noremap <buffer> <leader>sn s/ / \\\r  /g
  augroup END

" # Compile to executable languages

  " # C

  " # C++

  " # cpp

    " TODO: C++ class hierarchy.
    " http://stackoverflow.com/questions/25655673/c-cscope-ctags-and-vim-finding-classes-that-inherit-from-this-one

  " # Haskell

  " # lex

  " # y

  " # Fortran

  " # asm

  " # s

  " # Java

  augroup Cpp
    autocmd!

    function! FileTypeCpp()
      call MapAllBuff('<F5>'  , ':w<cr>:make<cr>') "vim make quickfix
      call MapAllBuff('<S-F5>', ':w<cr>:silent ! make clean<cr>')
      " Make run, stdout to a new file. Stdout is only seen when program stops.
      " If your Makefile supports, runs `make run RUN=main` to run the current file like `main.c`,
      call MapAllBuff('<F6>'  , ':w<cr>:call RedirStdoutNewTabSingle("make run RUN=\"" . expand("%:r") . "\"")<cr>')
      " Same as above, but may allows you to type in command line args.
      call MapAllBuff('<S-F6>', ':w<cr>:call RedirStdoutNewTabSingle("make run RUN_ARGS=''\"\"''")<LEFT><LEFT><LEFT><LEFT><LEFT>')
      call MapAllBuff('<F7>'  , ':cnext<cr>')
      call MapAllBuff('<F8>'  , ':cprevious<cr>')
      call MapAllBuff('<F9>'  , ':w<cr>:call RedirStdoutNewTabSingle("make profile")<cr>')
      call MapAllBuff('<S-F9>', ':w<cr>:! make assembler<cr>')
    endfunction
    autocmd FileType c,cpp,fortran,asm,s,java,haskell call FileTypeCpp()

    autocmd FileType c,cpp,asm setlocal expandtab shiftwidth=4 tabstop=4
    autocmd BufNew,BufRead *.{l,lex,y} setlocal shiftwidth=4 tabstop=4
    " Because fortran has a max line length.
    autocmd FileType fortran setlocal expandtab shiftwidth=2 tabstop=2
    autocmd FileType java setlocal expandtab

    " Switch between header and cpp files naively.
    " TODO switch between source and header files easily:
    " http://stackoverflow.com/questions/17170902/in-vim-how-to-switch-quickly-between-h-and-cpp-files-with-the-same-name
    autocmd FileType c,cpp command! -buffer Swh tabedit %:r.h
    autocmd FileType cpp command! -buffer Swc tabedit %:r.cpp
    autocmd FileType c command! -buffer Swc tabedit %:r.c
  augroup END

" # vimscript

  augroup Vim
    autocmd!

    autocmd FileType vim setlocal shiftwidth=2 tabstop=2

    " Reaload all visible buffers. TODO: multiple windows per tabpage.
    function! ReloadVisible()
      set noconfirm
      tabdo e
      set confirm
    endfunction
    autocmd FileType vim noremap <buffer> <F5> :wa<cr>:source %<cr>:silent call ReloadVisible()<cr>

    " Write all buffers, source this vimrc, and reaload open
    " buffers so that changes in vimrc are applied:

    " Save and source current script:
    autocmd FileType vim noremap <buffer> <F6> :write<cr>:source %<cr>:edit<cr>
  augroup END

" # Configuration files

  augroup Gitconfig
    autocmd!
    autocmd BufNew,BufRead .gitconfig setlocal noexpandtab
  augroup END

" # quickfix

  augroup Quickfix
    autocmd!
    " Open in new tab.
    " autocmd FileType qf nnoremap <buffer> T :let b:switchbuf_old = &switchbuf | set switchbuf+=usetab,newtab<cr>:tabprevioux

    " http://vi.stackexchange.com/questions/6996/how-to-make-enter-open-new-tabs-for-the-quickfix-window-when-it-is-opened-with/6999#6999
    autocmd FileType qf nnoremap <buffer> <Enter> <C-W><Enter><C-W>T
    "autocmd FileType qf nnoremap <buffer> <CR> :tabnew\|cc <C-r>=line(".")<CR><CR>
  augroup END

" # gnuplot

    augroup Gnuplot
      autocmd!
      autocmd FileType gnuplot noremap <buffer> <F6> :write<cr>:silent !gnuplot -p %<cr>
    augroup END

" # git commits
"
    augroup Gitcommit
      autocmd!
      autocmd FileType gitcomit setlocal textwidth=72
    augroup END
