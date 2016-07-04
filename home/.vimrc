" TODO sourcing this a second time afte rstartup with source ~/.vimrc
" makes me need to edit new files (yet without buffers) twice to get the filetype
" (and thus syntax highlight) correct.

" TODO why does this break things?
" I wish I could use it to avoid having one per augroup block...
"autocmd!

source $HOME/.vim/functions.vim
source $HOME/.vim/commands.vim
source $HOME/.vim/plugins.vim
source $HOME/.vim/options.vim
source $HOME/.vim/filetypes.vim
source $HOME/.vim/map.vim

" # invocation

  " # c

  " # +

      " vim -c 'let a = 1' -c 'let b = 2'

    " Same as:

      " vim +'let a = 1' +'let b = 2'

    " Leaves you in a new Vim session, and:

      " echo a
      " echo b

    " Shows:

      " 1
      " 2

    " Run Vim commands from the command line

      " http://stackoverflow.com/questions/23322744/vim-run-commands-from-bash-script-and-exit-without-leaving-shell-in-a-bad-state

      " Use case: install plugins:

        " vim +PluginInstall +qall

      " Same as:

        " vim -c PluginInstall -c qall

      " Same as doing form inside of Vim:

        " PluginInstall
        " qall

  " # u

    " Start vim with a given vimrc:

      " vim -u vimrc a.txt

    " Great way to test plugins with a minimum vimrc.

    " Start without any vimrc:

      " vim -u NONE a.txt

  " # server

    " List servers:

      " vim --serverlist

    " Start server with given name:

      " vim --servername a
      " vim --serverlist

    " Run expression on server, print console to stdout:

      " vim --servername a
      " vim --servername a --remote-expr '1 + 1'

    " Only expressions are valid, not commands.

" # vimrc

  " Default location: ~/.vimrc.

  " Starting on Vim 7.4: `~/.vim/vimrc` will also be a possible location, thus clearing up your home a bit.

" # modes

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

  " # command mode

    " Is what you get when you type `:`

    " Can tab complete

    " After a tab, left and right arrows navigate possible tab complete commands.

    " After a tab, up returns to the normal command mode

  " # visual mode

    " Visual mode is for newbs.

    " You use visual mode when you cannot predict which keys will lead you to a point on the screen.

    " This means that you have to do an extra `v` and then enter many keys to get where you want.

    " The less you can use visual mode, the stronger you are.

  " # select mode

    " Looks like visual but allows different commands.

    " Enter select mode:

      " gh

    " TODO examples of how commands work

  " # operator pending mode

    " Mode that comes after an operator such as `y`, `d` or `c` was entered.

    " It expects a motion like `hjkl`, *not* an operator as the name may suggest.

    " This is specially important if you want to remap movements.

    " For example, if we do:

      " nnoremap ^ H

    " Then:

      " yH

    "  Will *not* copy up to the beginning of the line. `H` will have its normal meaning
    " and go to the top of the screen, becase after the `y` is entered, we are in `o` mode.

    " If however use use:

      " onoremap ^ H

    " It will work.

    " The best option for this particular example is probably `noremap`, which would remap `nvo`.

  " # ex mode

    " Is what you get when you type `Q`

    " It is like command mode, except you stay in it after executing a command until you type 'visual'

" # motions #operators

    " h motion.txt
    " h text-objects.txt

  " Operators are things like `c`, `d` or `y`.

  " Motions are things that can come after operators like `hjkl` and text objects like `iw`,
  " and indicate where and how (charwise, wordwise, linewise) operators will act.

  " In order to become a Vim master, you must understand the most important motions,
  " including the venerable text objects, which allow you to operate from the middle.

  " # text objects

    " t: HTML tag

" # vimscript

  " Is the built-in language for scripting Vim.

  " # style guides

    " - <http://google-styleguide.googlecode.com/svn/trunk/vimscriptguide.xml>

" # version

  " The version command `:version` shows extensive version info, incuding enabled
  " features, just like `vim --version`.

  " The built-in variable `version` returns a version integer such as `703` for
  " version `7.3`, therefore suitable for conditional execution:

    " if version < 600
    " else
    " endif

" # Features

  " Vim cam be compiled with different capabilities.

  " All the capabilities are documented at:

    " help feature-list

  " # has

    " Check if a feature is enabled at runtime:

      " echo has('python')

    " Returns `1` or `0`.

" # sources

  " - <http://andrewscala.com/vimscript/>

    " A few good straight to the point, important vimscript tips

  " - <http://www.ibm.com/developerworks/linux/library/l-vim-script-1/index.html>

    " begginner tuts on vimscript

" # help

  " # help command

    " The most important of all commands

    " See the default help page given by the `helpfile` option:

      " h

    " Can tab complete. Type:

      " h ma

    " Hit <tab> and see what I mean.

    " For comands use colon:

      " h :t

    " For options use single quotes:

      " h 'more'

    " For functions, parenthesis:

      " h range()

    " For registers, use double quotes:

      " h "%

    " For default mappings, use:

      " h a
      " h A
      " h CTRL-A
      " h c_CTRL-A " c for Command mode

    " To select the language, use the helplang option.

    " help uses tags like ctags. To navigate, to over a link and hit `C-]`.

  " # helpgrep

    " grep all the help files for expressions.

  " # helpfile

    " File to open when `help` is given no optoins:

      " help

      " set helpfile?

  " # helpheight

    " Default height of the help window:

      " set helpheight?

  " # helplang

    " Language in which to view the documentation by default:

      " set helplang?

    " Contains two letter language codes like `en`.

    " Non English help files should be of form `.??x` instead of `txt`.
    " where `??` is the 2 letter language code.

  " # helptags

    " Generate help tags for a given directory recursivelly.

    " Considers all `.txt` files.

  " # create help files

    " Help files end in the extension `.txt` or `.??t` where `??` is the 2
    " letter language code.

    " The only semantically special thing about helpfile syntax are the tags
    " (link targets) which are written between asterisks:

      " *link-here*

    " Links are of the form:

      " |link-here|

    " and appear without the pipes `|` and in a different color when
    " viewing the file with the `help` command.

    " To generate the tags for a directory do:

      " helptags ~/.vim/doc/

    " This will create a file called `doc/tags`

    " Help searches for all tag fiels named `docs/tags` in the 'runtimepath' option.

    " Now you can open any of the tags in any of the files with:

      " h link-here

    " The rest is just convention:

    " At the beginning of the file use:

      " *filename.txt*

    " So that people can open that file.

    " TOC:

      " ==============================================================================
      " CONTENTS                           *MYPlugin-contents*

        " 1.Intro...................................|NERDTree|
          " 1.1.Functionality provided............|NERDTreeFunctionality|

    " - h1 (80 lines long)

      " ==============================
      " 1.Header name     *h1-tag*

    " - h2 (80 lines long):

      " ------------------------------
      " 1.1Header name     *h2-tag*

" # ex commands

" # commands

  " Is anything that can come after you type ':'

  " In vimscript every line must start with a command.

  " In `.vim` script files, you don't need to add the ':'

  " Examples: `:w`, `:d`, `:let`, `:cal`, `:norm`, etc.

  " Many commands have one ore more short versions which
  " is are prefix of the full version. Examples:

    " :delete
    " :d

    " :join
    " :j

  " It is recommended that you use the full version in scripts
  " for greate consistensy and readability, and only use
  " short version for interactive sessions.

  " Every vimscript statement starts with a command.

  " Commands are saner than mappings because they have no timeout and generate no conflicts.

  " The only downside of commands is that they must start with an upper case letter.

  " - variables

    " You must assign them with the `let` command:

      " let a = 1

    " and *never* as:

      " "a = 1

    " because `a` is not a command, but a variable.

    " You can use a inside of other commands directly:

      " echo a

  " - functions

      " function! F()
        " echo 1
        " endfunction

    " `F` is not a command, so you **cannot** do:

      " :F()

    " You can however call a function with the `call` command:

      " :call F()

  " It is possible to define your own commands.

  " Things that are not commands:

  " - `h`, `j`, `k` and `l` (movements). This is called aa *normal mode command*.
    " Thoes can be accessed from a vimscript via the `normal` command.

  " You can create you own commands with `command`.

  " # command command

    " View all user defined commands (including those in plugins):

      " command!

    " Only those that start with start

      " command start

    " Define a new command.

    " `!` to override existing without error. It is usually the better to use
    " it always and leave end result to precedence.

    " # args

    " # f-args

    " # nargs

      " `-nargs=0` is the default:

        " command! Echoa echo 'a'
        " Echoa

        " command! -nargs=0 Echoa echo 'a'
        " Echoa

      " `-nargs=1` is special because it considers the spaces into the argument:

        " command! -nargs=1 Echo1 echo <args>
        " Echo1 'a' 'b'

      " Output: `a b`.

        " command! -nargs=1 Echo1 echo "<args>"
        " Echo1 a b c

      " Output: `a b c`.

      " There seems to be now way to refer to an specific argument:
      " best workaround seems to be to define a function and use `<f-args>`

      " Other possible values for `-nargs` are: `*`, `?` and `+`, analogous
      " to regexp meaning:

        " command! -nargs=* Echo1 echo "<args>"
        " Echo1 a b c

        " command! -nargs=? Echo1 echo "a<args>"
        " Echo1
        " => a
        " Echo1 b
        " => ab

      " Pass arguments to function: use `f-args`:

        " command! -nargs=* Echo1 echo '<f-args>'
        " Echo1 a b c

      " Output:

        " a","b","c"

    " Name must start with uppercase letter. For this reason, it is not possible to override
    " built-in commands which start with lowercase. The best workaround seems to be using cnoreabbrev;
    " <http://stackoverflow.com/questions/7513380/vim-change-x-function-to-delete-buffer-instead-of-save-quit/7515418#7515418>

      " :cabbrev e <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'E' : 'e')<CR>

    " Define command only on current buffer:

      " command! -buffer Test echo 1

    " # range

      " By default commands take no range. Change that.

      " Default to current line:

        " command! -range Echo echo "<line1> <line2>"

      " - If the command if run without a range,
      "   both `<line1>` and `<line2>` expand to the same current line

      " - if run with a range, `<line1>` and `<line2>` expand to that range

      " Default to whole file instad of current line:

        " command! -range=% Echo echo "<line1> <line2>"

    " # sort

      " Sort lines in range:

        " sort

      " Sort and remove duplicates:

        " sort u

    " # !

      " Execute bash command:

        " ! echo a

      " `%` and family get expanded by default as with `expand`:

        " ! echo %

      " With a range, execute a command, pass range as stdin,
      " and replace the contents of the range with the stdout.

      " E.g.: before:

        " d
        " c
        " b
        " a

      " Command: `2,3!sort`

      " After:

        " d
        " b
        " c
        " a

