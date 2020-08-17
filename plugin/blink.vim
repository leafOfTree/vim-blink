function! s:GetConfig(name, default)
  let name = 'g:blink_'.a:name
  return exists(name) ? eval(name) : a:default
endfunction

let s:blink_mapping_prev = s:GetConfig('mapping_prev', '<c-p>')
let s:blink_mapping_next = s:GetConfig('mapping_next', '<c-n>')
let s:blink_enable_normal = s:GetConfig('enable_normal', 0)

execute 'inoremap<silent> '.s:blink_mapping_prev
      \.' <c-r>=blink#BlinkToEditPoint("wb",0)<cr>'
execute 'inoremap<silent> '.s:blink_mapping_next
      \.' <c-r>=blink#BlinkToEditPoint("w",0)<cr>'
if s:blink_enable_normal
  execute 'nnoremap<silent> '.s:blink_mapping_prev
        \.' :call blink#BlinkToEditPoint("wb",1)<cr>'
  execute 'nnoremap<silent> '.s:blink_mapping_next
        \.' :call blink#BlinkToEditPoint("w",1)<cr>'
endif

if exists("g:blink_point")
  augroup vim_blink
    autocmd!
    let filetypes = join(keys(g:blink_point), ',')
    execute "autocmd FileType ".filetypes." :call blink#Update()"
  augroup end
endif
