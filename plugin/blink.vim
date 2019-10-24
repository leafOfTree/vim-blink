inoremap <c-p> <c-r>=blink#BlinkToEditPointPrev()<cr>
inoremap <c-n> <c-r>=blink#BlinkToEditPointNext()<cr>

if exists("g:blink_point")
  augroup vim_blink
    autocmd!
    let filetypes = join(keys(g:blink_point), ',')
    execute "autocmd FileType ".filetypes." :call blink#Update()"
  augroup end
endif
