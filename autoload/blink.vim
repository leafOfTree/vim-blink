"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Functions {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! blink#BlinkToEditPoint(flags, normal)
  let point_regexp = exists('b:point_regexp')
        \ ? b:point_regexp
        \ : s:point_regexp_default
  call search(point_regexp, a:flags)
  return ''
endfunction

function! blink#Update()
  let filetype = &filetype
  if has_key(g:blink_point, filetype)
    let point = g:blink_point[filetype]
    let b:point_regexp = s:GetPointRegexp(point)
  endif
endfunction

function! s:GetPointRegexp(point)
  let points = split(a:point, ',\s*')
  let escaped_points = map(points, function('s:Escape'))
  let point_regexp = '\('.join(escaped_points, '\|').'\)'
  return point_regexp
endfunction

function! s:Escape(key, val)
  let result = a:val
  " For back compatibility to support `[|]`
  let result = substitute(result, '\[|\]', '\\[|\\]', 'g')
  " Ignore '\|'
  let result = substitute(result, '\(\\\)\@<!|', '\\zs', 'g')
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
      \ '(|), {|}, \[|\], {\n\s*|\n\s*}, >|<, "|", ''|''')

let s:point_regexp_default = s:GetPointRegexp(s:point_default)
" }}}

" vim: fdm=marker