" # Registers

  " Store user defined text, and things used as side effects of other commands,
  " e.g. q` macro recording or `%` for the name of the current file.

    " :h registers

  " Get help on a specific register, prefix with `"`:

    " :h "*

  " Nice thread: <http://stackoverflow.com/questions/1497958/how-to-use-vim-registers>

  " - `a-zA-Z`: general purpose.
  " - `0`: filled by last `y`
  " - `1`: filled by last `d` or `c`
  " - `2`: filled by before last `d` or `c`
  " - `3-9`: so on.
  " - `"`: last `d`, `c`, `s`, `x` or `y`. Used by `p` if no register specified.
  " - `-`: content of last `d` that deleted less than one line
  " - `+`: clipboard
  " - `*`: selection buffer on X11 (last selected text, can be pasted with middle click),
  "     same as `+` on Windows.
  " - `_`: black hole register: `/dev/null` of registers.
  " - `/`: last `/` search
  " - `.`: last inserted text
  " - `%`: basename name of the current file
  " - `#`: alternate file.
  " - `:`: last executed command-line

  " Get or set value of register: use `@`:

    " echo @a
    " echo @%
    " let @a=dd

" # comments

  " Start with '"'.

  " TODO: multiline?

" # spaces

  " Are mostly ignored like in C, except for newlines:

    " echo 1
    " echo 2

  " Therefore, you don't need `;` everythwere, but you need to get newlines right.

  " Multiline commands in script: start *next* line with `\` backslash:

    " echo
    " \ 1

" # multiline commands

  " You can use the pipe char '|' to replace *some*, *but not all* newlines

    " echo 1 | echo 2

  " For example, does *not* work for function definitions:

    " funcction F() | echo 1 | endfunction

" # Scope

  " -  `g:`: global. This is the default scope, even inside functions.

  " -  `s:`: local to current script file.

       " If you are going to call such a function from a mapping,
       " you need to define the mapping with `<SID>` as `nnoremap call <SID>Function<cr>
       " which magically expands to a unique internal name.

       " `s:` is also magic in the sense that `s:` functions
       " don't need to start with a capital letter.

  " -  `w:`: editor window

  " -  `t:`: editor tab

  " -  `b:`: editor buffer

      " Try:

        " let b:buffer = 1

      " Change buffers and:

        " let b:buffer = 2

      " Come back to first buffer and:

        " if b:buffer != 1 | throw 'assertion failed' | end

  " -  `l:`: defined inside a function.

      " function! F()
        " let l:var = 1
        " echo l:var
      " endfunction

    " Always use this for variables inside functions to avoid conflict with
    " globals.

  " - `a`: a parameter passed to the current function

      " They are readonly.

      " function! F(param)
        " echo a:param
        " let a:param = 1
        " echo a:param
      " endfunction

  " - `v`: vim predefined

  " # scopes are dicts

      " let g:a = 0
      " if g:['a'] != 0 | throw 'assertion failed' | end

    " This means that you can get default values if undefined as:

      " if !get(g:, "option_name", 0) | echo "undefined or 0" | fi

" # How to define a mapping in a plugin

    " help 41

  " # Fully blown map

    " Features:

    " - with GUI menu item

    " - helper function Add invisible outside script

    " - mapping can be customized from `~/.vimrc` with

      " - leader
      " - `map anything <plug>TypecorrAd`

    " In ftplugin:

      " if !hasmapto('<plug>PluginNameLocalFunction')
        " map <unique> <leader>a  <plug>PluginNameLocalFunction
      " endif
      " noremap <unique> <script> <plug>PluginNameLocalFunction  <sid>LocalFunction
      " noremenu <script> Plugin.Local\ Function\ label  <sid>LocalFunction
      " noremap <sid>LocalFunction  :call <sid>LocalFunction(expand("<cword>"), 1)<cr>
      " function s:LocalFunction(from, correct)
      " endfunction

    " Note that `noremap <script>` is the same as `map <script>`.

  " # SID

    " Example, in a plugin:

      " function! s:F()
        " return 1
      " endfunction

      " nnoremap f call <SID>F()<cr>

    " Now `F` can only be called as a helper inside the mapping,
    " and not directly to users of the plugin.

    " SID is needed here because otherwise `F` would not be found
    " from the calling context, since `F` is script specific.

    " The advantage of this is that you can make unique short names
    " for script helper functions, i.e. `F` instead of `MyScript_F`.

  " # Plug

  " # <Plug>

    " Generate a mapping that cannot be run with any keyboard input sequence.

    " Application: defining mappings in script while allowing the user to override them,
    " without exposing script specific helper functions.

    " This works because while it is not possible to input the sequence via keyboard,
    " `map` commands can still expand recursively to it, e.g.:

       "nnoremap <Plug>a :echo 1<cr>
       "map b <Plug>a

    " Now `normal b` will echo `1`.

" # Variables

  " Must use let always to assign:

    " let a = 2 | if a != 2 | throw 'assertion failed' | end

  " Can reassign:

    " let a = 'abc'
    " let a = 1

  " # exists

    " Check if variable is set or not:

      " if !exists('asdf')
      "   let asdf = 'qwer'
      " endif

  " # Environment variables

    " Just prefix with a dollar `$`.

    " For example, the home variable, inherited from the calling environment:

        " echo $HOME

    " Empty if not defined

    " Environment variables can also be set. They are exported to subshells:

        " let $a = 'b'
        " echo $a
        " !echo $a

    " # Predefined environment variables

      " Some environment variables are given default values if undefined at startup,
      " and are set for programmatic use inside Vim.

      " Shared root:

          " echo $VIM
          " echo $VIMRUNTIME

      " Location of .vimrc: http://stackoverflow.com/questions/8977649/how-to-locate-the-vimrc-file-used-by-vim-editor

          " echo $MYVIMRC

      " No analogue for ~/.vim/ , that is simply another path in the runtime path set from some default file:
      " http://vi.stackexchange.com/questions/3730/environment-variable-for-personal-runtime-path-vim-on-nix-vimfiles-on-w

      " TODO

          " echo $VIMINIT

" # List

" # Array

  " Literals:

    " let a = [1, 2, 3]

  " Multiline:
  " http://stackoverflow.com/questions/20936519/vimscript-can-list-creation-be-split-over-multiple-lines

  " Equality:

    " if [1,2] != [1,2] | throw 'assertion failed' | end
    " if [1,2] == [2,1] | throw 'assertion failed' | end

  " Get index of item:

    " if (index([1,2], 1) != 0) | throw 'assertion failed' | end
    " if (index([2,1], 1) != 1) | throw 'assertion failed' | end
    " if (index([1,2], 3) >= 0) | throw 'assertion failed' | end

  " Contains:

    " if (index([1,2], 3) >= 0) | throw 'assertion failed' | end

  " Unpack:

    " let [a,b] = [1,2]
    " if a != 1 | throw 'assertion failed' | end
    " if b != 2 | throw 'assertion failed' | end

  " Can be used to return multiple values from function.

  " range:

    " if range(3) != [ 0, 1, 2 ] | throw 'assertion failed' | end

  " # filter

    " done in place:

      " a = range(4)
      " filter(a, 'v:val > 1')
      " if a != [2,3] | throw 'assertion failed' | end

    " copy:

      " a = range(4)
      " let b = filter(filter(a, 'v:val > 1'))
      " if a != range(4) | throw 'assertion failed' | end
      " if b != [2,3]  | throw 'assertion failed' | end

" # Dicttionary #map data type

    " help Dictionary

  " Create and access: like Javascript:

    " let d = {1:'one', 'two':2}
    " if d.1 != 'one' | throw 'assertion failed' | end
    " if d[1] != 'one' | throw 'assertion failed' | end
    " if d.two != 2 | throw 'assertion failed' | end
    " if d['two'] != 2 | throw 'assertion failed' | end

  " Canot use the literal notation for keys inside variables:

    " let key = 1
    " if d.key != 'one' | throw 'assertion failed' | end

  " # get

    " Default value if missing:

      " let d = {1:'one', 'two':2}
      " if get(d, 3, 'three') != 'three' | throw 'assertion failed' | end

  " # keys

    " Get a list of the keys in arbitrary order:

      " let d = {1:'one', 'two':2}
      " echo keys(d)

  " # has_key

      " has_key({'a':100}, 'a')

  " # remove

      " let d = {1:'one', 'two':2}
      " let x = remove(d, 1)
      " if x != 'one' | throw 'assertion failed' | end

" # Character

  " No such variable type. Use string instead.

