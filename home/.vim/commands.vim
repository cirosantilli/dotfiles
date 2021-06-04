" All Copy.
command! Ac normal! ggVG"+y<c-o><c-o>
" Cat a given file into buffer.
command! -complete=file -nargs=1 Cat silent r! cat <args>
command! Chmx silent !chmod +x %
command! -range Ex <line1>,<line2>!expand -t4
command! -range=% Hd <line1>,<line2>HeaderDecrease
command! -range=% Hi <line1>,<line2>HeaderIncrease
command! Fgc execute '/^\(<<<<<<< \|=======$\|>>>>>>> \)'
" Search recursively under current directory.
" No useless enter confirmation (silent), and open a fullscreen
" error list instead of jumping to a match. Command gets pasted into terminal:
" - spaces: `Grep a\ b` or `Grep "a b"`
" - `-i`: Grep -i a
" - restrict file extension: G match *.c
command! -nargs=+ G execute 'silent grep! <args>' | tab copen
" TODO forward to G instead.
command! -nargs=+ Gi execute 'silent grep! -i <args>' | tab copen
" fugitive Ggrep (starts from Git toplevel dir), and then open on new tab.
command! -nargs=+ Gg execute 'silent Ggrep! <args>' | tab copen
command! -nargs=+ Ggi execute 'silent Ggrep! -i <args>' | tab copen
" Open ltag on a new tab.
" https://stackoverflow.com/questions/14465383/how-to-navigate-multiple-ctags-matches-in-vim/43866918#43866918
command! -nargs=1 Ltag silent ltag <args> | execute "normal \<C-o>" | tab lopen
" Current path to clipboard.
" http://vi.stackexchange.com/questions/3686/copy-the-full-path-of-current-buffer-to-clipboard
" Delete the curent file.
command! Rm !rm %
" TODO also somehow wipe the buffer.
"command! Rm !rm % | bwipe
" Toggle the status bar between mode 0 and 2.
command! Sl let &laststatus = ((!&laststatus) * 2)
command! Ss set spell!
command! St set tabstop=8
command! Sw set wrap!
command! -nargs=1 Tt tab tag <args>
" Search in all files under current directory recursively.
command! -nargs=1 Vim vimgrep/\v<args>/ **
" Write current file with sudo.
command! Wsudo write !sudo tee %
" Copy GDB breakpoint specifier to the clipboard.
command! Xg :let @+ = 'b ' . expand('%:p') . ':' . line('.')
" Copy full path to clipboard.
command! Xp :let @+ = expand('%:p')
" Copy relative path of current file relative to the git root to the clipboard.
command! Xr :let @+ = substitute(system('git ls-files --full-name ' . expand('%:p')), '\n$', '', '')

" Edit important files:

command! Eb tabedit ~/.bashrc
command! EB tabedit ~/.bashrc_local
command! Eg tabedit ~/.gitconfig
command! Ei tabedit .gitignore
command! Em tabedit Makefile
command! En tabedit ~/note.md
command! Ep tabedit ~/.profile
command! Er tabedit README.md
command! Et tabedit $NOTES_DIR/TODO.md
command! Ev tabedit ~/.vimrc

" Cscope:

" Find where the function under the cursor is called from.
function! Csc()
  cscope find c <cword>
  tab copen
endfunction
command! Csc call Csc()

function! Css()
  cscope find s <cword>
  tab copen
endfunction
command! Css call Css()

