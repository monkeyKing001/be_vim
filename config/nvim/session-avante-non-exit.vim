let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd /workspace2
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +76 src/run.cpp
badd +621 src/worker/elements/consumer/chatavatar_consumer.cpp
badd +156 include/worker/network.hpp
argglobal
%argdel
edit src/run.cpp
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 31 + 119) / 238)
exe 'vert 2resize ' . ((&columns * 134 + 119) / 238)
exe '3resize ' . ((&lines * 28 + 21) / 43)
exe 'vert 3resize ' . ((&columns * 71 + 119) / 238)
exe '4resize ' . ((&lines * 2 + 21) / 43)
exe 'vert 4resize ' . ((&columns * 71 + 119) / 238)
exe '5resize ' . ((&lines * 8 + 21) / 43)
exe 'vert 5resize ' . ((&columns * 71 + 119) / 238)
argglobal
enew
file NERD_tree_tab_1
balt src/run.cpp
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal nofoldenable
wincmd w
argglobal
balt include/worker/network.hpp
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 62 - ((27 * winheight(0) + 20) / 40)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 62
normal! 039|
wincmd w
argglobal
enew
balt src/run.cpp
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
wincmd w
argglobal
enew
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
wincmd w
argglobal
enew
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 119) / 238)
exe 'vert 2resize ' . ((&columns * 134 + 119) / 238)
exe '3resize ' . ((&lines * 28 + 21) / 43)
exe 'vert 3resize ' . ((&columns * 71 + 119) / 238)
exe '4resize ' . ((&lines * 2 + 21) / 43)
exe 'vert 4resize ' . ((&columns * 71 + 119) / 238)
exe '5resize ' . ((&lines * 8 + 21) / 43)
exe 'vert 5resize ' . ((&columns * 71 + 119) / 238)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