" # String

  " Escape:

    " echo 'That''s enough.'
    " echo '\"'

  " Only needed for exactly `\` and `"`

  " The only escape inside single quotes is `''` for `'`.

  " Special chars

    " C-like:

      " echo "\n"

    " Control chars:

      " echo "\<s-v>"

    " Appear like ^V

    " Must use double quotes:

      " echo '\n'

    " Outputs literal '\n'

  " # compare

    " Case sensitive:

      " "abc" ==# "Abc"
      " "abc" !=# "abcd"

    " Case insensitive:

      " "abc" ==? "Abc"

    " Sensitive or insensitive depending on `'ignorecase'`.

      " "abc" ==  "Abc"

    " Always use either `==#` or `==?` when comparing strings!!**,
    " since `==` can be broken by an option.

  " Concatenate:

    " if "ab" . "cd" != 'abcd' | throw 'assertion failed' | end

  " # repeat

    " cat a given number of times.

      " if repeat('ab', 3) != 'ababab' | throw 'assertion failed' | end

  " string to int:

    " if 10  + "10"  != 20   | throw 'assertion failed' | end
    " if 10  + "10.10" != 20   | throw 'assertion failed' | end
    " if 1.1 + "1.1"   != 2.1  | throw 'assertion failed' | end

  " Substring, range:

    " let a = 'abc'
    " if a[0]   != 'a'  | throw 'assertion failed' | end
    " if a[0:1]   != 'ab' | throw 'assertion failed' | end
    " if a[1:]  != 'bc' | throw 'assertion failed' | end
    " if a[-1]  != 'c'  | throw 'assertion failed' | end

  " equality:

    " if "ab" != "ab" | echo "fail" | end

  " test regex match:

    " if "ab" !~ "a." | echo "fail" | end

  " length:

    " if len("abc") != 3 | throw 'assertion failed' | end

  " split:

    " if split("a,b,c", ",") != [ 'a', 'b', 'c' ] | throw 'assertion failed' | end

  " join:

    " if join(["a", "b", "c"], ",") != 'a,b,c' | throw 'assertion failed' | end

  " int to string is done automatically (weak typing):

    " if 1 . '2' != '12'  | throw 'assertion failed' | end
    " if '1' . 2 != '12'  | throw 'assertion failed' | end
    " if 1 . '' != '1'  | throw 'assertion failed' | end

  " # repeat

    " Like Python string multiplication:

      " if repeat('a', 3) != 'aaa'  | throw 'assertion failed' | end

" # if

    " if 0
      " echo 0
    " elseif 1
      " echo 1
    " en

  " Single line:

    " if 0 | echo 0 | elseif 1 | echo 1 | else | echo 2 | end

  " # boolean operations

  " # true

  " # false

    " Like in C, all that matters is `== 0` or `!= 0`:
    " there is no buil-in true or false types or constants.

      " if !0   != 1 | throw 'assertion failed' | end
      " if !1   != 0 | throw 'assertion failed' | end
      " if !-1  != 0 | throw 'assertion failed' | end
      " if 0 && 1 != 0 | throw 'assertion failed' | end
      " if 0 || 1 != 1 | throw 'assertion failed' | end

" # switch

" # case

  " Nope:
  " http://vim.1045645.n5.nabble.com/Vim-script-optimization-tips-td5708524.html

" # for

    " for i in [1, 3, 2] | echo i | endfor

" # range() function

    " if range(1, 3) != [1, 2, 3] | throw 'assertion failed' | end
    " if range(3, 1, -1) != [3, 2, 1] | throw 'assertion failed' | end

  " Loop all lines of a file modifying them with any function.

    " for i in range(1, line('$'))
      " let l:line = getline(i)
      " let l:line =  substitute(l:line, 'a\(.\), '\1', '')
      " setline(i, l:line)
    " endfor

  " # Useful ranges

    " Start at current line, don't wrap:

      " for l:i in range(line('.'), line('$'))
      "  echo l:i getline(l:i)
      " endfor

    " Wrap: same as above, then after do line 0 to line - 1.

    " Loop over all characters. Exclude newlines:

      " for l:i in range(1, line('$'))
      "  for l:j in range(1, getline(l:i))
      "    echo l:i l:j getline(l:i)[l:j - 1]
      "  endfor
      " endfor

    " Loop over all characters. Include newlines:

      " for l:i in range(1, line('$'))
      "  let l:line = getline(l:i) . "\n"
      "  for l:j in range(1, len(l:line))
      "    echo l:i l:j getline(l:i)[l:j - 1]
      "  endfor
      " endfor

    " Start at current character, don't wrap: same as above, but treat the currrent line specially,
    " then restart at line + 1. Check if not last line.

    " Wrap: same as above, then after do line 0 to line - 1.

" # while

    " let i = 0
    " while i < 3
      " echo i
      " let i = i + 1
    " endwhile

  " There is no do-while loop

" # function

  " Name must start with uppercase character, or be `s:` scoped.
  " The name may also contain `#` in the context of autoloading.

  " '!' means can override existing function.

  " Cannot use | for single line

    " function! F(a, b)
      " retu a:a + a:b
    " endfunction

    " if F(1, 2) != 3 | throw 'assertion failed' | end

  " # vararg

  " # ...

      " function! F(a, b, ...)
        " for i in range(a:0)
          " echo a:{i}
        " endfor
        " endfunction

    " - a:0 contains the number of varargs. This does not cound regular
    "   arguments.
    " - a:1 contains the vararg arg.
    " - a:2 contains the second arg, and so on.
    " - a:000: array with all varargs

  " # call

    " Command to call function.

    " Ignores return value.

    " Only side effects can be useful therefore.

  " # call()

  " # apply

  " # splat

    " Function to call function with it's name given as string, and arguments as array.

    " Analogous to Javascript's apply.

    " Useful to forward varargs:

      " function! F(...)
        " return a:000
      " endfunction

      " function! G(...)
        " return call('F', a:000)
      " endfunction

      " if G(0, 1) != [0,1] | throw 'assertion failed' | end

  " # Multiple return values

    " Put them inside a list, and unpack at return time:

      " function! F()
        " return [1,2]
      " endfunction

      " let [a,b] = F()
      " if [a,b] != [1,2] | throw 'assertion failed' | end

  " No return val returns 0:

    " function! F()
    " endfunction

    " if F() != 0 | throw 'assertion failed' | end

  " # Default values

  " # Optional arguments

    " Concept does not exist in the language.

    " Workaround: varargs + counting.

      " function! F(a, ...)
        " if a:0 > 0
          " let l:b = a:1
        " else
          " let l:b = 10
        " endif

        " if a:0 > 1
          " let l:c = a:2
        " else
          " let l:c = 100
        " endif

        " return a:a + l:b + l:c
      " endfunction

      " if F(1) != 111 | throw 'assertion failed' | end
      " if F(2, 20) != 122 | throw 'assertion failed' | end
      " if F(3, 30, 300) != 333 | throw 'assertion failed' | end

  " # Assign function to a variable

    " Must use the `function` function:

      " function! F()
        " return 1
      " endfunction

      " let A = function('F')

      " "ERROR: must be capital
        " "let a = function('F')

      " if A() != 1 | throw 'assertion failed' | end

    " Also works:

      " echo function('F')()
      " call function('F')()

  " # preserve state after function

    " When writting plugins, many convenient commands only exist in the usual interactive form.

    " The problem is that such commands may have unwanted side effects, such as
    " modifying registers after `d`, or the last jump positions.

    " I am yet to find a general way to prevent such state loss.

    " The cleanest solution would for Vim to provide better commands for plugin writers.

" # exceptions

  " Throw:

    " throw 'abc'

  " Try catch finnaly:

    " try:
      " throw 'abc'
    " catch: /a./
      " echo 'a.'
    " catch:
      " echo 'default'
    " finally:
      " echo 'finnally'
    " endt

" # so

  " exe from given file (Source)

  " Source this file:

    " so %

  " Any vim output (ex `ec 1`) done in that file will be interpreted as an error.

  " # fini

    " stop sourcing script

      " fini
      " echo 1

" # command line

  " The line at the bottom (where `:` commands appear) is called the Vim
  " comand line or command prompt.

  " # Hide command line

    " Impossible?
    " - http://stackoverflow.com/questions/7770413/remove-vim-bottom-line-with-mode-line-column-etc
    " - http://superuser.com/questions/619765/hiding-vim-command-line-when-its-not-being-used
    " - http://unix.stackexchange.com/questions/140898/vim-hide-status-line-in-the-bottom

  " # Format command line

    " E.g., I'd like to show the full path there. TODO: couldn't even find feature request.

  " # echo

    " Print things to the Vim prompt:

      " echo 1
      " echo 'abc'
      " let a = 1
      " echo a

  " # echomsg

    " Like echo, but also adds it to message list which can be seen with `:messages`

  " # echoerr

    " LIke `echomsg`, but highlight the message with the error highlight,
    " which is much more visible in sane colorthemes.

    " Requires the user to hit Enter afterwards.

  " # messages

    " Show messages list. Lines are added to it from `echomsg` and `echoerr`.

  " # cmdheight

    " Option that controls the height of the command prompt.

      " set cmdheight?
      " set cmdheight=2
      " set cmdheight=1

  " # hit enter to continue

    " If a command generates more message lines than the prompt height, Vim stops
    " everythig and require you to press hit enter to continue:

      " echo 1 | echo 2

  " # shortmess

    " TODO controls ammount of messages output.

  " # more

    " If the `more` boolean option is set,
    " and if there are more lines output to the prompt than
    " total terminal lines, those lines are put into a (very limited) pager:

      " for i in rante(0, 1000) | echo i | endfor

  " # silent

    " The `silent` command takes any command and ignores its prompt output.

    " Silent still shows vim exceptions and waits for confirmation:

      " :silent echo idontexist

    " If you add '!', then it also ignores errors:

      " :silent! echo idontexist

    " There must be no space between '!' and sil!! otherwise you get a shell command:

      " :silent ! ls
      " :silent ! echo idontexist

" # input

  " Take user input from the command prompt until he hits enter.

    " echo input("question\nhere:")

