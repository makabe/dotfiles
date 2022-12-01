call plug#begin('~/.vim/plugged')

Plug 'AndrewRadev/splitjoin.vim'
Plug 'Shougo/unite.vim'
Plug 'airblade/vim-gitgutter'
Plug 'buoto/gotests-vim'
Plug 'cohama/lexima.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-molder'
Plug 'morhetz/gruvbox'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'rust-lang/rust.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-ref'
Plug 'tpope/vim-fugitive'
Plug 'ConradIrwin/vim-bracketed-paste'

call plug#end()


" 内部文字コードをUTF-8に設定
set encoding=utf-8
" UTF-8で保存
set fileencodings=utf-8
" このスクリプトの文字コードをUTF-8に指定
scriptencoding utf-8

" バックアップを作成しない
set nobackup
" スワップファイル用ディレクトリ
set directory=$HOME/.vim/swap

" 新しい行のインデントを現在行と同じにする
set autoindent
" 字下げ,行末,挿入の開始点を超えてバックスペースで消去
set backspace=indent,eol,start


" 同期スクロールしない
set noscrollbind
" バッファを放棄するとき解放しない
set hidden

" marker で折りたたむ
set foldmethod=marker

" コマンドライン補完を拡張モードで行う
set wildmenu
" コマンドライン補完で、共通する最長の文字列を補完し、次から他の候補を羅列する
set wildmode=longest,list

" 10行余裕を持たせてスクロール
set scrolloff=10
" IME設定
set iminsert=0
set imsearch=-1

" 検索時に大文字小文字を区別しない
set ignorecase
" 入力中にインクリメンタルに検索
set incsearch
" 大文字を含んでいた場合 ignorecase を無視する
set smartcase
" 検索にマッチしたテキストをハイライトする
set hlsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan

" 行番号を表示する
set number
" 目印のカラムを常に表示する
set signcolumn=yes
" （lightline で表示するので）モード表示を省く
set noshowmode
" （lightline で表示するので）ルーラ表示を省く
set noruler
" コマンドを最下行に表示する
set showcmd
" 対応する括弧を表示
set showmatch
" 曖昧文字幅を半角幅で表示
set ambiwidth=single
" 不可視文字を表示する
set list
" 不可視文字の表示形式
set listchars=tab:»-,extends:~,trail:_
" ヴィジュアルベルを使用しない
set novisualbell
" 常にステータス行を表示する
set laststatus=2
" コマンドラインは1行
set cmdheight=1

" タブを展開する
set expandtab
" スマートタブ
set smarttab
" タブ幅
set tabstop=2
" インデント幅
set shiftwidth=2
" ソフトタブ幅
set softtabstop=2
" 色数
set t_Co=256
" 長い行をできるだけ表示する
set display=lastline


filetype plugin on

" 構文ハイライトを有効にする
syntax enable
" ファイルの最初からパース
syntax sync clear
syntax sync fromstart

" Use new regular expression engine
set re=0


nnoremap j gj
nnoremap k gk
nnoremap q <Nop>
nnoremap Y y$

nnoremap <silent> ;; :<C-E><C-u>Unite buffer<CR>
nnoremap <silent> ;f :<C-E><C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ;r :<C-E><C-u>Unite -buffer-name=register register<CR>

nmap <silent> eu :set fenc=utf-8<CR>
nmap <silent> ee :set fenc=euc-jp<CR>
nmap <silent> es :set fenc=cp932<CR>
nmap <silent> eru :e ++enc=utf-8 %<CR>
nmap <silent> ere :e ++enc=euc-jp %<CR>
nmap <silent> ers :e ++enc=cp932 %<CR>

nmap <silent> - :e <c-r>=expand('%:p:h')<cr><cr>

" trailing spaces を削除する
nmap <Leader>a :%s/\v {1,}$//g<CR>
" vimrc を source する
nmap <Leader>b :source $MYVIMRC<CR>
" ESC連打で検索結果のハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" visual で選択中の文字列で検索
vnoremap * "zy:let @/ = @z<CR>n
" 現在のパスを展開する
cmap <c-x> <c-r>=expand('%:p:h')<cr>/

" shebang 付きのファイルの保存時に実行権限を付与
augroup on_buf_write_post
  autocmd!
  autocmd BufWritePost * :call s:AddExecmod()
augroup END

function! s:AddExecmod()
  let line = getline(1)
  if strpart(line, 0, 2) ==# '#!'
    call system('chmod +x '. expand('%'))
  endif
endfunction

" ハイライト設定
highlight SignColumn   cterm=NONE      ctermfg=NONE ctermbg=232
highlight LineNr       cterm=NONE      ctermfg=245  ctermbg=232
highlight SpecialKey   cterm=NONE      ctermfg=240  ctermbg=NONE
highlight ZenkakuSpace cterm=NONE      ctermbg=NONE ctermbg=240
match ZenkakuSpace /　/

highlight Pmenu        cterm=NONE      ctermfg=255  ctermbg=232
highlight PmenuSel     cterm=underline ctermfg=214  ctermbg=232
highlight PmenuSbar    cterm=NONE      ctermfg=NONE ctermbg=233
highlight PmenuThumb   cterm=NONE      ctermfg=NONE ctermbg=238

highlight CursorColumn cterm=underline ctermfg=NONE ctermbg=233

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" netrw を無効化
let g:loaded_netrw=1
let g:netrw_loaded_netrwPlugin=1

" molder
augroup molder_config
  autocmd!
  " 行番号も行カーソルも表示しない
  autocmd FileType molder setlocal nonumber nocursorline
  " q で終了する
  autocmd FileType molder nmap <silent> <buffer> q :bw<CR>
augroup END

let g:molder_show_hidden = 1

