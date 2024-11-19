" =========================================================================
" =  단축키 지정                                                          =
" =  n(normal mode) 명령 모드                                             =
" =  v(visual, select mode) 비주얼 모드                                   =
" =  x(visual mode only) 비주얼 모드                                      =
" =  s(select mode only) 선택 모드                                        =
" =  i(insert mode) 편집 모드                                             =
" =  t(terminal mode) 편집 모드                                           =
" =  c(commnad-line) 모드                                                 =
" =  re(recursive) 맵핑                                                   =
"
"remap is an option that makes mappings work recursively. By default it is on and I'd recommend you leave it that way. The rest are mapping commands, described below:

":map and :noremap are recursive and non-recursive versions of the various mapping commands. For example, if we run:

":map j gg           (moves cursor to first line)
":map Q j            (moves cursor to first line)
":noremap W j        (moves cursor down one line)

"j will be mapped to gg.
"Q will also be mapped to gg, because j will be expanded for the recursive mapping.
"W will be mapped to j (and not to gg) because j will not be expanded for the non-recursive mapping.
"Now remember that Vim is a modal editor. It has a normal mode, visual mode and other modes.
"
"
" =  nore(no recursive) 맵핑                                              =
" =========================================================================
set number relativenumber
syntax on
set ai "set auto indent
set cindent
set showmatch
set wmnu
set tabstop=4
set hlsearch
set shiftwidth=4
set background=dark
set mouse=a

"##############################################################
"###################        terminal        ###################
"##############################################################
nnoremap <silent><F2> 
\:botright new<CR><bar>
\:terminal<CR><bar><ESC>
\:resize 10<CR><bar>
\:set winfixheight<CR><bar>
\:set nonu<CR><bar>
	\iLS_COLORS=$LS_COLORS:'di=1;33:ln=36'<CR>

" terminal buffer 에 진입했을 때 mode 를 normal 에서 terminal 모드로 변경
" 또한 줄번호를 없앤다.
autocmd BufEnter term://* start " do nothing
autocmd TermOpen term://* execute ":set nonu"
"let g:ConqueTerm_InsertOnEnter = 1

" <ESC> 입력 시 <C-\><C-n> 실행 => 터미널 모드에서 기본 모드로 전환
tnoremap <silent><ESC> <C-\><C-n>

" ------------------------------------
" 터미널 모드 
" ------------------------------------
" 터미널 모드에서 <Ctrl + w> 누르면 명령 모드로 전환하고 <Ctrl + w> 입력
" tmap <silent><C-w> <ESC><C-w>

"jk 혹은 kj 를 누르면 <ESC> 를 실행
"tmap <silent>jk <ESC>
"tmap <silent>kj <ESC>

"##############################################################
"###################       clipboard        ###################
"##############################################################
"clipboard 
"set clipboard=unnamed " use of OS clipboard
"vmap <C-c> y:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| clip.exe <CR><CR>
"map <C-v> :r ~/.vimbuffer<CR> 
"
"let s:clip = '/mnt/c/Windows/System32/clip.exe'
"if executable(s:clip)
"	augroup WSLYank
"		autocmd!
"		autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
"	augroup END
"endif

colorscheme koehler 
filetype off "required


"##############################################################
"###################        plug in         ###################
"##############################################################
"
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'eslint/eslint'
Plug 'pandark/42header.vim'
Plug 'vim-syntastic/syntastic'
Plug 'alexandregv/norminette-vim'
Plug 'bfrg/vim-cpp-modern'
Plug 'preservim/tagbar'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
call plug#end()

""#################################################
""########     vundle, plugin install      ########
""#################################################
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"
"" let Vundle manage Vundle, requried
"Plugin 'VundleVim/Vundle.vim'
"
""추가
"Plugin 'scrooloose/nerdtree'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'eslint/eslint'
"Plugin 'pandark/42header.vim'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'alexandregv/norminette-vim'
"Plugin 'bfrg/vim-cpp-modern'
"
"call vundle#end() "required
filetype plugin indent on

"Color Theme
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  "   " render properly when inside 256-color tmux and GNU screen.
  "     " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
	   set t_ut=
	   endif
"etc
set clipboard=unnamed


"airline
"#################################################
"########              airline            ########
"#################################################
let g:airline#extensions#tabline#enabled = 1 " turn on buffer list
let g:airline_theme= 'badwolf'
set laststatus=2 " turn on bottom bar
let g:airline#extensions#tabline#fnamemod = ':t'


"#################################################
"########    Keymapping ',' = <Leader>    ########
"#################################################
let mapleader=","

" changing $myvimrc
" :let $MYVIMRC=<value>
"open VIMRC 
nnoremap <Leader>rc :rightbelow vnew $MYVIMRC<CR>