" # redir

  " Redirect output of any *vim command* (ex :ec 1) output (for sh stdout (:! ls), use <#r>)

  " Redir to var a:

    " redir =>a | echo 1 | redir END
    " if a != 1 | throw 'assertion failed' | end

  " Append ro var a:

    " redir =>>a

  " Redir to register a:

    " redir @a
      " echo 1
    " redir END

" # shell commands

" # !

" # External commands

  " Excecute shell commands:

    " ! ls; ls

   " pass vim variable to bash command:

    " let a = 1
    " exe "! echo " . a

  " Ampersand required at the end of some commands

    " http://superuser.com/questions/386646/xdg-open-url-doesnt-open-the-website-in-my-default-browser
  "
    " TODO why?

    " - !firefox -new-tab http://example.com` fail but `!firefox -new-tab http://example.com &` works
    " - `!firefox file.html` works but `xdg-open file.html` fail and `xdg-open file.html &` works

  " # system

    " Exec sh command and get stdout

      " let a = system('ec asdf')
      " echo a
        " asdf

      " let a = system('sort', "b\na")
      " echo a
        " a
        " b

      " :echo v:shell_error
        " constains return status of last command executed by shell after
        " - ``:!``
        " - ``:r !``
        " - calling ``system()``

  " # exit status of shell command

    " Is stored in `v:shell_error`

    " Same as `$?`

    " Works after:

    " - !
    " - r !
    " - system

" # buffer

  " Buffers are RAM memory versions of files, possibly without saved to disk changes

  " They may be open on one or more windows or not.

  " When you exit Vim, buffers are lost by default, unless you have some plugin that saves and restores them
  " such as vim session.

  " # Loaded vs unloaded

    " If a buffer is loaded it occupies space in memory.

    " If a buffer is visible on a window, it must be loaded.

  " # Visible vs hidden

    " If a buffer is open on some window it is visible.

    " A buffer may be loaded without being visible. It is called a *hidden buffer*

  " # buffer list

    " Is a list of buffers vim knows of! =)

    " They may be loaded or not, visible or not.

  " # ls

    " Show buffer list:

      " ls

    " Status:

    " - `a`: Active == loaded and   visible
    " - `h`: Hidden == loaded but invisible
    " - `%`: current.
    " - `#`: previous.

  " Add file to buffer list but don't load it:

    " bad f1.txt

  " # buffer command

    " Very useful because of the tab complete!

    " Load buffer in the buffer list and make it visible in cur window

    " Does not however add new buffers to the buffer list.

    " By number 2:

      " b 2

    " By path:

      " b file.txt

    " Tab complete matches in middle of file paths for open buffers.

    " If there is a single match for a substring of path, <enter> opens it.

  " # edit

    " edit a file in current window.

    " Tab complete shows file in current directory,
    " not the buffer list.

    " If a file is not already in a loaded buffer, it is added to the
    " buffer list and loaded

    " If a file is already on a loaded buffer and that buffer has no
    " changes, updates the buffers to match disk (in case for example that
    " the file was modified externally of vim)

  " # sbuffer

    " Same as b, but split current window instead of unloading current buffer

      " sb 1

    " Unlike `b`, can be configured to use existing buffers open in windows
    " with `switchbuf`, much like `drop` does for `edit`.

  " # drop

    " Like `edit`, but focuses on an existing window
    " if any already contains the file opened.
    
  " # bunload

    " Unload current but don't remove it from buffer list.

      " :bunload

    " Closes *all* windows in which it was visible.

  " # bdelete

    " Unload and remove from list

    " Closes *all* windows in which it was visible

    " Current:

      " bd

    " By filename:

      " bd f1.txt f2.txt

    " By number (can be found with :ls)

      " bd 12 13

    " By range of bumbers:

      " 3,5bd

  " # bwipe

    " Wipe. like `bdelete`, but also removes all bufer metadata data like marks.

  " # hidden option

    " TODO

  " # write

    " Save current buffer to disk:

      " w

    " If file does not exit, create it.

    " Save with a different name and keep on current buffer:

      " w othername

    " To also change, use `save`.

  " # quit

    " Exit Vim with status 0. Only saves if all buffers were saved.

  " # cquit

    " Exit Vim with non-0 status.

  " # save

    " Save file with another name and open the other buffer:

      " save othername

  " # alternate file

    " Then you open a buffer on top of another on a window, "for example with `:b`,
    " the old buffer is remembered and is called the *alternate file*.

    " You can toogle between the current and alternate file with <c-*>.

      " :b

    " This behaviour can be orverriden with `keepalt`.

  " # scratch buffer

    " To create a buffer which contains only output which you want to
    " browse with Vim such as program output, use:

      " tabnew
      " setlocal buftype=nofile
      " setlocal bufhidden=wipe
      " setlocal noswapfile

    " It is not possible to save this buffer to a file,
    " and this buffer cannot conflict with any other since it has not
    " name.

    " Tabs containing this buffer show `[Scratch]` as the tab title.

    " If you want to save the contents of a scratch buffer to a file,
    " just use `w filename`.

  " # readonly

    " If true prevents file modification.

    " Less strict than modifiable.

  " # modifiable

    " If false, buffer cannot be saved.

    " This option is not local only! Setting it to false,
    " sets `nomodifiable` on new buffers.
    " So you almost always want to use `setlocal` with it.

  " # readonly

    " If false, prevents any buffer modification.

" # window

  " A window is a view of a buffer.

  " Multiple windows can be present in a single tab via splits.

  " A buffer may be visible in multiple windows.

  " Modifying a buffer in any window automatically modifies its view in other windows.

  " Close cur window:

    " :q

  " Does not delete its buffer from buffer list.

  " If this was the last visible window of the buffer,
  " also unloads the buffer.

  "  Close all windows and quit vim:

    " :qa

  " # only

    " Close all windows except current one.

  " # lines

  " # columns

    " Total tab width, size of terminal window, not affected by splits.

    " Modifying it on GVim resizes the X window:

      " set lines=30
      " set columns=50

  " # resize

    " Many options:

      " help window-resize

    " Set number of lines in window. Does not change window size: blank lines are added to end.

    " Fixed value:

      " resize 10

    " Relative values:

      " resize -5
      " resize +5

    " Set number of columns instead:

      " vertical resize 10

    " Only works if there are multiple splits, otherwise continues to occupy the entire screen TODO why.

  " # winwidth #winheight

    " Set minimum number of columns:

      " set winwidth=50

    " Cannot reduce window size, only increase.

    " Minimum half of current window:

      " let &winwidth=(&columns/2)

  " # winwidth() #get window width #winheight

    " Current window:

      " echo winwidth(0)
      " echo winheight(0)

    " Given window:

      " echo winwidth(2)
      " echo winheight(2)

  " # split #vsplit

    " Create an horizontal split with same bufer:

      " split

    " Set height of the new window:

      " 50split

    " Vertical;

      " vsplit

    " # scrollbind

      " Make both windows scroll at the same time;

        " nnoremap  vsplit
        " set scrollbind
        " norm <c-w>l
        " set scrollbind

  " # vertical

    " Execute command that would open an horizontal split but open a vertical split instead.

      " vertical help

  " # wincmd

    " normal window commands do not work (TODO why?)

      " vsplit
      " normal <c-w>l

    " For that to work you can use wincmd:

      " vsplit
      " wincmd l

" # tab

  " A tab is a collection of split windows.

  " # tab command

    " # tab command #:tab

      " Execute command, and if it would open a new window open a new tab
      " instead.

      " Ex: open help in a new tab instead of a new window.

        " tab help

  " # tabpagenr()

    " Get number of current tab:

      " echo tabpagenr()

    " Get number of last tab:

      " echo tabpagenr('$')

" # execute

  " Execute string as a Vim command:

    " execute 'let a = 10'

  " A command is anything that normally coes on a line of Vimscript.
  " Multiple commands can often be concatenated with `|`:

    " execute 'echo 1 | echo 1'

  " Multiple args are concatenated separated by space:

    " execute 'echo 1 |' 'echo 1'

  " Application: pass parameters to functions.

