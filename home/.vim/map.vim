" # Mappings

" # Keyboard bindinigs

  " Here are all the:

  " - cheats on default meanings
  " - custom mappings

  " Sorted by qwerty order so that it is easy to find:

    " Esc F1-F12
    " 1234567890
    " qwertyuiop[]\
    " asdfghjkl;'<cr>
    " zxcvbnm,./
    " <space>

  " Language specific mappings may be in language specific sections.

  " # Leader

    " Good key to start your personally defined maps.

    " Set the current leader:

      let mapleader = ','

    " Default is:

      " let mapleader = '\'

    " Use current leader:

      " nn <leader>a b

    " Redefining it after changing a mapping has no effect on already defined
    " maps, but will affect commands that are defined afterwards:

      " let mapleader = ','
      " noremap <leader>a b
      " let mapleader = '\'
      " noremap <leader>d e

    " Here, `,a` and `\d` have gotten mappings!

    " Tab navigation in normal mode.
    " In terminal, alt tab is not possible, but should be used in GVim.

      nnoremap <leader>a :tabedit<space>
      nnoremap <leader>tt :tabedit<space>
      nnoremap <leader>tb :tab sbuffer<space>
      nnoremap <leader>tm :tabmove<space>

    " Go to previously selected tab / last tab:
    " http://stackoverflow.com/questions/2119754/switch-to-last-active-tab-in-vim

      augroup LastTab
        autocmd!

        let g:lasttab = 1
        autocmd TabLeave * let g:lasttab = tabpagenr()
        nnoremap <leader>tl :execute 'tabn ' . g:lasttab<CR>

        let g:reopenbuf = expand('%:p')
        function! ReopenLastTabLeave()
          let g:lastbuf = expand('%:p')
          let g:lasttabcount = tabpagenr('$')
        endfunction
        function! ReopenLastTabEnter()
          if tabpagenr('$') < g:lasttabcount
            let g:reopenbuf = g:lastbuf
          endif
        endfunction
        function! ReopenLastTab()
          tabnew
          execute 'buffer' . g:reopenbuf
        endfunction
        autocmd TabLeave * call ReopenLastTabLeave()
        autocmd TabEnter * call ReopenLastTabEnter()
        " Tab Restore
        nnoremap <leader>tr :call ReopenLastTab()<CR>
      augroup END

    " Reopen last closed tab
    " http://stackoverflow.com/questions/2119754/switch-to-last-active-tab-in-vim

    " Currently using another shortcut for this:

      " nn <leader>tT :tabclose<cr>

      nnoremap <leader>ss :SaveSession<space>
      nnoremap <leader>so :OpenSession<space>

      nnoremap <leader>3 /#<space>
      nnoremap <leader>4 /##<space>

      " quickfix toggle requires script:
      " http://stackoverflow.com/questions/11198382/how-to-create-a-key-map-to-open-and-close-the-quickfix-window-in-vim
      " http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
      nnoremap <leader>co :tab copen<cr>
      " http://superuser.com/questions/355325/close-all-locations-list-or-quick-fix-windows-in-vim
      nnoremap <leader>cc :tabdo if &buftype == "quickfix" \| quit \| endif<cr>
      "nnoremap <leader>cc :cclose<cr>
      nnoremap <leader>gcd :Gcd<cr>
      nnoremap <leader>gr :Grep 
      nnoremap <leader>gg :Ggrep 

    " <leader>eX opens :e SOME_DIRECTORY,
    " where SOME_DIRECTORY is given as an environment variable.

      for pair in [
        \['a', 'ART_DIR'],
        \['A', 'ALGORITHM_DIR'],
        \['b', 'BASH_DIR'],
        \['c', 'CPP_DIR'],
        \['d', 'ANDROID_DIR'],
        \['h', 'HOME_DIR'],
        \['j', 'JAVA_DIR'],
        \['l', 'LINUX_DIR'],
        \['n', 'NOTES_DIR'],
        \['N', 'NETWORKING_DIR'],
        \['p', 'PROGRAM_DIR'],
        \['t', 'TEST_DIR'],
        \['u', 'UBUNTU_DIR'],
        \['y', 'PYTHON_DIR'],
        \['w', 'WEBSITE_DIR'],
        \['W', 'WEB_DIR'],
        \['z', 'WEB_DIR'],
      \]
        execute 'nnoremap <leader>e' . pair[0] . ' :tabedit <c-r>=expand($' . pair[1] . ')<cr>/'
      endfor
      " Tab complete edit from the Git top level.
      " systemlist()[] to remove the newline.
      nnoremap <leader>eg :tabedit <c-r>=systemlist('git rev-parse --show-toplevel')[0]<cr>/

    " Open tag in new tab.

      nnoremap <leader>ta :tab tag<space>

  " # f keys

      call MapAll('<F2>', ':call TmuxNewTabHere()<cr>')
      call MapAll('<S-F2>', ':ConqueTermTab bash<cr>')
      call MapAll('<F3>', ':call KrusaderNewTabHere()<cr>')
      call MapAll('<S-F3>', ':NERDTreeToggle<cr>')

  " # ` #~

    " Invert selection case:

      " vn ~

    " Jump to last modification made on current buffer:

      " nn `.
      " vn `.

  " # @ #2

    " Do macro saved on a register:

      " noremap @a

    " Redo last used macro:

      " noremap @@

    " Use value from register:

      " cnoremap @a
      " cnoremap @+

    " Example:

      " echo @a
      " echo @+

  " # # #3

    " noremap * backwards:

      " noremap #

  " # % #4

    " Swap with L:

      nnoremap $ L
      vnoremap $ L

  " # % #5

    " Goes between open close pairs

      " nn %

      " h %

    " Pairs are defind by:

      " set mps?

    " Very useful command

    " Individual pairs and more can be done with `[`

    " As of 7.3, in HTML works by default for:

    " - HTML tags.
    " - less than and more than sign pairs.

  " # ^ #6

    " Go to first non whitespace char of line:

      " unmap ^

    " toogle between current and alternate file:

      " unmap c-^

    " Swap with H:

      noremap ^ H

  " # *

    " Search for word under cursor for backwards:

      " noremap *

    " Replacement starts as current word (w) under cursor
    " (analogy to `*` which searches for word under cursor):

      nnoremap <leader>* bve"zy:%s/<c-r>z/<c-r>z/g<left><left>

    " See also: `[i`.

  " # ( # ) # 0

    " - (previous sentence
    " -) next

    " what is a sentence?

    " something that ends in '.', '?' or '!'

       " h sentence

  " # =

    " Indent current lines:

      " map ==

  " # tab

    " Next and previous tab:

      call MapAll('<c-tab>',   ':tabnext<cr>')
      call MapAll('<c-s-tab>', ':tabprevious<cr>')

  " # q

    " Start/end recording commands in register a:

      " nn qa

    " Macros DO replace registers. Check with:

      " echo @a

    " Enter ex mode:

      " nn Q

    " Same as command mode, except you can do several ex commands
    " without exiting ex command mode

    " Visual block mode:

      " nn c-q

    " Same as `c-v` in gvim, but used for terminal control

    " Close current window and move left:

      function! QuitToPreviousTab()
        let l:last = (tabpagenr() == tabpagenr('$'))
        quit
        if !l:last
          tabprevious
        endif
      endfunction
      call MapAll('<c-q>', '::call QuitToPreviousTab()<cr>')

    " Useful because I don't use subwindows (each window becomes too small),
    " and often I open up Scrap tabs to the right of the current tab (program | program output),
    " so when I close the program output I want to go back to the program source.

  " # w

    " Move across windows:

    " - <c-w>h
    " - <c-w>j
    " - <c-w>k
    " - <c-w>l
    " - <c-w>p : previous window

    " Close current window:

      call MapAll('<c-w>', ':q<cr>')

    " Rationale: better with control mapping to allow navigating windows multiple times.

    " Close current tab (possibly multiple windows):

      " call MapAll('<c-w>', ':tabclose<cr>')

  " # e

    " Scroll up one line (don't move cursor (unless it would go out of view)):

      " nn <c-e>

    " Scroll down: TODO

    " Mnemonic: Extra lines!!

    nnoremap <c-e> 10<c-e>
    nnoremap <c-y> 10<c-y>

  " # r

    " Replace mode (insert but overwritting):

      " nn R

    " Useful in rare cases such as when editing row aligned text.

    " Redo:

      " nnoremap <c-r>

  " # t

    " Like `f`, but stops right before char.

      " nn t

    " Repeated uses do nothing

    " Mnemonic: unTill

    " Major use case: delete untill char, but don't delete char. Ex:

    " Buffer:

      " f(a,b,c,d)
      "  ^

    " You want to delete up to `d`, but keep the `)`

    " Solution: `dt)`

  " # y

    " Same as c-e, upwards:

      " nn <c-y>

    " Mnemonic: close to c-u (on qwertyu)

    " Same as yy, therefore useless.

      " nn Y

    " Copy to system clipboard:

       nnoremap Y "+y
       vnoremap Y "+y

    " Very useful to copy paste to browser or terminals.

    " Accelerate vertical scroll up:

      " nn <c-Y> 5<c-Y>

    " Copy line to system clipboard:

       nnoremap yY ^"+y$

  " # u

    " selection to lowercase:

      " vn u

    " selection to uppecase:

      " vn U

    " half page Up:

      " nn <c-u>

  " # i

    " inverse of <c-0>

    " nn <c-i>

  " # o

    " do one normal command and return to insert mode:

      " inoremap <c-o>:

    " go to last location you were at before jumping with commands lik `/` (:h jumplist)
    " may change buffers in cur window

      " nn <c-o>

    " go to the other extremity of visual selection:

      " vn o
      " vn O

    " on block visual mode, toogle up down corner with `o` and toogle left
    " right corner with `O`

  " # p

    " Paste:

      " nn p

    " Open *ins-completion* popup:

      " nn! <c-p>

    " See `:h ins-completion`.

  " # [

  " # ]

    " Miscelaneous commands, mostly section motions.

    " - } go to next   latex paragraph (double newline)
    " - {     previous

    " - ]] go to next   `}` at current level
    " - [[ go to previous `}` at current level
    " - ][     next   `{`
    " - ][     previous `{`
    " - [i echo first line that contains word under cursor. See also: `*`.

    " What is a section? defined by `se sects?`.

      " h sect

    " - c-] go to location of link under cursor used in Vim docs. ctags based.

    " - [(last unmatched open par. Same for),[,],{,}.=, but not for <>
    " - [z fold move

    " Some nice ones from the famous `https://github.com/tpope/vim-unimpaired`:

    " Exchange current line(s) with the line above / below:

      function! s:Move(cmd, count, map) abort
        normal! m`
        execute 'move'.a:cmd.a:count
        norm! ``
        silent! call repeat#set("\<Plug>unimpairedMove".a:map, a:count)
      endfunction

      function! s:MoveSelectionUp(count) abort
        normal! m`
        execute "'<,'>move'<--".a:count
        norm! ``
        silent! call repeat#set("\<Plug>unimpairedMoveSelectionUp", a:count)
      endfunction

      function! s:MoveSelectionDown(count) abort
        normal! m`
        execute "'<,'>move'>+".a:count
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

    " Move between lines with same indentation <http://vim.wikia.com/wiki/Move_to_next/previous_line_with_same_indentation>:

    " - [l and ]l jump to the previous or the next line with the same indentation level as the current line.
    " - [L and ]L jump to the previous or the next line with an indentation level lower than the current line. 

      " Jump to the next or previous line that has the same level or a lower
      " level of indentation than the current line.

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
          execute line
          execute "normal " column . "|"
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

  " # \

    " Open tag in a new tab:

      nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

  " # a

    " Increment integer number under the cursor!

      " <c-A>

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

  " # s

    " Same as cl:

      " nn

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

      " cnoremap <c-S> <c-A>

    " Save current buffer:

      noremap  <c-s> <esc>:w<cr>
      noremap! <c-s> <esc>:w<cr>a

    " Insert single char. Can be repeated with `.`

      function! RepeatChar(char, count)
        return repeat(a:char, a:count)
      endfunction
      nn <silent> s :<c-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<cr>
      nn <silent> S :<c-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<cr>

  " # d

    " Cut line to system clipboard:

      nn dD ^v$"+ygv

      nnoremap <c-e> 10<c-e>

  " # f

    " one screen Forward:

      " nn <c-f>

  " # g

    " Leader for lots of miscelaneous commands

    " - gg: go to first line
    " - G:  go to last line
    " - {num}G:  go to line num
    " - ge: go to end of last word!
    " - gE:
    " - gv: go to visual mode and reselect previous visual selection.

      " Also restores visual mode type (char, bloc, line)

      " You can also set that selection programatically:

        " call setpos("'<", [0, 2, 1])
        " call setpos("'>", [0, 3, 2])
        " normal! gv

    " # gf

      " Open file under cursor in current buffer:

        " gf

      " In split:

        " split gf

      " Get file name that would be used by gf:

      " Takes word under cursor
      " open in turrent window a file with same name as that word
      " searchs files under the special path variable (no g: prefix, but global)

        " help path

    " # gx

      " Open URL (local file / internet) under cursor using appropriate program.

      " This is decided by the netrw built-in plugin.

      " Uses netrw.

      " Configured with:

          let g:netrw_browsex_viewer = 'xdg-open'

    " # gt

      " Go to the first tab:

        " 1gt

    " Select Go to last Pasted text (to indent, or delete for example)

      nn <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

    " Show current file name and position:

      " nunmap <c-g>

    " Useless if you have `set ruler`.

  " # h

    " Swap H and L by ^ and $ because:

    " - H and L are useless and very easy to type.
    " - ^ and $ are very useful and hard to type.
    " - H and L are good mnemonicts for the begining and end of line, in relation to `h` and  `l`.

    " This also frees `D` and `C`, since it is not very easy to replace them by `dL` and `cL`.
    " It also removes the need for the common mapping `Y`, which is simple to do via `yy`.

      noremap H ^

    " Make help open on a new window:

      cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'

      nnoremap <c-h> :tabprevious<cr>
      nnoremap <c-l> :tabnext<cr>

  " # j

    " Use screen lines instead of real lines:

      nn j gj
      vn j gj

    " Accelerate down

      nn J 5j
      vn J 5j

    " Join lines:

      " unmap J

    " Same as j:

      " nn <c-j> j

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

  " # k

    " Use screen lines instead of real lines:

      nn k gk
      vn k gk

    " Accelerate up

      nn K 5k
      vn K 5k

    " Search word under cursor using a given program:

      " unmap K

    " Default is `man`.

    " Not *very* useful.

    " Nop:

      " map <c-k> <nop>

  " # l

      noremap L $

    " TODO make this a motion so I can `yL` to yank

      " function! MoveRight()
        " normal! $
      " endfunction

      " nn L :set opfunc=MoveRight<CR>g@

  " # ;

  " # :

    " Repeat last f, F, t or T (like n,N)

      " nn ;

    " Comma to repeat in reverse direction.

    " Enter command mode:

      " nn :

    " swap ';' and ':', dispensing shift to start commands:

      noremap ; :
      noremap : ;

    " noremap <c-;> asd

  " # enter

  " # cr

    " - <c-m> is equivalent to <cr> becuse of terminals: http://stackoverflow.com/questions/3935970/vim-how-to-map-ctrl-m-without-affecting-return-keypress-as-well
    " - <cr> and <enter> are the same thing, so just use <cr> always
    " - <s-cr> is hard to mapa problem: http://stackoverflow.com/questions/16359878/vim-how-to-map-shift-enter

    " Like `o` on normal mode, but it does not continue comments.

      nn <cr> :let b:old_formatoptions = &formatoptions<cr>:set formatoptions-=o<cr>o <bs><esc>:let &formatoptions=b:old_formatoptions<cr>a

  " # z

    " remove useless zl that does single horizontal scroll:

      nn zl zL
      nn zh zH

    " Open close fold under cursor:

      " unmap zo
      " unmap zc

    " Recursivelly:

      " unmap zO
      " unmap zC

    " Toogle fold:

      " unmap za
      " unmap zA

    " All folds (m more, M max, r reduce, R min)

      " unmap zm
      " unmap zM
      " unmap zr
      " unmap zR

    " Toogle all folds max or min:

      " unmap zi

    " Move over folds:

      " unmap [z     "start  of current
      " unmap ]z     "end  of current
      " unmap zj     "start  of next
      " unmap zk     "end  of next

  " # x

    " Delete char under cursor:

      " nn x

    " Delete char before cursor:

      " nn X

    " Decrement number under cursor (oposite of <c-a>):

      " nn <c-X>

    " Enter c-x mode

      " in <c-x>

    " Increment number under cursor:

      nn <c-x> <c-a>

    " Cut to system clipboard:

      vn X "+ygvd

  " # v

    " Enter line visual mode:

      " nn <c-v>

    " Enter block visual mode:

      " nn <c-v>

    " Next entered character will be literal (like in a terminal);

      " in <c-v>

    " Useful for example to insert a literal tab character if tabexpand is on:

      " <c-v><tab>

    " Swap visual and line visual:

    " Visual line is more useful because on a single line it is often easier to predict
    " up to where the jump can be done on a single motion.

      nnoremap v V
      nnoremap V v

    " Inset an unicoede character:

      " <c-v>u XX

  " # c

  " # m

    " LISTEN UP: <c-m> is equivalent to <cr> because of terminals.

    " For your sanity, never remap <c-m>, always use <cr>.

      " nn <c-m> DONT DO THIS!!

    " make mark a on cur buf

      " ma

    " mark A on all open buffers
    " go to opens that buffer in cur window:

      " mA

  " # < #>

    " Keep text selected after shift in visual mode:

      vn < <gv
      vn > >gv

    " Ctrl maps cannot be used.

  " # /

    " search forwards:

      " nn /

    " very magic is more useful than normal:

      nn / /\v

  " # directionals

    " Better keep them plain (not gj), in order not to break stuff like
    " omnicompletion.

      " inoremap <down> <c-o>gj
      " inoremap <up> <c-o>g

    " move across windows:

      nn <c-left> <c-w>h
      nn <c-right> <c-w>l
      nn <c-up> <c-w>k
      nn <c-down> <c-w>j

    " rationale:

    " - control instead of double key for sequences that are often pressed repeatedly
    " - `c-w` is a bit useless, remap it to something better

