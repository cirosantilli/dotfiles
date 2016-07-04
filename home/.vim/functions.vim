" Functions to be reused across multiple commands.
" Should be one of the first things to be sourced.
" Less reusable functions that are made to implement a few comands
" only will go with the corresponding commands.

" Executes shell cmd and redirects output to a new unnammed buffer in
" a new tab next to the current one.
function! RedirStdoutNewTabSingle(cmd)
  tabnext
  if expand('%:p') != ''
    tabprevious
    execute 'tabnew'
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
  endif
  %delete
  execute 'silent read !' . a:cmd
  set nomodified
endfunction

" Map on all modes
function! MapAll(keys, rhs)
  execute 'noremap' a:keys a:rhs
  execute 'noremap!' a:keys '<ESC>'.a:rhs
endfunction

" Map on all modes in current buffer
function! MapAllBuff(keys, rhs)
  execute 'noremap <buffer>' a:keys a:rhs
  execute 'noremap! <buffer>' a:keys '<ESC>'.a:rhs
endfunction

" Run cmd in guake tab.
" If done once already, reuses same tab for other cmds.
" This tab is named GVIM.
" Number of this tab is stored in g:guakeTab
" If the tab gets closed, there is currently no way simple to detect it, and this method breaks.
let g:guakeTab = ''
function! GuakeSingleTabCmdHere(cmd)
  if g:guakeTab == ''
    " Create new tab.
    silent ! guake -n ~; guake -r 'GVIM'
    " Store its number.
    let g:guakeTab = substitute(system('guake -g 2>/dev/null'), '[\n\r]', '', 'g')
  end
  execute 'silent ! guake -s ' . g:guakeTab . ' && guake -e cd ' . expand("%:p:h") . ' && guake -e ' . a:cmd . ' && guake -t'
endfunction

function! EchoReadable()
  if ! filereadable(expand('%:p'))
    echo expand('%:p')
    bdelete expand('%:p')
  end
endfunction

" Open new Guake tab in cur dir
function! GuakeNewTabHere()
  execute ':silent ! guake -n ' . expand("%:p:h") . ' && guake -r ' . expand("%:p:h:t") . ' && guake -t'
endfunction

function! TmuxNewTabHere()
  " TODO: breaks rvm.
  execute ':silent ! tmux new-window -c ' . expand("%:p:h") ' && focus-terminal'
endfunction

function! KrusaderNewTabHere()
  execute ':silent ! krusader ' . expand("%:p:h")
endfunction