" # normal

  " Execute normal mode command:

    " normal! dd

  " This does *not* leave current mode and goes to normal mode, unless you tell it too
  " but has all the side effects of useing the commnad on normal mode.

  " With [!] execute normal mode command *without* mappings activated:

    " map a b

  " b:

    " normal! a

  " a:

    " normal! a

  " **Always use `!`**, unless you really want to use the user commands...  which is a rare case.

  " Multiple commands:

    " normal! jj

  " Goes twice down.

  " Special chars: you must either enter them literally with `<c-v>`,
  " or better, use `execute`, double quotes `"` and `\<cr>`

    " exe "norm! /a\<cr>"

  " Goes to line visual mode

" # editing commands

  " # print

    " Prints lines to prompt.

    " Current line:

      " print

    " # number

      " Also print line number.

        " number

  " # put

    " Insert `'abc'` on a new line after current line:

      " put = 'abc'

    " Insert from variable:

      " let a = 'abc'
      " put = a

    " Inserts content of register a:

      " put a

    " Put pefore cur line:

      " put! a

  " # delete

    " Delete lines, put them on register.

      " 1,3d

  " # read

    " Inserts contents of file here (Read).

      " read a.txt

    " Insert output of shell command here:

      " read !ls

    " For variables, use `put =`.

    " Preventing it from staring on next line is hard:

    " - http://superuser.com/questions/457944/vim-r-in-cursor-position
    " - http://vi.stackexchange.com/questions/862/read-after-cursor-instead-of-after-line

  " # put

    " Yank on a new line:

      " put ='abc'

  " # yank

    " Paste (Yank):

      " y

    " Yank to register a:

      " y a

    " Yank current line (same as yy so useless):

      " Y

    " Yank to clipboard;

      " map Y "+y

  " # t #copy

    " Copy line 3 after line 5 and before old line 6 (line 3 becomes the
    " new line 6):

      " :3t5

  " # move

    " Move line 3 to line 5:

      " :3m5

  " # join

    " Join current and next line:

      " j

    " Removes leading spaces of second line.

  " # global #:g #g

    " Does an arbitrary command on all lines that match a regexp.

    " Print all lines that match a regexp to command line:

      " :g/re/p

    " Do `s/find1/replace` in each line that matches regexp `find0`:

      " :g/^find0/s/find1/replace

    " Delete all lines that match a regex:

      " :g/re/d

    " Move all lines that match regex to beginning of file in reverse order:

      " :g/re/m0

    " Reverse file:

      " :g/./m0

" # range

  " For many commands you can specify a line range of action

  " Lines 1 and 2:

    " :1,2p

  " From cur line to end:

    " .+1,$p

  " All lines before the current line

    " :1,.-1p

  " All lines:

    " %p
    " 1,$p

  " All types of marks can be used. E.g., from mark `a` to mark `b`, inclusive:

    " :'a,'bp

  " Current paragraph:

    " :'{,'}p

  " /pattern/   next line where pattern matches

  " ?pattern?   previous line where pattern matches

  " - `\/`;      next line where the previously used search pattern matches
  " - `\?`;      previous line where the previously used search pattern matches
  " - `\&`;      next line where the previously used substitute pattern matches
  " - `0;/that`: first line containing "that" (also matches in the first line)
  " - `1;/that`: first line after line 1 containing "that"

  " <http://vim.wikia.com/wiki/Ranges>

" # autocmd

  " <http://www.ibm.com/developerworks/linux/library/l-vim-script-5/index.html>

  " Execute command automatically on an event.

  " # Events

    " Most useful event for something that must happen on all files:

      " BufNew,BufRead

    " Or if you have a filetype recognizer, use `FileType`.

    " List all events:

      " help event

    " Important events:

    " # BufEnter

      " Cursor enter buffers.

      " Triggered by: `:tabnext`, `<C-W>l`

      " Huge precedence, and worst performance than `BufNew,BufRead` since run more often.

        " autocmd BufEnter * echo input('BufEnter')

    " # BufRead

      " File is read into buffer.

      " Triggered by: `:e`, `:b`, `vim file` on existing files

      " Not triggered for new files.

        " autocmd BufRead * echo input('BufRead')

    " # BufNew

      " New buffer created. Des not need to be a file that did not exist on the filesystem like for `BufNewFile`.

        " autocmd BufNew * echo input('BufNew')

    " # BufNewFile

      " Buffer for file path that does not exist was created.

        " autocmd BufNewFile * echo input('BufNewFile')

    " # FileType

      " File is detected to be of a given type.

      " See `ftplugin` for more info.

      " Happens after `BufRead`, since file type may be determined from file contents as well as path (e.g. shebang line). TODO confirm.

        " autocmd FileType c,cpp echo input('FileType c,cpp')

  " # autocmd Order

    " Autocommands are always executed on the order that they are set thus:

      " autocmd BufEnter,BufRead * echo 1
      " autocmd BufEnter,BufRead * echo 2

    " Will always echo 1 and then 2

      " autocmd BufEnter,BufRead * echo 2
      " autocmd BufEnter,BufRead * echo 1

    " Will always echo 2 and then 1

  " # autocmd patterns

    " For many events except FileType, you can use the following patterns:

    " - `*.py`
    " - `*.py,*.pl`
    " - `*.{py,pl}`

    " For FileType, just enter enter the filetypes (`:se ft?`) comma separated:

      " au FileType c,cpp noremap a b

  " # Prevent duplication of autocmd

    " If you just add `autocmd` to your ~/.vimrc, they will get duplicated every time,
    " and run twice.

    " To avoid this you can:

    " -   add `autocmd!` to the top of your `.vimrc`.

        " TODO this had a downside but I forgot which.

    " -   use `autocmd! cmd`.

        " But this only allows you to have one autocmd per event type.

        " - use `augroup` with `autocmd!` on top.

    " You have to think up unique names, but it is one of the best options.

  " # augroup

    " Gives labels to multiple autocmds. That label can be used to trigger or disable those autocmds.

    " `au`s in a group are stil executed by default when the file is sourced.

      " augroup A
        " " With `!`, if inside a group, remove all autocmds in current group.
        " " If this is sourced multiple times, autocmds will only be defined once!
        " " Always use this techniqe.
        " " If used outside of an augroup, cancels all autocmds.
        " autocmd!

        " autocmd BufEnter * echo 1
        " autocmd BufEnter * echo 2
      " augroup END

      " " These are defined twice, and once more whenever this file is sourced,
      " " unless it does autocmd! somewhere.
      " autocmd BufEnter * echo 0
      " autocmd BufEnter * echo 0

    " Remove autocmds from group `A`:

      " autocmd! A

    " Remove all autocmds:

      " autocmd!

    " # doautocmd

    " # do

      " Execute autocmds that match events and files. If group is given, only execute from given group.

        " doautocmd A BufEnter *

" # map

" # noremap

" # nmap

" # nnoremap

  " Map keys and key sequences to other sequences of keys. and view what they are mapped to.

  " Main help file:

    " :h map

  " # modes

    " First learn what one character mode descriptions mean in the modes section.

    " With:

      " help map-modes

    " We see that:

    " - `:map`  does `nvo` == normal + (visual + select) + operator pending
    " - `:vmap`  does `xs` == visual + select
    " - `:xmap`  only `x`  == visual visual only
    " - `:smap`  only `s`  == select only
    " - `:map!` does `ic`  == insert + command
    " - `:lmap` does `icl` == insert + command + LangArgs

      " TODO lmap is doing nothing for me. How does it work?

    " Test them out:

      " nmap <F9> echo 'nmap'<CR>
      " nmap <F9> echo 'vmap'<CR>
      " imap <F9> echo 'imap'<CR>
      " cmap <F9> echo 'cmap'<CR>

  " # no versions

    " Don't remap recursivelly

    " Always use this to avoid lots of confusion =)

    " A and b become c:

      " map! a b
      " map! b c

    " A becomes b, b become c:

      " noremap! a b
      " noremap! b c

  " # ! version of commands

    " Without exclamation: map on all command like modes: normal, visual, ...

    " With: map on insert      : insert, command, ...

      " noremap  a b
      " noremap! a b

    " But cannot use exclamation with mode also:

      " noremap! a b

    " Makes no sense

  " # Override map

    " Whatever comes after wins:

      " map! a b
      " map! a c

    " just like `unmap`, **must** use the same version to override!

  " # unmap

    " Revert a map to its vim default:

      " map a b
      " unmap a

    " **must** use same version to set/unset:

      " map! a b
      " unmap! a

      " inoremap a b
      " iunmap a

      " map <buffer> a b
      " map <buffer> a b

  " # map to nothing

      " map! q <nop>

  " # view what something is currently mapped to

      " map a
      " map <c-a>

  " # multiple keys

      " map ab c

    " if you type a then b before the timeout, triggers c

    " if you type `a` and wait the timeout, triggers `a`

    " # timeoutlen

      " control timeout in ms

      " default: 1000ms

      " set timeoutlen = 10
      " set timeoutlen = 3000

  " # options for nnoremap

    " - <buffer>: only map on cur buffer. Should always be used on ftplugins.

    " - <silent>: don't print the input command to screen. Command output is
      " still visible

        " function! F()
          " echo 1
          " endfunction

        " map      a :cal F()<cr>
        " map <silent>   a :cal F()<cr>

    " - <expr>: evaluate rhs and map to result

      " ex:

        " map <expr> x 'a' . 'b'

      " is the same as:

        " map <expr> x ab

  " # which keys can be mapped

    " TODO check and understand all of this... very confusing.

    " vim is designed to work on terminals without X server.

    " # must have standard terminal representation

      " only stuff that has a standard terminal representation can have mappings in vim

      " of course, it is up to your terminal to determine what maps to
      " what, but usually ^X is achieved via c-x (except for c-@)

      " Control keys that can be mapped

        " http://vimhelp.appspot.com/vim_faq.txt.html#faq-20.5

      " # has standard terminal representation

        " - alpha (numbers are reserved for repeating motions)
        " - s-alphanum

        " - control

          " - c-{alpha}
          " - ^@
          " - ^[
          " - ^\
          " - ^]
          " - ^^[j]
          " - ^_
          " - ^?

          " note: c-[ is the same as esc, but can be remapped.

        " - {F keys}
        " - s-{F keys}

        " - alt-{alphanum} Also called meta key.

          " a, s-a, c-a, c-@...

      " # does not have standard terminal representation

        " those non-examples are dealt with in GUI programs by detecting that
        " one key is pressed while the other is down

        " however terminals cannot detect key up/down TODO confirm

        " - c-s-{key}
        " - c-a-{key}

    " # must not be a terminal control character

      " Non-examples:

      " - c-c: terminate process
      " - c-s: stop foreground process
      " - c-q: resume after c-s
      " - c-z: stop foreground process and put it on background
      " - c-d: eof
      " - c-v c-X: enter a literal control char

  " # which keys are a good idea to map

    " very useful manual section:

      " h map-which-keys

    " summary:

    " - use `<c-` or `<s-` for commands that must be done repeatedly several times

      " instead of two key combinations like `<leaders>a`

  " Allow map and motions to work together:

    " h map-operator

" # abbreviate

" # noreabbrev

  " Lists and creates abbreviations.

  " Abbreviations expand only if the character that follows them is non alphanumeric.

  " For sanity always use the `nore` version.

  " Example:

    " noreabbrev a abc

  " Now if you type:

    " a<space>
    " a.
    " ab<space>

  " You get repectively:

    " abc<space>
    " abc.
    " ab<space>

  " Abbreviate only on command mode:

    " cnoreabbrev a abc

  " Remove abbreviations for given trigger (including command mode ones):

    " unabbreviate a

" # bufdo

" # tabdo

" # windo

  " Do a command on all buffers, tabs or windows.

  " # noautocmd

    " Skip running autocmd.

    " Makes bufdo much faster.

      " noautocmd bufdo ...

" # set

" # Options tutorial

  " Options are global variable-like things that control Vim's operation.

  " Options are usually modified with `:set` instead of `:let`, although the latter is also possible.

  " Main help page:

    " h options

  " To get help on options, surround them with single quotes as:

    " h 'filetype'

  " View value of an option

    " set ft?

  " Set value on non boolean option:

    " set ft=vim

  " Set value of boolean option to true:

    " set expandtab

  " Set value of boolean option to false:

    " set noexpandtab

  " All non-negated boolean options support a `<no>name` version.

  " Toggle value of boolean optoin (only applicable to boolean options):

    " set wrapscan!

  " Get value of option programatically / to a variable.

    " echo &ft

  " Set option from variable (uses `let`, how insane):

    " let &option=variable

  " Set variable from option:

    " let &option=variable

  " Option value that contains spaces: backslash space:

    " set grepprg=grep\ -nH\ $*

  " Restore default Vim value:

    " set option&

  " # setlocal

    " Sets option only for cur buffer.

    " Only some options can have local values.

    " Should always be used instead of `:set` in ftplugin files which are
    " sourced for every file of a given type.

  " # set+=

    " help set+=

    " E.g.:

      " set path+=new_component

    " Ensures that duplicates don't appear in char separated lists, thus magic.

  " # misc options

    " This is a list of options that did not fit anywhere else,
    " by order or decreasing utility.

    " # modified

      " Determies if the current buffer has been modified or not since
      " last save. by default, modified buffers get a plus sign `+`
      " added to their titles.

        " set modified

    " # buftype

      " Sets the type of the buffer.

      " - `nofile`: buffer has no coresponding file. Cannot be saved.

        " Useful for buffers that will contain temporary data buffers.

    " # bufhidden

      " Determines what to do with bufferst that don't show in any
      " window.

      " - `wip`: does a `bwipe`. Good option for temporary buffers.

" # Builtin functions

  " # file operations #path operations

    " check file exists and is radable:

      " if filereadable("SpecificFile")
        " echo "SpecificFile exists"
      " en

    " # dirname

      " for a file or directory not enting in slash:

        " if fnamemodify('/a/b', ':h') != '/a' | throw 'assertion failed' | endif
        " if fnamemodify('/a/b/', ':h') != '/a/b' | throw 'assertion failed' | endif

      " whatch out for trailling slashes since that changes the meaning...

      " don't use `:p` since this makes no sense and does not work if the path does not exists!

    " ls path

      " :echo globpath(path, '*')

    " find .:

      " :echo split(globpath('.', '**'), '\n')

    " os path join: vim autoconverts `/` in paths to the correct os separator (ex Windows `\`)

    " # pathshortlen

      " Converts:

        " /path/to/file.txt

      " To:

        " /p/t/file.txt

      " Useful wiht setguilabel.

  " # expand

  " # %:p

  " # filename-modifiers

      " echo expand('%:r')

    " Important ones. Test path: `/a/b/f.ext`

    " - `%`: relative path of of file being edited
    " - `<sfile>`: like `%` but for file being sourced: http://stackoverflow.com/questions/4976776/how-to-get-path-to-the-current-vimscript-being-executed
    " - `%:p`: full path
    " - `%:r`: basename without extension
    " - `%:e`: extension
    " - `#`:   alternative file name

    " `!` shell commands automatically expand % just like `expand`:

      " !echo %

    " To avoid that, backslash escape it:

      " !echo \%
      " !echo \#

    " For the possible things you can expand see:

      " h filename-modifiers

    " Expansion happens automatically in commands where a filename is expected
    " like `edit`, but not otherwise like in `echo`.

    " # cword

      " Word under cursor like `*`:

        " echo expand('<cword>')

    " # cfile

      " File path under cursor like `gf`:

        " echo expand('<cfile>')

  " # position

  " # line

    " # line

      " Get various line numbers.

      " Get cur line number:

        " echo line(".")

      " Get last line number in buffer:

        " echo line("$")

      " Get first line of last visual selection:

        " echo line("'<")

      " Last one:

        " echo line("'>")

    " # col()

      " Same as `line` but for the column.

    " # getpos()

      " Get current: [buffer, line, column, offset].

      " Best way to get line and column in one call.

        " getpos('.')

    " # setpos()

      " Returns:

      " [bufnum, lnum, col, off]

      " `setpos()` with same args to set (last can be ommitted):

        " setpos('.', [0,2,3])

      " If buf number 0 means in current buffer.

      " Does not change jumplist.

    " # cursor()

      " Set cursor position. Subset of `setpos`. Does not affect the jump list:

        " cursor(line, col)

    " # keepjumps

      " Do a motion but don't change the jumplist.

        " normal! G
        " keepjumps normal! gg

      " Useful to maintain editor state in automatic motions from functions.

    " Get initial position while on visual mode:

       " getpos("'<")

    " Set visual selection position from function:

      " "put user in visual mode and set the visual selection
      " "
      " "if arguments are not valid, nothing is changed, and raises an exception
      " "
      " ":param 1:
      " "
      " "  Visual mode to leave user in.
      " "
      " "  must be either one of:
      " "
      " "  - 'v' for visual (default)
      " "  - "\<s-v>" for line visual
      " "  - "\<c-v>" for block visual
      " ":type 1: string
      " "
      " ":returns: 0
      " "
      " ":raises: bad mode argument, bad position argument
      " "
      " function! SetSelection(x, y, x2, y2, ...)
        " let valid_mode_strings = ["v","\<s-v>","\<c-v>"]

        " if a:0 > 0
          " if index(valid_mode_strings, a:1) >= 0
            " let mode = a:1
          " el
            " th 'bad mode argument: ' . a:1 . ' valid options: ' . join(valid_mode_strings, ', ')
          " en
        " el
          " let mode = 'v'
        " en

        " let oldpos = getpos('.')

        " if setpos('.', [0,a:x,a:y]) != 0
          " exe "norm! \<esc>"
          " th 'bad position argument: ' . a:x . ' ' . a:y . ' ' . a:x2 . ' ' . a:y2
        " en

        " exe 'norm! ' . mode

        " if setpos('.', [0,a:x2,a:y2]) != 0
          " exe "norm! \<esc>"
          " call setpos('.', oldpos)
          " th 'bad position argument: ' . a:x . ' ' . a:y . ' ' . a:x2 . ' ' . a:y2
        " en
        " endfunction

  " # mode()

    " Get current mode representation string:

      " echo mode()

    " Set mode:

      " normal! v

      " execute "normal! " . mode

  " # visualmode()

    " Get string representing type of last visual mode on cur buffer:

    " - `v`:   charcter
    " - `V`:   line
    " - `^V`:  block

    " This can be used with `normal!` to set back to last visual mode:

      " execute 'normal! ' . visualmode()

  " # buffer content

    " # getline

      " Get content of current buffer lines.

      " Get content of cur line:

        " echo getline('.')

      " Get a list of line strings from line 1 to line 3:

        " echo getline(1, 3)

      " All lines of buffer:

        " echo getline(1, line("$"))

    " # setline

      " Set content of one line:

        " call setline(line('.'), 'abc')

      " Set content of range starting at:

        " call setline(line('.'), ['abc', 'def', 'hji'])

    " # Get all characters between two positions (line / column pairs)

      " TODO

      " # Iterate characters in buffer

        " TODO

        " Doing the above gives an inneficient way to do this by iterating a string.

    " # append

      " Insert lines into the buffer.

      " Insert a new first line:

        " call append(0, "new line 1")

      " Insert multiple lines:

        " call append(0, ["new line 1", "new line 2"])

      " Must use a list for that.

      " Also consider the `put` command.

  " # search()

    " Same as '/' but:

    " - is a function
    " - does not set last jump mark (for use with `<c-o>` for example)
    " - has many options

    " Returns:

    " - line number if match
    " - 0 if no match

    " It is therefore preferable in Vimscript.

      " call search('a')
      " call search('\va')

    " Don't move cursor:

      " call search('a', 'n')

    " Backwards:

      " call search('a', 'b')

    " Wrap around end (default):

      " call search('a', 'w')

    " Don't wrap around end:

      " call search('a', 'W')

    " End of match:

      " call search('ab', 'e')

    " Stops at 'b' instead of 'a'

    " Start search from under cursor:

      " call search('a', 'c')

    " By default, if you are over an 'a' char and to search a,
    " you will move to next match. But not with 'c'.

    " # searchpos

      " Get column of match too:

        " let [line, column] = searchpos('a')
        " echo line
        " echo column

    " Get line and position of both start and end of search:

      " TODO

    " # searchpair

      " Search for pairs like 'if' 'else':

        " searchpair(TODO)

  " # getreg

    " Get value of a register from vimscript:

      " normal! '"ay'
      " echo getreg('a')

" # regex

    " help regex

  " Slightly Pearl like but... not really. Tons of extensions. This shall focus on differences from perl.

  " # magic

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

      " :h regex

    " # Very non-magic

      " Becomes not a regex, everything is literal, unless escaped by \:

      " Default regex:

        " /.*

      " Very non-magic:

        " /\V\.\*

    " # Very magic

      " You can change the flavour with \v! with \v, meaning Very magic,
      " only: [A-Za-0-9_] are not magic and thigs really work like in perl!

      " Example:

      " Default regex:

        " /\(a\+\)

      " Very magic regex:

        " /\v(a+)

      " You should always use very magic.

      " Points in which very magic is more magic than Perl

      " - `<` and `>` for word boundaries. This is insanely useful to find single character variables: `<x>`.
      " - `=` TODO same as `?`?

    " # Change default flavor

      " Cannot be done: <http://stackoverflow.com/questions/3760444/in-vim-is-there-a-way-to-set-very-magic-permanently-and-globally>

      " Would break too may plugings.

    " # Escaping in default mode

      " If you really use default mode, here the escape list follows.

      " Escape to be literal:

      " - `.`: wildcard

      " - `a*`: repetition

      " - `[abc]`: char classes

      " - `^`: begin. Only magic in certain positions, like beginning of pattern.

        " Use `\_^` for saner always magic version.

      " - `$`: end

      " Escape to be magic:

      " - `a\+`
      " - `a\(b\|c\)`: alternative and capture group. For a non capturing group, use `\%(\)`.
      " - `a\|b`
      " - `a\{1,3}`
      " - `a\{-}`: non # greedy repeat. Analogous to {,}, mnemonic: match less because of `-` sign.
      " - `\<`: word boundary left
      " - `\>`: word boundary right
      " - `\1`: mathing group 1. can be used on search
      " - `/\(\w\)\1`:  search equal adjacent chars

  " # Major differences from Perl

    " # Classes

      " - `\_s`: a whitespace (space or tab) or newline character
      " - `\_^`: the beginning of a line (zero width)
      " - `\_$`: the end of a line (zero width)
      " - `\_.`: any character including a newline

      " Many more.

    " # Lookahead

    " # lookbehind

    " # @=

      " Unlike Perl notation, comes outside the parenthesis with an `@` sign:

      " - `foo(bar)@=`: lookahead
      " - `foo(bar)@!`: negative lookahead
      " - `foo(bar)@<=`: lookbehind
      " - `foo(bar)@<!`: negative lookbehind
      " - `foo(bar)@>`: TODO

      " # \zs

      " # \ze

        " Also possible in a more restricted but sometimes convenient notation `\zs`,  `\ze` notation:

        " - `ab\zscd\zeef` is the same as: `(ab)@<=cd(ef)@=`

    "  #percent

    "  # %

      " The percent sign does a bunch of non-Perl new stuff:

      " - %^  beginning of file /zero-width
      " - %$  end of file /zero-width
      " - %V  inside Visual area /zero-width
      " - %#  current cursor position /zero-width
      " - %'m mark m position /zero-width
      " - %23l in line 23 /zero-width
      " - %23c in column 23 /zero-width
      " - %23v in virtual column 23 /zero-width
      " - %()  Non-capturing group.

    " # named capturing group

      " Does not exist: https://groups.google.com/forum/#!topic/vim_use/BsfxglpkufQ

  " # substitute

  " # :substitute

    " Replace in buffer.

    " Don't use it in scripts because `gdefault` breaks it: <https://google-styleguide.googlecode.com/svn/trunk/vimscriptfull.xml#Portability>

    " # Special replacement patterns

        " h sub-replace-special

      " Used by `:substitute` and `substitute()`.

      " - `\=`: replace by expression, like in Perl. Capture groups referred as `submatch(0)`.

      " Capture group:

        " :s/\(a\)/\1/

      " `\u` and `\l`: next char to upper or lower case. Set first letter of each line to uppercase / lower case:

        " :s/.*/\u&
        " :s/.*/\l&

      " `\U` and `\L`: next chars to upper or lower case until `\E` found. Set first letter of each line to uppercase / lower case:

    " # multiline

      " `\n` vs `\r` confusion: <http://stackoverflow.com/questions/71417/why-is-r-a-newline-for-vim>

      " When searching `\n` is a newline char, `\r` <CR>

      " When replacing `\n` is the null byte and `\r` a newline char

      " Replace two or more newlinews for two newlines:

        " :%s/\n\n+/\r\r/

    " # c confirm

      " Confirm each match replace before doing it:

        " :%s/a/a/c

      " Options:

      " - y: yes
      " - n: no
      " - a: replace all remaining
      " - q: quit
      " - l: last == yes and quit

    " # e noerror

      " Don't raise an error if pattern not found.

        " %s/aisudhaiuhewiu//
        " %s/aisudhaiuhewiu//e

  " # substitute()

    " Regexp replace in vimscript:

    " Arguments are:

    " - test string
    " - regexp find
    " - replace
    " - replace flags

      " if substitute('abc', 'a\(.\)c', '\1', '') != 'b' | throw 'assertion failed' | end

  " # =~

  " #!~

    " Check if string matches regex.

      " if 'abc' =~ 'a.c' | | else | throw 'assertion failed' | end
      " if 'abc' !~ 'a.c' |      throw 'assertion failed' | end

    " Case sensitive vs case sensitive like `==` vs `==#`.

      " if 'Abc' =~  'a.c' | | else | throw 'assertion failed' | end
      " if 'Abc' !~# 'a.c' | | else | throw 'assertion failed' | end

  " # match

    " Returns start of match index. If no match return `-1`.

      " if match('abc', '\v.c') != 1 | throw 'assertion failed' | end
      " if match('abc', '\v.b') != 0 | throw 'assertion failed' | end
      " if match('abc', '\vd')  != -1 | throw 'assertion failed' | end

  " # matchlist

    " Get list of matches, first the full match, then capturing groups.

    " This is the best way to use capturing groups.

      " let matches = matchlist('abcde', '\v(a.)c(.e)')
      " if matches[0] != 'abcde' | throw 'assertion failed' | end
      " if matches[1] != 'ab'  | throw 'assertion failed' | end
      " if matches[2] != 'de'  | throw 'assertion failed' | end

    " If no match is found, return the empty list `[]`:

      " if matchlist('abcde', '\vac') != [] | throw 'assertion failed' | end

  " # matchstr

    " Get matching string. Same as `matchlist()[0]`.

      " if matchstr('abc', '\v.c') != 'bc' | throw 'assertion failed' | end
      " if matchstr('abc', '\v.b') != 'ab' | throw 'assertion failed' | end

  " # perldo

    " If compiled with perl support (`vim --version | grep perl`),
    " you can use `perldo` for replacements with pure Perl regexps:

    " Ex:

      " :pe $a = 'b'
      " :perldo s/$a(.)/c\1/g

  " # retab

    " Replace tabs with spaces on the current file using Vim settings.

      " %retab

    " TODO understand precisely.

