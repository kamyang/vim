map <F9> :call SaveInputData()<CR>
func! SaveInputData()
	exec "tabnew"
	exec 'normal "+gP'
	exec "w! /tmp/input_data"
endfunc

" 判断操作系统
if (has("win32") || has("win64") || has("win32unix"))
	let g:isWIN = 1
else
	let g:isWIN = 0
endif
" 判断是终端还是gvim
if has("gui_running")
	let g:isGUI = 1
else
	let g:isGUI = 0
endif


"colorscheme torte
"colorscheme murphy
"colorscheme desert
"colorscheme desert
"colorscheme elflord
"colorscheme ron




"set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"set termencoding=utf-8
"set encoding=utf-8
"set fileencodings=ucs-bom,utf-8,cp936
"set fileencoding=utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示
"winpos 5 5          " 设定窗口位置
"set lines=40 columns=155    " 设定窗口大小
set go=             " 不要图形按钮
"color asmanian2     " 设置背景主题
"set guifont=Courier_New:h10:cANSI   " 设置字体
"syntax on           " 语法高亮
autocmd InsertLeave * se nocul  " 用浅色高亮当前行
autocmd InsertEnter * se cul    " 用浅色高亮当前行
"set ruler           " 显示标尺
set showcmd         " 输入的命令显示出来，看的清楚些
"set cmdheight=1     " 命令行（在状态行下）的高度，设置为1
"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)
"set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离
set novisualbell    " 不要闪烁(不明白)
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容
set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)
set foldenable      " 允许折叠
set foldmethod=manual   " 手动折叠
"set background=dark "背景使用黑色
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
" 显示中文帮助
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif
" 开启文件检查
filetype plugin on
filetype indent on
filetype on

" 设置配色方案
"colorscheme murphy
"字体
"if (has("gui_running"))
"   set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
"endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.hpp,*.sh,*.java exec ":call SetTitle()"

