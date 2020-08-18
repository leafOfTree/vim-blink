"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Functions {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! blink#BlinkToEditPoint(flags, normal)
  let flags = a:flags

  "Todo: alter the cursor position for NORMAL mode
  if a:normal
  endif

  call search(b:point_regexp, flags)
  return ''
endfunction

function! blink#Update()
  let filetype = &filetype
  let g_point = g:blink_point[filetype]
  let b:point_regexp = s:GetPointRegexp(g_point)
endfunction

function! s:GetPointRegexp(point)
  let points = split(a:point, ',')
  let escaped_points = map(points, function('s:Transfer'))
  let point_regexp = '\v('.join(escaped_points, '|').')'
  return point_regexp
endfunction

function! s:Transfer(key, val)
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

let s:point_regexp_default = s:GetPointRegexp(s:point_default)
let b:point_regexp = s:point_regexp_default
" }}}

" vim: fdm=marker