"#################################################
"########          resize window          ########
"#################################################
nnoremap <silent> <Leader>= :exe "resize +3"<CR>
nnoremap <silent> <Leader>- :exe "resize -3"<CR>
nnoremap <silent> <Leader>] :exe "vertical resize +8"<CR>
nnoremap <silent> <Leader>[ :exe "vertical resize -8"<CR>
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>_ :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>} :exe "vertical resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>{ :exe "vertical resize " . (winheight(0) * 2/3)<CR>

"#################################################
"########            airline              ########
"#################################################
"airline keymapping
" 다음 버퍼로 이동
" fixing <ESC> undefined behavior
nmap <leader>. :bnext<CR>
nmap <ESC>j j
nmap <ESC>k k
nmap <ESC>h h
nmap <ESC>l l
nmap <ESC>: :
nmap <C-o> o
nmap <C-p> p
set notimeout
set ttimeout
set ttimeoutlen=10
nnoremap <ESC><ESC> <ESC>
nnoremap <ESC> <ESC>:w<CR>
"
" " 이전 버퍼로 이동
nmap <leader>m :bprevious<CR>
"
" 현재 버퍼를 닫고 이전 버퍼로 이동
" 탭 닫기 단축키를 대체한다.
nmap <leader>bq :bp <BAR> bd #<CR>

"#################################################
"########           Nerdtree              ########
"#################################################
autocmd vimenter * NERDTree
autocmd vimenter * Tagbar
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-h> <C-w><Left>
nnoremap <C-j> <C-w><Down>
nnoremap <C-k> <C-w><Up>
nnoremap <C-l> <C-w><Right>

nnoremap <C-F> :NERDTreeFind<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
"nnoremap <Leader>n :TagbarToggle<CR><bar>:NERDTreeToggle <CR> 

"#################################################
"########           Treesitter            ########
"#################################################



"#################################################
"########            Tagbar               ########
"#################################################
nnoremap <Leader>t :TagbarToggle <CR> 
" ------------------------------------
" tagbar 설정
" ------------------------------------
"let g:tagbar_position = 'topleft '
"let g:tagbar_position = 'botright'
let g:tagbar_position = 'leftabove split'
"let g:tagbar_position = 'rightbelow'
let g:tagbar_height = 20
"let g:tagbar_vertical = 30


"#################################################
"########            coc map              ########
"#################################################
inoremap <silent><expr> <Tab>
     \ pumvisible() ? "\<C-n>" : "\<TAB>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> gr <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)

set path+=**

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

"#################################################
"########            snippets             ########
"#################################################

let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['~/.vim/plugged/vim-snippets/UltiSnips']
"let g:UltiSnipsSnippetDirectories = ['UltiSnips']


"#################################################
"########            ctags                ########
"#################################################
"to previous tag
nnoremap <C-[> <C-o>
set tags=./tags,tags                "find tags in current dir
nmap <F12> :stj <c-r><c-w><CR>

"#################################################
"########          Javascript          ###########
"#################################################

"#################################################
"########          42 Header           ###########
"#################################################
"42_Header
nmap <f1> :FortyTwoHeader<CR>
autocmd FileType htmldjango let b:fortytwoheader_delimiters=['{#', '#}', '*']
let g:hd42user = 'dokwak'
let g:hdr42mail = 'dokwak@student.42seoul.kr'

"#################################################
"########        syntastic_checker        ########
"#################################################

" Enable norminette-vim (and gcc)
" let g:syntastic_c_checkers = ['norminette', 'gcc', 'g++'] "norminette + gcc
let g:syntastic_c_checkers = ['g++', 'gcc']
let g:syntastic_aggregate_errors = 1
" 1998
let g:syntastic_cpp_compiler_options = ' -std=c++98 -stdlib=libc++'
" 2017
"let g:syntastic_cpp_compiler_options = ' -std=c++17 -stdlib=libc++'

"#################################################
"########         42 norminette           ########
"#################################################
" Set the path to norminette (do no set if using norminette of 42 mac)
" let g:syntastic_c_norminette_exec = '~/.norminette/norminette.rb'
" let g:syntastic_c_norminette_exec = 'norminette'
" Support headers (.h)
" let g:c_syntax_for_h = 1
" let g:syntastic_c_include_dirs = ['include', '../include', '../../include', 'libft', '../libft/include', '../../libft/include']

" Pass custom arguments to norminette (this one ignores 42header)
"let g:syntastic_c_norminette_args = '-R CheckTopCommentHeader'

" Check errors when opening a file (disable to speed up startup time)
let g:syntastic_check_on_open = 1

" Enable error list
let g:syntastic_always_populate_loc_list = 1

" Automatically open error list
let g:syntastic_auto_loc_list = 1


" Skip check when closing
let g:syntastic_check_on_wq = 1 
:autocmd BufNewFile *.c 0r ~/.vim/templates/skeleton.c
:autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp
