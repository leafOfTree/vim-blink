function! s:GetConfig(name, default)
  let name = 'g:blink_'.a:name
  return exists(name) ? eval(name) : a:default
endfunction

let s:blink_mapping_prev = s:GetConfig('mapping_prev', '<c-p>')
let s:blink_mapping_next = s:GetConfig('mapping_next', '<c-n>')
let s:blink_enable_normal = s:GetConfig('enable_normal', 0)

execute 'inoremap<silent> '.s:blink_mapping_prev
      \.' <c-r>=blink#BlinkToEditPointPrev()<cr>'
execute 'inoremap<silent> '.s:blink_mapping_next
      \.' <c-r>=blink#BlinkToEditPointNext()<cr>'
if s:blink_enable_normal
  execute 'nnoremap<silent> '.s:blink_mapping_prev
        \.' :call blink#BlinkToEditPointPrev()<cr>'
  execute 'nnoremap<silent> '.s:blink_mapping_next
        \.' :call blink#BlinkToEditPointNext()<cr>'
endif

if exists("g:blink_point")
  augroup vim_blink
    autocmd!
    let filetypes = join(keys(g:blink_point), ',')
    execute "autocmd FileType ".filetypes." :call blink#Update()"
  augroup end
endif
