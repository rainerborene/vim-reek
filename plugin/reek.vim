" reek.vim - Code smell detector for Ruby in Vim
" Author:       Rainer Borene <https://github.com/rainerborene>
"
" Install this file as plugin/reek.vim.

if exists('g:loaded_reek') || !executable('reek')
  finish
endif

let g:loaded_reek = 1

if !exists('g:reek_debug')
  let g:reek_debug = 0
endif

function! s:Reek()
  let metrics = system("reek -n " . expand("%:p"))
  let loclist = []
  let bufnr = bufnr('%')

  if g:reek_debug
    echom metrics
  endif

  for line in split(metrics, '\n')
    let err = matchlist(line, '\v\s+\[(.*)\]:(.*)')
    if strlen(get(err, 2)) > 1
      for lnum in split(err[1], ', ')
        call add(loclist, { 'bufnr': bufnr, 'lnum': lnum, 'text': err[2] })
      endfor
    end
  endfor

  call setloclist(0, loclist)
  if len(loclist) > 0
    exec has("gui_running") ? "redraw!" : "redraw"
    ll
  endif
endfunction

augroup reek_plugin
  autocmd!
  autocmd! BufReadPost,BufWritePost,FileReadPost,FileWritePost *.rb call s:Reek()
augroup END
