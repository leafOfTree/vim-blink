let s:blink_mapping_prev = exists('g:blink_mapping_prev') 
      \ ? g:blink_mapping_prev 
      \ : '<c-p>'
let s:blink_mapping_next = exists('g:blink_mapping_next') 
      \ ? g:blink_mapping_next 
      \ : '<c-n>'

execute 'inoremap '.s:blink_mapping_prev
      \.' <c-r>=blink#BlinkToEditPointPrev()<cr>'

execute 'inoremap '.s:blink_mapping_next
      \.' <c-r>=blink#BlinkToEditPointNext()<cr>'

if exists("g:blink_point")
  augroup vim_blink
    autocmd!
    let filetypes = join(keys(g:blink_point), ',')
    execute "autocmd FileType ".filetypes." :call blink#Update()"
  augroup end
endif