" # quickfix

  " Try it out:

    " set makeprg='cat'
    " make %
    " copen

  " # make

  " # makeprg

    " Runs commands based on the `makeprg` option on a shell and captures its output.

    " The default value for `makeprg` is `make`, so by default `:make` runs `!make`.

  " # copen

    " Everything that came out of commands like :make :vimgrep command, one per line.

    " Works well with tab:

      " tab copen

    " <enter> jumps to the line of the error on the buffer.

  " # cc

    " Jump the current error.

  " # Toggle the quickfix

    " Nope:
    " http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window

  " # cn

    " Jump to next error on buffer.

  " # cp

    " Jump to previous error.

  " # clist

    " List all errors.

  " # grep

  " # grepprg

  " # grepformat

    " Grep files, and add the output lines to the quickfix.

    " Hitting `<enter>` on the lines jumps to the match.

    " `grep` uses the external command given by the `'grepgrp'` option.

    " `grepformat` is used instead of `errorformat` to parse the output.

    " TODO also get the column (not parsed by the default grepformat):
    " http://stackoverflow.com/questions/16443544/how-to-print-column-offset-within-each-matching-line-in-grep

    " TODO don't block vim while results are coming in:
    " http://stackoverflow.com/questions/4865332/is-there-a-way-to-configure-vim-grepprg-option-to-avoid-waiting-until-the-extern

  " # vimgrep

    " `vimgrep` (`vim`), uses the internal vim regexp engine.

    " Tradeoff:

    " - very slow, likely because implemented in Vimscript!
    " - less optoins than GNU grep, e.g., ignore binary files like `grep -I`? `wildignore` works sometimes.
    " - integrates better with Vim features, e.g. `wildignore`.

    " Search for pattern recursively under current directory:

      " :vim /\vthe.pattern/ **

    " Fix file extension:

      " :vim /\vthe.pattern/ **.c

    " Fix file extension:

    " And you now have a navigable index!

  " # lvimgrep

  " # lopen

    " Use location list instead of quickfix. Similar, but there is one per window.

    " More appropriate when you have file outlines, like all headers of an HTML document,
    " or all functions of a C file.

        " :help location-list

  " # errorformat

    " Those options affect **only** how the input is parsed, not how the quickfix looks.
    " There seems to be no way of doing that:
    " http://stackoverflow.com/questions/11199068/how-to-format-vim-quickfix-entry/11202758#11202758

" # find

  " Find recursively by file name.

  " Requires exact basename match, starting from beginning ^.

  " Vim 7.3 supports tab completion of it,
  " which helps a lot.

  " Tab completion also works with globs:

    ":find *.cpp<tab>

  " But `:e` also tab completes, to they are basically identical if you do:

    ":edit **/something

  " :find
  " :sfind
  " :tabfind find in vim path var, and edit here, split, new tab

  " It is still not convenient, as you have to tab through matches, and only basename is considered, see also:
  " what I really want is to pipe `find | grep` to a quickfix.
  " https://www.reddit.com/r/vim/comments/1pohb9/the_equivalent_of_find_xargs_grep_in_vim/
  " http://stackoverflow.com/questions/3554719/find-a-file-via-recursive-directory-search-in-vim

