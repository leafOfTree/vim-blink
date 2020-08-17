"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Functions {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! blink#BlinkToEditPoint(flags, normal)
  if a:normal
    if match(a:flags, 'b') != -1
      normal! h 
    else
      normal! l 
    endif
  endif

  call blink#BlinkToPoint(a:flags)

  if a:normal
    normal! h
  endif
  return ''
endfunction

function! blink#BlinkToPoint(flags)
  let regexp = (exists("b:point_regexp") && b:point_regexp != '')
        \ ? b:point_regexp 
        \ : s:point_regexp_default

  call search(regexp, a:flags)
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Config {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:point_default = s:GetConfig('point_default',
      \ '(|),{|},[|],{\n\s*|\n\s*},>|<,"|",''|''')

let s:point_regexp_default = s:GetPointRegexp(s:point_default)
let b:point_regexp = ''
" }}}

" vim: fdm=marker