" Transform well formated selected line commented code to markdown.
"
" Well formated for languages that don't have fixed indentation:
"
" - use exact md, except that instead of header levels use 4 spaces for indentation
"   and always a single `#`
"
" for languages that have fixed inedentation (python):
"
" - always add a space after each comment, except for the code
"
"   this way, you can simply uncomment to try stuff out
"
"   not yet implemented
"
" this is only an heuristic, as nested lists are hard to tokenize
"
" :param comment: the regex that starts the line comment.
"
"   ex: `#` in python, `"` in vim
"
" :param comment: regexp that starts a comment
" :type comment: string
function! CodeToMd(line1, line2, ...)
  if a:0 > 0
    let l:comment = a:1
  else
    let l:comment = '#'
  endif
  let l:find = '\v^(\s*)  (' . l:comment . '#+)'
  for a:n in range(a:line1, a:line2)
    let a:l = getline(a:n)
    while a:l =~ l:find
      execute string(a:n) . 's/' . l:find . '/\1#\2/'
      let a:l = getline(a:n)
    endwhile
  endfor

  silent! execute a:line1 . ',' . a:line2 . 's/\v^\s*' . l:comment . '([^#])/\1/'
  " silent! execute '''<,''>s/\v^(#+)([^#])/\1 \2/'
  silent! execute a:line1 . ',' . a:line2 . 's/\v^\s+([^#])/  \1/'
endfunction
command! -range=% -nargs=? CodeToMd call CodeToMd(<line1>, <line2>, <f-args>)

" Wipe all buffers without corresponding existing files
" http://stackoverflow.com/questions/8845400/vim-wiping-out-buffers-editing-nonexistent-files
function! WipeBuffersWithoutFiles()
  let bufs=filter(range(1, bufnr('$')), 'bufexists(v:val) && '.
                                        \'empty(getbufvar(v:val, "&buftype")) && '.
                                        \'!filereadable(bufname(v:val))')
  if !empty(bufs)
    execute 'bwipeout' join(bufs)
  endif
endfunction
command! WipeBuffersWithoutFiles call WipeBuffersWithoutFiles()

" TODO: move to Find2 after testing it.
" http://stackoverflow.com/questions/3554719/find-a-file-via-recursive-directory-search-in-vim
" regex: grep -E regex to filter relative path
" find: find shell command. Should return a newline separated list of files
" git_toplevel: cd into the git toplevel before finding
function! Find(regex, find, git_toplevel)
  if (a:git_toplevel)
    let l:toplevel = system('git rev-parse --show-toplevel')
    if (v:shell_error)
      echomsg 'Not in a Git repo?'
      return
    endif
    execute 'lcd ' . l:toplevel
  endif
  let l:files = system(a:find . " | grep -E " . a:regex)
  if (v:shell_error)
    echomsg 'No matching files.'
    return
  endif
  tabedit
  set filetype=filelist
  set buftype=nofile
  put =l:files
  normal ggdd
  nnoremap <buffer> <Enter> <C-W>gf
  execute 'autocmd BufEnter <buffer> lcd ' . getcwd()
endfunction
command! -nargs=? Find call Find('<args>', 'find . -type f', 0)
command! -nargs=? Gfind call Find('<args>', 'git ls-files', 0)
command! -nargs=? Gtfind call Find('<args>', 'git ls-files', 1)

function! Find2(cmd)
  let l:files = system(a:cmd)
  if (l:files =~ '^\s*$')
    echomsg 'No matching files.'
    return
  endif
  tabedit
  set filetype=filelist
  set buftype=nofile
  " TODO cannot open two such file lists with this. How to get a nice label then?
  " http://superuser.com/questions/715928/vim-change-label-for-specific-tab
  "file [filelist]
  put =l:files
  normal ggdd
  nnoremap <buffer> <Enter> <C-W>gf
  execute 'autocmd BufEnter <buffer> lcd ' . getcwd()
endfunction
command! -nargs=1 Find2 call Find2("find . -iname '*'" . shellescape('<args>') . "'*'")
command! -nargs=1 Gfind2 call Find2('git ls-files | grep -E ' . shellescape('<args>'))
command! -nargs=1 Gtfind2 call Find2('git rev-parse --show-toplevel && git ls-files | grep -E ' . shellescape('<args>'))
command! -nargs=1 Locate call Find2('locate ' . shellescape('<args>'))
" TODO ctags version:
" http://stackoverflow.com/questions/5632125/how-do-i-create-a-vim-function-list-inside-quick-fix-window

" http://stackoverflow.com/questions/10884520/move-file-within-vim
function! Mv(newspec)
  let old = expand('%')
  " could be improved:
  if (old == a:newspec)
      return 0
  endif
  exe 'sav' fnameescape(a:newspec)
  call delete(old)
endfunction

" Refactoring commands.

function! CToCppComments()
  silent! g/\v^\s*\*\/$/d
  silent! %s/\v(^\s*)[ \/]\*( |$)/\1\/\/\2/
  silent! %s/\v( |)\*\///
endfunction
command! CToCppComments call CToCppComments()
command! -range=% TrailingSpace <line1>,<line2>s/\v\s+$//
command! BashMultiline s/ -/ \\\r  -/g
command! BashMultilinePos s/ / \\\r  /g

command! -nargs=1 -complete=file -bar Mv call Mv('<args>')
