" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  let s:toml      = '~/.ghq/github.com/sunecosuri/dotfiles/vim/dein.toml'
  let s:lazy_toml = '~/.ghq/github.com/sunecosuri/dotfiles/vim/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
end

"------------------------------------------------------------
" * 基本の設定
"------------------------------------------------------------

" Vi互換モードをオフ（Vimの拡張機能を有効）
set nocompatible

" ファイル名と内容によってファイルタイプを判別し、ファイルタイププラグインを有効にする
filetype indent plugin on

" 色づけをオン
syntax on

" コマンドライン補完を便利に
set wildmenu

" タイプ途中のコマンドを画面最下行に表示
set showcmd

" 検索語を強調表示（<Esc><Esc>を押すと現在の強調表示を解除する）
set hlsearch

" 検索時に大文字・小文字を区別しない。ただし、検索後に大文字小文字が
" 混在しているときは区別する
set ignorecase
set smartcase

" インクリメンタルサーチ
set incsearch

" オートインデント、改行、インサートモード開始直後にバックスペースキーで
" 削除できるようにする
set backspace=indent,eol,start

" オートインデント
set autoindent

" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline

" 画面最下行にルーラーを表示する
set ruler

" ステータスラインを常に表示する
set laststatus=2

" バッファが変更されているとき、コマンドをエラーにするのでなく、保存する
" かどうか確認を求める
set confirm

" ビープの代わりにビジュアルベル（画面フラッシュ）を使う
set visualbell

" そしてビジュアルベルも無効化する
set t_vb=

" コマンドラインの高さを2行に
set cmdheight=2

" 行番号を表示
set number

" キーコードはすぐにタイムアウト。マッピングはタイムアウトしない
set notimeout ttimeout ttimeoutlen=200

" <F11>キーで'paste'と'nopaste'を切り替える
set pastetoggle=<F11>

" タブ文字の代わりにスペース2個を使う
set shiftwidth=2
set softtabstop=2
set expandtab

"256色を有効にする
set t_Co=256

"colorschemeを設定する
"colorscheme default

"カーソル行の強調表示
"set cursorline

"スワップファイルをつくらない
set noswapfile

" 文字、改行コードを自動判別する
:set encoding=utf-8
:set fileencodings=default,euc-jp,sjis,utf-8,utf-16,utf-16le
:set fileformats=unix,dos,mac

" 履歴保存数
set history=50

set clipboard=unnamed

" 折りたたみ
set nofoldenable    " disable folding

" ctags自動保存
let g:auto_ctags = 1
let g:auto_ctags_directory_list = ['.git']
set tags+=.git/tags
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" 画面分割
nnoremap g <Nop>
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gl <C-w>l
nnoremap gh <C-w>h
nnoremap gs :<C-u>sp<CR>
nnoremap gv :<C-u>vs<CR>

"------------------------------------------------------------
" * 基本のキーマッピング
"------------------------------------------------------------

" Yの動作をDやCと同じにする
map Y y$

" <Esc><Esc>またはCtrl-lで検索後の強調表示を解除する
nmap <Esc><Esc> :nohlsearch<CR>
nmap <C-l>      :nohlsearch<CR>

" 前後のバッファへ移動
nnoremap <C-k> :bp<CR>
nnoremap <C-j> :bn<CR>
" バッファを削除
nnoremap ,D :bd<CR>

" set numberのトグル
nnoremap tn :setl number! number?<CR>

" x削除時にヤンクしない"
nnoremap x "_x

" Ctrl+d または Ctrl+lでEsc
inoremap <C-d> <Esc>
vnoremap <C-l> <Esc>

" Commandモードの履歴移動
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

"タブの移動をsl shで"
nnoremap sl gt
nnoremap sh gT

" 終了
nnoremap Q  :qa<CR>
nnoremap ,S :suspend<CR>


set tabpagemax=100

"-----------------------------------------------------------
" * quick run
"-----------------------------------------------------------
silent! nmap <C-q> <Plug>(quickrun)
" 実行結果を下に表示
" 実行後に出力バッファにカーソルを移動(qで閉じる)
let g:quickrun_config = {
  \ "*" : { 'split' : ''},
  \ "_" : { "outputter/buffer/into" : 1,},}
set splitbelow

"------------------------------------------------------------
" * autocmd
"------------------------------------------------------------
if has("autocmd")
  " rubyファイルの定義
  autocmd BufRead,BufNewFile {Jsfile,Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,*.cap,*.ctl,*.etl,*.ebf} set ft=ruby
  autocmd FileType php setlocal sw=4 sts=4 ts=4 et
  autocmd FileType pl setlocal sw=4 sts=4 ts=4 et
  autocmd FileType t setlocal sw=4 sts=4 ts=4 et
  autocmd FileType go  setlocal sw=8 sts=8 ts=8 noet
  autocmd FileType ruby set ts=2 sw=2 expandtab
  " md as markdown, instead of modula2
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd Filetype * set formatoptions-=r
endif

