"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Functions {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! blink#BlinkToEditPoint(flags, normal)
  let flags = a:flags

  "Todo: maybe need to adjust the cursor position for NORMAL mode
  if a:normal
  endif

  call search(b:point_regexp, flags)
  return ''
endfunction

function! blink#Update()
  let filetype = &filetype
  if has_key(g:blink_point, filetype)
    let g_point = g:blink_point[filetype]
    let b:point_regexp = s:GetPointRegexp(g_point)
  endif
endfunction

function! s:GetPointRegexp(point)
  let points = split(a:point, ',')
  let escaped_points = map(points, function('s:Escape'))
  let point_regexp = '\v('.join(escaped_points, '|').')'
  return point_regexp
endfunction

function! s:Escape(key, val)
  let result = substitute(a:val, '\([(){}[\]<>]\)', '\\\1', 'g')
  let result = substitute(result, '|', '\\zs', 'g')
  return result
endfunction

function! s:GetConfig(name, default)
  let name = 'g:blink_'.a:name
  return exists(name) ? eval(name) : a:default
endfunction
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Config {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:point_default = s:GetConfig('point_default',
      \ '(|),{|},[|],{\n\s*|\n\s*},>|<,"|",''|''')

let b:point_regexp = s:GetPointRegexp(s:point_default)
" }}}

" vim: fdm=marker
