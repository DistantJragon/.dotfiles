let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +32 ~/.config/nvim/init.lua
badd +1 lua/plugins/general.lua
badd +1 lua/keybindings.lua
badd +1 lua/keybindings-debug-mode.lua
badd +1 lua/plugins/coding-general.lua
badd +1 lua/plugins/coding-mason.lua
argglobal
%argdel
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit ~/.config/nvim/init.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
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
exe '1resize ' . ((&lines * 28 + 30) / 61)
exe 'vert 1resize ' . ((&columns * 117 + 118) / 236)
exe '2resize ' . ((&lines * 5 + 30) / 61)
exe 'vert 2resize ' . ((&columns * 117 + 118) / 236)
exe '3resize ' . ((&lines * 23 + 30) / 61)
exe 'vert 3resize ' . ((&columns * 117 + 118) / 236)
exe 'vert 4resize ' . ((&columns * 118 + 118) / 236)
argglobal
balt lua/keybindings.lua
let s:l = 32 - ((21 * winheight(0) + 14) / 28)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 32
normal! 0140|
wincmd w
argglobal
if bufexists(fnamemodify("lua/keybindings.lua", ":p")) | buffer lua/keybindings.lua | else | edit lua/keybindings.lua | endif
if &buftype ==# 'terminal'
  silent file lua/keybindings.lua
endif
balt lua/keybindings-debug-mode.lua
let s:l = 2 - ((1 * winheight(0) + 2) / 5)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
normal! 023|
wincmd w
argglobal
if bufexists(fnamemodify("lua/keybindings-debug-mode.lua", ":p")) | buffer lua/keybindings-debug-mode.lua | else | edit lua/keybindings-debug-mode.lua | endif
if &buftype ==# 'terminal'
  silent file lua/keybindings-debug-mode.lua
endif
balt lua/keybindings.lua
let s:l = 1 - ((0 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("lua/plugins/general.lua", ":p")) | buffer lua/plugins/general.lua | else | edit lua/plugins/general.lua | endif
if &buftype ==# 'terminal'
  silent file lua/plugins/general.lua
endif
balt ~/.config/nvim/init.lua
let s:l = 31 - ((29 * winheight(0) + 29) / 58)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 31
normal! 03|
wincmd w
exe '1resize ' . ((&lines * 28 + 30) / 61)
exe 'vert 1resize ' . ((&columns * 117 + 118) / 236)
exe '2resize ' . ((&lines * 5 + 30) / 61)
exe 'vert 2resize ' . ((&columns * 117 + 118) / 236)
exe '3resize ' . ((&lines * 23 + 30) / 61)
exe 'vert 3resize ' . ((&columns * 117 + 118) / 236)
exe 'vert 4resize ' . ((&columns * 118 + 118) / 236)
tabnext
edit lua/plugins/coding-general.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
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
exe 'vert 1resize ' . ((&columns * 117 + 118) / 236)
exe 'vert 2resize ' . ((&columns * 118 + 118) / 236)
argglobal
balt lua/plugins/coding-mason.lua
let s:l = 27 - ((26 * winheight(0) + 29) / 58)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 27
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("lua/plugins/coding-mason.lua", ":p")) | buffer lua/plugins/coding-mason.lua | else | edit lua/plugins/coding-mason.lua | endif
if &buftype ==# 'terminal'
  silent file lua/plugins/coding-mason.lua
endif
balt lua/plugins/coding-general.lua
let s:l = 1 - ((0 * winheight(0) + 29) / 58)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 117 + 118) / 236)
exe 'vert 2resize ' . ((&columns * 118 + 118) / 236)
tabnext 1
set stal=1
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
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