"------------------------------------------------------------
" * neocomplete
"------------------------------------------------------------

let g:neocomplete#enable_at_startup = 1 " 起動時に有効化
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_camel_case_completion = 0
let g:neocomplete#enable_underbar_completion = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

" ポップアップの操作
inoremap <expr><c-l> pumvisible() ? neocomplete#close_popup()."\<Esc>" : "\<Esc>"
inoremap <expr><c-c> neocomplete#cancel_popup()
" Ctrl+j, k で候補を移動
inoremap <expr><c-j> pumvisible() ? "\<C-n>" : "\<c-j>"
inoremap <expr><c-k> pumvisible() ? "\<C-p>" : "\<c-k>"
" Ctrl+i or Tab でSnippetsを展開
imap <C-i> <Plug>(neosnippet_expand_or_jump)
smap <C-i> <Plug>(neosnippet_expand_or_jump)
" ポップアップ、タグが存在しない場合は通常のTabを入力
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" スニペットファイル
let g:neosnippet#snippets_directory='~/dotfiles/snippets'

" 補完ポップアップのカラー設定
hi Pmenu ctermfg=7
hi Pmenu ctermbg=8
hi PmenuSel ctermbg=3
hi PmenuSbar ctermbg=0

"------------------------------------------------------------
" * VimFiler
"------------------------------------------------------------

" Space で起動
nnoremap <Space> :<C-u>VimFiler<CR>
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0

autocmd! FileType vimfiler call s:my_vimfiler_settings()
function! s:my_vimfiler_settings()
  nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_execute)", "\<Plug>(vimfiler_edit_file)")
endfunction
"eを押すとタブで開く"
let g:vimfiler_edit_action = 'tabopen'

"------------------------------------------------------------
" * vim-go
"------------------------------------------------------------

au FileType go nmap gi <Plug>(go-info)
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap gt <Plug>(go-test)
let g:go_fmt_command = "goimports"

"---------------------------------------------------------------"
"vimproc"
"---------------------------------------------------------------"
let s:vimproc_dll_path = '~/.vim/bundle/vimproc/autoload/vimproc_mac.so'

" 保存時に空白削除
nnoremap <C-d> :FixWhitespace <CR>

"---------------------------------------------------------------"
"pt"
"" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif

"---------------------------------------------------------------"
"unite"
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>


"---------------------------------------------------------------"
"vim rails"
"---------------------------------------------------------------"
"
"let g:rails_default_file='config/database.yml'
"let g:rails_level = 4
"let g:rails_mappings=1
"let g:rails_modelines=0
"function! SetUpRailsSetting()
"  nnoremap <buffer><Space>r :R<CR>
"  nnoremap <buffer><Space>a :A<CR>
"  nnoremap <buffer><Space>m :Rmodel<Space>
"  nnoremap <buffer><Space>c :Rcontroller<Space>
"  nnoremap <buffer><Space>v :Rview<Space>
"  nnoremap <buffer><Space>p :Rpreview<CR>
"endfunction
"
"aug MyAutoCmd
"  au User Rails call SetUpRailsSetting()
"aug END
"
"aug RailsDictSetting
"  au!
"aug END


"------------------------------------
" Unite-rails.vim
"------------------------------------
"{{{
"function! UniteRailsSetting()
"  nnoremap <buffer><C-H><C-H><C-H>  :<C-U>Unite rails/view<CR>
"  nnoremap <buffer><C-H><C-H>       :<C-U>Unite rails/model<CR>
"  nnoremap <buffer><C-H>            :<C-U>Unite rails/controller<CR>
"
"  nnoremap <buffer><C-H>c           :<C-U>Unite rails/config<CR>
"  nnoremap <buffer><C-H>s           :<C-U>Unite rails/spec<CR>
"  nnoremap <buffer><C-H>m           :<C-U>Unite rails/db -input=migrate<CR>
"  nnoremap <buffer><C-H>l           :<C-U>Unite rails/lib<CR>
"  nnoremap <buffer><expr><C-H>g     ':e '.b:rails_root.'/Gemfile<CR>'
"  nnoremap <buffer><expr><C-H>r     ':e '.b:rails_root.'/config/routes.rb<CR>'
"  nnoremap <buffer><expr><C-H>se    ':e '.b:rails_root.'/db/seeds.rb<CR>'
"  nnoremap <buffer><C-H>ra          :<C-U>Unite rails/rake<CR>
"  nnoremap <buffer><C-H>h           :<C-U>Unite rails/heroku<CR>
"endfunction
"aug MyAutoCmd
"  au User Rails call UniteRailsSetting()
"aug END
"}}}

"-------------------------------------
" rubocop
"-------------------------------------
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']
