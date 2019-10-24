"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Functions {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! blink#BlinkToEditPointPrev()
  let flags = 'wb'
  return blink#BlinkToEditPoint(flags)
endfunction

function! blink#BlinkToEditPointNext()
  let flags = 'w'
  return blink#BlinkToEditPoint(flags)
endfunction

function! blink#BlinkToEditPoint(flags)
  let regexp = (exists("b:point_regexp") && b:point_regexp != '')
        \ ? b:point_regexp 
        \ : s:point_regexp_default

  call search(regexp, a:flags)
  return ''
endfunction

function! blink#Update()
  let filetype = &filetype
  let g_point = g:blink_point[filetype]
  let b:point_regexp = s:GetBlinkPointRexp(g_point)
endfunction

function! s:GetBlinkPointRexp(point)
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
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Config {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:point_default = exists("g:blink_point_default") 
      \ ? g:blink_point_default 
      \ : '(|),{|},[|],{\n\s*|\n\s*},>|<,"|",''|'''

let s:point_regexp_default = s:GetBlinkPointRexp(s:point_default)
let b:point_regexp = ''
" }}}

" vim: fdm=marker