" quickrun
let g:quickrun_config = {
\   '_' : {
\       'outputter' : 'buffer',
\       'outputter/buffer/into' : 1,
\       'outputter/buffer/split' : '',
\   },
\}
augroup quickrun_config
  autocmd!
  autocmd FileType quickrun setlocal nonumber
  autocmd BufNewFile,BufRead *.rs let g:quickrun_config.rust = {'exec' : 'cargo run'}
augroup END


" lightline
let g:lightline =  {
\ 'active': {
\   'left':  [ ['mode', 'paste'],
\              ['gitbranch', 'readonly', 'absolutepath', 'modified'] ],
\   'right': [ ['lineinfo' , 'charvaluehex'],
\              ['percent'],
\              ['fileformat', 'fileencoding', 'filetype' ],
\              ['diagnostics_hints', 'diagnostics_informations', 'diagnostics_warnings', 'diagnostics_errors', 'diagnostics_ok'] ],
\ },
\ 'component': {
\   'lineinfo' : '%4l:%-3v',
\   'charvaluehex': '%4B'
\ },
\ 'component_function': {
\   'gitbranch': 'LightlineGitBranch'
\ },
\ 'component_expand': {
\   'diagnostics_hints': 'LightlineDiagnosticsHints',
\   'diagnostics_informations': 'LightlineDiagnosticsInformations',
\   'diagnostics_warnings': 'LightlineDiagnosticsWarnings',
\   'diagnostics_errors': 'LightlineDiagnosticsErrors',
\   'diagnostics_ok': 'LightlineDiagnosticsOK'
\ },
\ 'component_type': {
\   'diagnostics_hints': 'ok',
\   'diagnostics_informations': 'ok',
\   'diagnostics_warnings': 'warning',
\   'diagnostics_errors': 'error',
\   'diagnostics_ok': 'ok'
\ },
\ 'separator': {
\   'left': "\ue0b8",
\   'right': "\ue0ba"
\ },
\ 'subseparator': {
\   'left': "\ue0b9",
\   'right': "\ue0bb"
\ }
\}

function! LightlineGitBranch() abort
  let l:branch = FugitiveHead()
  return strlen(l:branch) ? "\ue0a0 ".l:branch : ''
endfunction

function! LightlineDiagnosticsHints() abort
  let l:counts = lsp#get_buffer_diagnostics_counts()
  return l:counts.hint == 0 ? '' : printf("\uf834 %d ", l:counts.hint)
endfunction

function! LightlineDiagnosticsInformations() abort
  let l:counts = lsp#get_buffer_diagnostics_counts()
  return l:counts.information == 0 ? '' : printf("\uf05a %d ", l:counts.information)
endfunction

function! LightlineDiagnosticsWarnings() abort
  let l:counts = lsp#get_buffer_diagnostics_counts()
  return l:counts.warning == 0 ? '' : printf("\uf071 %d", l:counts.warning)
endfunction

function! LightlineDiagnosticsErrors() abort
  let l:counts = lsp#get_buffer_diagnostics_counts()
  return l:counts.error == 0 ? '' : printf("\uf05e %d ", l:counts.error)
endfunction

function! LightlineDiagnosticsOK() abort
  let l:counts = lsp#get_buffer_diagnostics_counts()
  let l:total = counts.error + counts.warning + counts.hint + counts.information
  return l:total == 0 ? "\uf00c" : ''
endfunction


" lsp
function! s:OnLspBufferEnabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc')
    setlocal tagfunc=lsp#tagfunc
  endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> ge <plug>(lsp-next-error)
  nmap <buffer> K <plug>(lsp-hover)
  " nmap <buffer> <leader>rn <plug>(lsp-rename)
  " nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  " nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
endfunction

augroup on_lsp
  autocmd!
  autocmd User lsp_buffer_enabled call s:OnLspBufferEnabled()
  autocmd User lsp_diagnostics_updated call lightline#update()
augroup END

let g:lsp_diagnostics_enabled     = 1
let g:lsp_signs_enabled           = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_popup_delay    = 200
let g:lsp_text_edit_enabled       = 0

let g:lsp_signs_error       = {'text': "\uf05e"}
let g:lsp_signs_warning     = {'text': "\uf071"}
let g:lsp_signs_hint        = {'text': "\uf834"}
let g:lsp_signs_information = {'text': "\uf05a"}

highlight LspErrorText            cterm=NONE      ctermfg=167  ctermbg=232
highlight LspWarningText          cterm=NONE      ctermfg=172  ctermbg=232
highlight LspInformationText      cterm=NONE      ctermfg=250  ctermbg=232
highlight LspHintText             cterm=NONE      ctermfg=223  ctermbg=232

highlight LspErrorLine            cterm=NONE      ctermfg=NONE ctermbg=NONE
highlight LspWarningLine          cterm=NONE      ctermfg=NONE ctermbg=NONE
highlight LspInformationLine      cterm=NONE      ctermfg=NONE ctermbg=NONE
highlight LspHintLine             cterm=NONE      ctermfg=NONE ctermbg=NONE

highlight LspErrorHighlight       cterm=NONE      ctermfg=NONE ctermbg=52
highlight LspWarningHighlight     cterm=NONE      ctermfg=NONE ctermbg=94
highlight LspInformationHighlight cterm=underline ctermfg=NONE ctermbg=NONE
highlight LspHintHighlight        cterm=underline ctermfg=NONE ctermbg=NONE


" gitgutter
let g:gitgutter_override_sign_column_highlight = 0

" rust
let g:rustfmt_autosave = 1

" prettier
let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0

" vim-go
let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "camelcase"
let g:go_metalinter_autosave = 1
let g:go_list_type = "quickfix"
let g:go_highlight_types = 1
let g:go_highlight_fields = 0
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 0
let g:go_highlight_operators = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

