" reek.vim - Code smell detector for Ruby in Vim
" Author: Rainer Borene <https://github.com/rainerborene>
" Version: 1.0

if exists('g:loaded_reek') || !executable('reek')
  finish
endif
let g:loaded_reek = 1

if !exists('g:reek_always_show')
  let g:reek_always_show = 1
endif

if !exists('g:reek_debug')
  let g:reek_debug = 0
endif

if !exists('g:reek_on_loading')
  let g:reek_on_loading = 1
endif

function! s:Reek()
  if exists('g:reek_line_limit') && line('$') > g:reek_line_limit
    return
  endif

  let metrics = system("reek " . expand("%:p"))
  let loclist = []

  if g:reek_debug
    echom metrics
  endif

  for line in split(metrics, '\n')
    let err = matchlist(line, '\v\s+\[(.*)\]:(.*)')
    if strlen(get(err, 2)) > 1
      for lnum in split(err[1], ', ')
        call add(loclist, { 'bufnr': bufnr('%'), 'lnum': lnum, 'text': err[2] })
      endfor
    end
  endfor

  call setloclist(0, loclist)
  if len(loclist) > 0
    exec has("gui_running") ? "redraw!" : "redraw"
    if g:reek_always_show
      " Only show location if we are running reek on loading
      if g:reek_on_loading
        ll
      endif
    endif
  endif
endfunction

" Function to run reek and display location list
function s:RunReek()
  call s:Reek()
  lopen
endfunction

" Only set up automatic call if we request reek_on_loading
if g:reek_on_loading
  augroup reek_plugin
    autocmd!
    autocmd! BufReadPost,BufWritePost,FileReadPost,FileWritePost *.rb call s:Reek()
  augroup END
endif

command! RunReek call s:RunReek()