" # Python scripting

  " You can script vim with python instead of vimscript!!!

  " This is a **GREAT** feature!!! no more vimscript for me except for the most simple tasks!!!

  " h python-vim

  " For this to work you need:

  " - python!
  " - vim compiled with python support

  " Separate commands go to the same python session:

    " py a = 1
    " py a = a + 1
    " py assert a == 2

  " Commands:

    " :py vim.command('p')         "execute an Ex command

  " Normal mode commands:

    " :py vim.command('normal j')    "down one line

  " Window:

    " :py w = vim.windows[n]      " Get window "n"
    " :py cw = vim.current.window " Get the current window
    " :py w.height = lines        " Set the window height
    " :py w.cursor = (row, col)   " Set the window cursor position
    " :py pos = w.cursor          " Get a tuple (row, col)

  " Buffer:

    " :py b = vim.buffers[n]       "gets buffer "n"
    " :py cb = vim.current.buffer    "gets the current buffer
    " :py name = b.name          "gets the buffer file name
    " :py line = b[n]          "gets a line from the buffer
    " :py b[n] = str           "sets a line in the buffer
    " :py b[n:m] = [str1, str2, str3]  "sets a number of lines at once
    " :py del b[n]             "deletes a line
    " :py del b[n:m]           "deletes a number of lines
    " :py del b[n:m]           "deletes a number of lines

  " # vim to python

    " Evaluate a vim expression and get its result into python

    " Returns:

    " - a string if the Vim expression evaluates to a string or number
    " - a list if the Vim expression evaluates to a Vim list
    " - a dictionary if the Vim expression evaluates to a Vim dictionary

    " Pass a vim integer variable to python:

      " :let a = 1
      " :py a = int(vim.eval('a'))
      " :py assert a + 1 == 2

  " # python to vim

    " Multiline python code:

"py << EOF
"def f():
  " print 1
"EOF

  " function! PythonTest()
    " py f()
    " endfunction

" # configuration

" # startup

" # Initialization

  " http://www.22ideastreet.com/debug/vim-directory-structure/

  " Help on startup sequence:

    " :help startup

  " Show the order in which scripts are run (including filetype plugins that
  " were not run for the current filetype):

    " :scriptnames

  " # Where something is set

  " # verbose

    " Run a single command with a given 'verbose' option level.

    " If the level is not given, `'verbose'` option level is set to `1`.

    " Very useful to debug.

    " Show what `a` is mapped to for each mode, and from which file it was mapped:

      " verbose map a

    " Analogous for options:

      " verbose set filetype?

  " # plugins

    " One very important thing that is executed *after* reading `.vimrc`:

      " runtime! plugin/**/*.vim

    " This is how plugins are loaded automatically once every time Vim starts.

    " The other major way is through ftplugin, but those have to be run once per
    " buffer since they depend on the file type.

  " # runtimepath

  " # rtp

      " set rtp?

    " Vim source path

    " Comma separated list of palces where TODO

    " Important stuff that is there by default on Linux:

    " - `/usr/share/vim` and some subdirs. Installation default.
    " - `~/.vim/`.     User managed.
    " - `~/.vim/after/`. User managed. Comes after Plugins.

    " # runtime

      " - search in rtp
      " - so all files found
      " - no error if non found
      " - wildcards work:

        " ru plutin/*.vim

" # ftplugin

" # filetype

  " Plugins that autocmd sources only for particular types of files

    " help ftplugin

  " List all known filetypes:

    " :echo glob($VIMRUNTIME . '/ftplugin/*.vim')

  " Show detection, plugin and indent status:

    " filetype

  " # create new filetype

    " Very well explained here:

      " h new-filetype

  " The filetype is stored in the `filetype` option.

  " # setfiletype

    " Set the filetype only if not yet set.

    " Set the 'filetype' option to {filetype}, but only if
    " not done yet in a sequence of (nested) autocommands.
    " This is short for: >

    " TODO should use this instead of `set filetype=X?

  " # detect filetype

    " Turn on filetype detection:

      " filetype on

    " Vim does detection for a bunch of file types by default.

    " This sources $VIMRUNTIME/filetype.vim, which in short does lots of
    " au for lots of known file types.

    " Detect filetype for current file again using the default scripts:

      " filetype detect

    " To detect a new `test` filetype, do:

      " mkdir -p ~/.vim/ftplugin
      " vim ~/.vim/ftplugin/test.vim

    " Then add the detect commands to it.

    " Extension only detection:

      " au BufNew,BufReadFile *.test set filetype=test

    " Extension + shebang detection:

      " function s:Ft()
      " if expand('%:p') =~# '.*\.test' || getline(1) =~# '\v^#!.*/bin/env\s+test>'
      "    set filetype=test
      " endif
      " endfunction
      " autocmd BufNew,BufReadFile * call s:Ft()

  " # Default ftplugin sourcing

    " Vim comes with good defaults for loading plugins only for given filetypes.

    " Turn on ftplugins detection:

      " ftplugin on

    " This ources $VIMRUNTIME/ftplugin.vim which in short executes all files inside

      " :ru! /ftplugin/

    " With vim extensions .vim in this directory and subdirectories
    " when the buffer of the right filetype enters.

    " For example for `c` files the following would all be sourced (in alphabetical path order)

      " c.vim
      " c_extra.vim
      " c/settings.vim

    " '_' is required to separate c form the arbitrary rest of the name

    " As explained in the help:

    " - always use setlocal    instead of set
    " -      map <buffer>       map

  " # Override defaults

    " This is currently a pain.

    " One possibility, is to use:

      " autocmd BufEnter *
      " autocmd FileType html

    " Directlyl into your vimrc.

    " Another possibility is to:

      " autocmd BufEnter so ~/.vimrc.after

    " And put everything that you want sourced after ftplugins in that file.

    " Another possibility is to use `after/ftplugin`, but the problem with 
    " that option is that it only works for single files.

  " #default indent sourcing

    " Exact same idea as ftplugin, but replace plugin by indent.

" # ins-complete #autocompletion #complete

  " While there are many hardcore autocompletion plugins, Vim does come with a
  " and simple autocomplete method.

  " For help see

    " :h ins-completion

  " Test with the following:

    " viado
    " vitelo

    " vi<cursor>

    " vishnu
    " vim

  " There are many methods of opening the autocomplete popup, most of which start with <c-x>.
  " except the most useful ones =):

  " - <c-p> (Previous) and <c-n> (Next) determine what do scan based on the 'complete' option

    " By default, `'complete'` searches for tons of things in a reasonable default order, first in current buffer,
    " and also includes matches in other open windows, buffers.

    " See:

      " set complete?
      " help 'complete'

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

  " # pumvisible()

    " Check if autocomplete PopUp Menu is visible. Useful to define mappings that only apply on the menu
    " as shown at:
    " <http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE>

  " The main downsides of the built-in autocopmletion are:

  " - it is hard to correct the completion

  " # ofu

    " TODO

      " set ofu=syntaxcomplete#Complete

" # diff

  " Open vertical split representing diff between current file and the other:

    " vert diffsplit <otherfile>

  " From the command line:

    " vimdiff a b

" # tags

" # ctags

  " Vim can read the ctags file format,
  " which allows you to quickly jump to the definition of functions and varaibles.

  " http://vim.wikia.com/wiki/Browsing_programs_with_tags

  " # Generate tags

    " Before jumping to tags, you have to generate them with an external program.

    " The location of the tags file can be configured with the `'tags'` option.

    " (*with* the semicolon), which looks up on parent directories until a tags file is found,
    " and then you just put one recursive tags file at the root of the project.

    " Programs that can generate tags include:

    " - `ctags` POSIX utility, implemented by GNU `ctags`

        " Generate tags for entire directory:

          " ctags -R

        " Will generate a `tags` file on the current directory, which is our desired output.

    " - `exuberant-ctags`: more feature rich alternative to `ctags`.

  " # Tag keyboard maps

    " Jump to first tag whose name is the same as the word currently under the cursor:

      " <C-]>
      " <C-LeftMouse>

    " Note that there may be multiple tags with the same name, in special the
    " definition and other declarations.

    " Jump to next or previous tag found with last jump command:

      " :tn
      " :tp

    " Show a list of all matched tags;

      " :ts

    " If there is more than one tag, show a tag list, else jump:

      " g <c-]>

    " Jump to tag with given name:

      " :ta dentry

    " Can auto complete.

" # Internals

  " # Compile

      " hg clone https://vim.googlecode.com/hg/
      " cd vim
      " ./configure --with-features=huge --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config//usr/lib/python2.7/config-x86_64-linux-gnu
      " make -j5
      " # To /usr/local/bin by default.
      " sudo make install

  " Changelog: not in source tree:
  " http://vim.1045645.n5.nabble.com/Where-can-I-find-the-CHANGELOG-for-Vim-td5551330.html

" # netrw

  " Set of scripts to do file operations, distribyted with Vim by default.

  " If the input passed to xdg-open does not start with the protocol (http://)
  " file:// is assumed.

  " The function that opens the URL is:

      "call netrw#NetrwBrowseX('http://example.com', 0)

  " # Explore

    " Open a file browser on current directory:

      ":Explore

    " Could be great, but is so crappy that you should just use ranger or something.

    " In any case, for opening files you can just do:

      ":e $SOME_DIR

    " and tab complete away.

    " NERDTree is a super popular plugin, but it is not that much better either.

    " Mappings:

      ":h netrw-quickmap

    " But Vim is so crappy that `set autochdir` cannot differentiate directories from files,
    " and sets the `pwd` to the parent directory... https://groups.google.com/forum/#!topic/vim_use/0f8HcCI1W8U
    " c is the best option...

  " # ftp

    " Vim has built-in ftp! =)

    " Open file browser:

      " vim ftp://username@host:port/

    " You will be asked for password

    " Navigate file browser (TODO):

    " Open file:

      " vim ftp://username@host:port/path/to/file.html

" # mksession

  " Vim has a built-in session system.

  " This sytem is made more confortable by plugins such as vim-session, but the backend is the same.

  " Create a session file called Session.vim

    " mksession

  " Overwrite if existing:

    " mksession!

  " Custom name:

    " mksession Custom_name.vim

  " What exactly to save is controlled by the vim

  " This saves a lot of trash to the sessionoptions option, such as:

  " - global variables, which are already set from your vimrc
  " - options which you only changed once, and do not to pass to the next session.

  " # viminfo

    " TODO.

    " Stores part of Vim state that is likely to be shared across all sessions.

    " Does not include tabs and windows.