"定义函数SetTitle，自动插入文件头
func SetTitle()
	"如果文件类型为.sh文件
	if &filetype == 'sh'
		call setline(1,"\#########################################################################")
		call append(line("."), "\#	File Name:		".expand("%"))
		call append(line(".")+1, "\#	Author:			Kam Yang")
		call append(line(".")+2, "\#	mail:			741189517@qq.com")
		call append(line(".")+3, "\#	Created Time:	".strftime("%c"))
		call append(line(".")+4, "\#########################################################################")
		call append(line(".")+5, "\#!/bin/bash")
		call append(line(".")+6, "")
		exec "normal G"
	else
		call setline(1, "/*************************************************************************")
		call append(line("."), " *	File Name:		".expand("%"))
		call append(line(".")+1, " *	Author:			Kam Yang")
		call append(line(".")+2, " *	Mail:			741189517@qq.com")
		call append(line(".")+3, " *	Created Time:	".strftime("%c"))
		call append(line(".")+4, " ************************************************************************/")
		call append(line(".")+5, "")
	endif
	if expand("%:e") == 'hpp'
		call append(line(".")+6, "#ifndef ".toupper(expand("%:t:r"))."_H_")
		call append(line(".")+7, "#define ".toupper(expand("%:t:r"))."_H_")
		call append(line(".")+8, "#ifdef __cplusplus")
		call append(line(".")+9, "extern \"C\"")
		call append(line(".")+10, "{")
		call append(line(".")+11, "#endif")
		call append(line(".")+12, "")
		call append(line(".")+13, "#ifdef __cplusplus")
		call append(line(".")+14, "}")
		call append(line(".")+15, "#endif")
		call append(line(".")+16, "#endif //".toupper(expand("%:t:r"))."_H_")
		exec "normal 14gg"
	elseif expand("%:e") == 'h'
		call append(line(".")+6, "#ifndef ".toupper(expand("%:t:r"))."_H_")
		call append(line(".")+7, "#define ".toupper(expand("%:t:r"))."_H_")
		call append(line(".")+8, "")
		call append(line(".")+9, "#endif //".toupper(expand("%:t:r"))."_H_")
		exec "normal 10gg"
	elseif &filetype == 'cpp'
		call append(line(".")+6, "#include <iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
		exec "normal G"
		" 跳转到最后
	elseif &filetype == 'c'
		call append(line(".")+6, "#include <stdio.h>")
		call append(line(".")+7, "")
		"autocmd BufNewFile * normal G
		exec "normal G"
	endif
	""	if &filetype == 'java'
	""		call append(line(".")+6,"public class ".expand("%") " {")
	""		call append(line(".")+7,"	public static void main(String[] args) {")
	""		call append(line(".")+8,"")
	""		call append(line(".")+9,"	}")
	""		call append(line(".")+10,"}")
	""		exec "normal 10gg"
	""	endif
	"""新建文件后，自动定位到文件末尾
	"autocmd BufNewFile * normal G
endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y
"去空行
nnoremap <F2> :g/^\s*$/d<CR>
"比较文件
nnoremap <C-F2> :vert diffsplit
"新建标签
map <M-F2> :tabnew<CR>
"列出当前目录文件
map <F3> :tabnew .<CR>
"打开树状文件目录
map <C-F3> \be
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!clang++ % -std=c++11 -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!clang++ % -std=c++11 -o %<"
		exec "! ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!java %<"
	elseif &filetype == 'sh'
		exec "!chmod u+x %"
		:!./%
	elseif &filetype == 'py'
		exec "!python %"
		exec "!python %<"
	endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""实用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置当文件被改动时自动载入
set autoread
" quickfix模式
"autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"代码补全
set completeopt=preview,menu
"共享剪贴板
set clipboard+=unnamed
"从不备份
set nobackup
"make 运行
:set makeprg=g++\ -Wall\ \ %
"自动保存
set autowrite
set ruler                   " 打开状态栏标尺
set cursorline              " 突出显示当前行
set magic                   " 设置魔术
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\
" 设置在状态行显示的信息
set foldcolumn=0
set foldmethod=indent
set foldlevel=3
set foldenable              " 开始折叠
" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 不要用空格代替制表符
set noexpandtab
" 在行和段开始处使用制表符
set smarttab
" 显示行号
set number
" 历史记录数
set history=1000
"禁止生成临时文件
set nobackup
set noswapfile
"搜索忽略大小写
set ignorecase
"搜索逐字符高亮
set hlsearch
set incsearch
"行内替换
set gdefault
"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn
" 我的状态行显示的内容（包括文件类型和解码）
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
" 总是显示状态行
set laststatus=2
" 命令行（在状态行下）的高度，默认为1，这里是2
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 字符间插入的像素行数目
set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 为C程序提供自动缩进
set smartindent
" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile *  setfiletype txt
"自动补全
":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap " ""<ESC>i
":inoremap ' ''<ESC>i
"function! ClosePair(char)
"	if getline('.')[col('.') - 1] == a:char
"		return "\<Right>"
"	else
"		return a:char
"	endif
"endfunction
"filetype plugin indent on
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" 插件设置和安装
syntax enable
syntax on

set backspace=2

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on     " required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YCM 插件
Bundle 'Valloric/YouCompleteMe'

let mapleader = ","  " 这个leader就映射为逗号“，”
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'	"  配置默认的ycm_extra_conf.py
" 按下,jd会跳转到定义
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_confirm_extra_conf=0		 "	打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=1	" 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
" force recomile with syntastic
nnoremap <F6> :YcmForceCompileAndDiagnostics<CR>
" open locationlist
nnoremap <leader>lo :lopen<CR>
" close locationlist
nnoremap <leader>lc :lclose<CR>
inoremap <leader><leader> <C-x><C-o>
" 在注释输入中也能补全
let g:ycm_complete_in_comments = 1
" 在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 注释和字符串中的文字也会被收入补全

" 主题 solarized
Bundle 'altercation/vim-colors-solarized'
"let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
" 主题 molokai
Bundle 'tomasr/molokai'
let g:molokai_original = 1
let g:rehash256 = 1
" 配色方案
set background=dark
set t_Co=256
"let g:solarized_termcolors=256
if g:isGUI
    "colorscheme solarized
    colorscheme molokai
    "colorscheme phd
else
    "colorscheme solarized
    colorscheme molokai
    "colorscheme phd
endif

if g:isGUI      " 使用GUI界面时的设置
    set guioptions+=c        " 使用字符提示框
    set guioptions-=m        " 隐藏菜单栏
    "set guioptions-=T       " 隐藏工具栏
    set guioptions-=L        " 隐藏左侧滚动条
    "set guioptions-=r       " 隐藏右侧滚动条
    set guioptions-=b        " 隐藏底部滚动条
    "set showtabline=0       " 隐藏Tab栏
    set cursorline           " 突出显示当前行
endif

" nerdree 窗口插件
Bundle 'scrooloose/nerdtree'
" \nt                 打开nerdree窗口，在左侧栏显示
nmap <leader>nt :NERDTree<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$','\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
let g:netrw_home='~/bak'
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end

" targbar 插件
Bundle 'majutsushi/tagbar'
" \tb 打开tagbar窗口
nmap <leader>tb :TagbarToggle<CR>
let g:tagbar_autofocus = 1
" 设置tagbar 子窗口的位置出现在主编辑区的左边
let tagbar_left=1
" 设置标签子窗口的宽度
let tagbar_width=32
" tagbar 子窗口中不显示冗余帮助信息
let g:tagbar_compact=1
" 设置 ctags 对哪些代码元素生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
        \ 'd:macros:1',
        \ 'g:enums',
        \ 't:typedefs:0:0',
        \ 'e:enumerators:0:0',
        \ 'n:namespaces',
        \ 'c:classes',
        \ 's:structs',
        \ 'u:unions',
        \ 'f:functions',
        \ 'm:members:0:0',
        \ 'v:global:0:0',
        \ 'x:external:0:0',
        \ 'l:local:0:0'
     \ ],
	 \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

" taglist 插件
Bundle 'vim-scripts/taglist.vim'
" \tl                 打开Taglist/TxtBrowser窗口，在右侧栏显示
nmap <leader>tl :Tlist<CR><c-l>
" :Tlist              调用TagList
let Tlist_Show_One_File        = 1             " 只显示当前文件的tags
let Tlist_Exit_OnlyWindow      = 1             " 如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_Use_Right_Window     = 1           " 在右侧窗口中显示
let Tlist_File_Fold_Auto_Close = 1             " 自动折叠
"let Tlist_Sort_Type = "name"                  " items in tags sorted by name

" minibuffer 插件
Bundle 'fholgado/minibufexpl.vim'
" 多文件切换，也可使用鼠标双击相应文件名进行切换
let g:miniBufExplMapWindowNavVim    = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs  = 1
let g:miniBufExplModSelTarget       = 1


"rer窗口变小问题
let g:miniBufExplForceSyntaxEnable = 1
let g:miniBufExplorerMoreThanOne   = 2
let g:miniBufExplCycleArround      = 1
" buffer 切换快捷键，默认方向键左右可以切换buffer
map <C-Tab> :MBEbn<cr>
map <C-S-Tab> :MBEbp<cr>

"for file search ctrlp, 文件搜索
Bundle 'kien/ctrlp.vim'
"" 打开ctrlp搜索
let g:ctrlp_map = '<leader>ff'
let g:ctrlp_cmd = 'CtrlP'
" 相当于mru功能，show recently opened files
map <leader>fp :CtrlPMRU<CR>
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz)$',
    \ }
"\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

" 美化状态栏插件
Bundle 'Lokaltog/vim-powerline'
"if want to use fancy,need to add font patch -> git clone git://gist.github.com/1630581.git ~/.fonts/ttf-dejavu-powerline
"let g:Powerline_symbols = 'fancy'
let g:Powerline_symbols = 'unicode'
"let g:Powerline_colorscheme='solarized256'
" 括号匹配插件
Bundle 'kien/rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 40
let g:rbpt_loadcmd_toggle = 0

" 可视化缩进，将代码块关联起来
Bundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1  " 0 默认关闭 1 随vim自启动
let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level           = 2  " 从第二层开始可视化显示缩进
" \ig 打开/关闭 vim-indent-guides

" 将代码最后无效的空格标红
"for show no user whitespaces
Bundle 'bronson/vim-trailing-whitespace'
"\+space去掉末尾空格
map <leader><space> :FixWhitespace<cr>

" 快速移动插件
"更高效的移动 // + w/f/l
Bundle 'Lokaltog/vim-easymotion'

" 括号匹配跳转插件
Bundle 'vim-scripts/matchit.zip'

" 宏定义补全插件
Bundle 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"定义存放代码片段的文件夹
".vim/snippets下，使用自定义和默认的，将会的到全局，有冲突的会提示
let g:UltiSnipsSnippetDirectories=["snippets", "bundle/ultisnips/UltiSnips"]


" 快速加减注释
Bundle 'scrooloose/nerdcommenter'
let NERDSpaceDelims = 1

" 快速加环绕插件
Bundle 'tpope/vim-surround'
"for repeat -> enhance surround.vim, . to repeat command
Bundle 'tpope/vim-repeat'

" 自动括号补全插件
"自动补全单引号，双引号等
Bundle 'Raimondi/delimitMate'
" for python docstring ",优化输入
au FileType python let b:delimitMate_nesting_quotes = ['"']

" 代码对齐插件
"for code alignment
Bundle 'godlygeek/tabular'
" \bb                 按=号对齐代码 [Tabular插件]
nmap <leader>bb :Tab /=<CR>
" \bn                 自定义对齐    [Tabular插件]
nmap <leader>bn :Tab /

" 静态代码分析插件
" 使用pyflakes,速度比pylint快
Bundle 'scrooloose/syntastic'
let g:syntastic_error_symbol = '✗'  "set error or warning signs
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting = 0
"let g:syntastic_python_checker="flake8,pyflakes,pep8,pylint"
let g:syntastic_python_checkers=['pyflakes']
"highlight SyntasticErrorSign guifg=white guibg=black

let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
let g:syntastic_enable_balloons = 1 "whether to show balloons

" 快速跳转到TODO列表
Bundle 'vim-scripts/TaskList.vim'
map <leader>td <Plug>TaskList

" 维基百科插件
Bundle 'vim-scripts/vimwiki'
let g:vimwiki_w32_dir_enc     = 'utf-8' " 设置编码
let g:vimwiki_use_mouse       = 1       " 使用鼠标映射
let g:vimwiki_valid_html_tags = 'a,img,b,i,s,u,sub,sup,br,hr,div,del,code,red,center,left,right,h1,h2,h3,h4,h5,h6,pre,script,style'
                                        " 声明可以在wiki里面使用的HTML标签
" 对中文用户来说，我们并不怎么需要驼峰英文成为维基词条
let g:vimwiki_camel_case = 0

let blog = {}
    if g:isWIN
		if g:atCompany
			let blog.path          = 'D:/Files/Files/mysite/wiki/'
	        let blog.path_html     = 'D:/Files/Files/mysite/html/'
	        let blog.template_path = 'D:/Files/Files/mysite/templates/'
	        let blog.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
        else
	        let blog.path          = 'D:/Files/mysite/wiki/'
	        let blog.path_html     = 'D:/Files/mysite/html/'
	        let blog.template_path = 'D:/Files/mysite/templates/'
     	    let blog.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
        endif
    else
	let blog.path          = '~/mysite/wiki/'
	let blog.path_html     = '~/mysite/html/'
	let blog.template_path = '~/mysite/templates/'
endif
let blog.template_default  = 'site'
let blog.template_ext      = '.html'
let blog.auto_export       = 1

let g:vimwiki_list = [blog]

" 多光标推进
"for mutil cursor
Bundle 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Python 语法高亮插件
"python syntax highlight
Bundle 'hdima/python-syntax'
let python_highlight_all = 1

" STL 语法高亮
Bundle 'Mizuchi/STL-Syntax'

" 接口与实现快速切换
Bundle "a.vim"
" *.cpp 和 *.h之间切换
nmap <Leader>ch :A<CR>
" 子窗口中显示 *.cpp 和*.h
nmap <Leader>sch :AS<CR>

"
