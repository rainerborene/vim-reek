if exists('g:loaded_reek') || !executable('reek')
  finish
endif

let g:loaded_reek = 1

function! Reek()
  let metrics = system("reek -n " . expand("%:p"))
  let loclist = []
  let bufnr = bufnr('%')
  for line in split(metrics, '\n')
    let err = matchlist(line, '\v\s+\[(.*)\]:(.*)')
    if strlen(get(err, 2)) > 1
      for lnum in split(err[1], ', ')
        call add(loclist, { 'bufnr': bufnr, 'lnum': lnum, 'text': err[2] })
      endfor
    end
  endfor
  call setloclist(0, loclist)
  exec has("gui_running") ? "redraw!" : "redraw"
  ll
endfunction

autocmd! BufReadPost,BufWritePost,FileReadPost,FileWritePost *.rb call Reek()
