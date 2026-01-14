call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips'  | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Themes
Plug 'morhetz/gruvbox'
Plug 'https://github.com/joshdick/onedark.vim.git'
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'arcticicestudio/nord-vim'
Plug 'https://github.com/sainnhe/everforest.git' 
Plug 'https://github.com/junegunn/seoul256.vim.git'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'ayu-theme/ayu-vim'
Plug 'cocopon/iceberg.vim'
Plug 'w0ng/vim-hybrid'
Plug 'rafi/awesome-vim-colorschemes'
"Plug 'chrisbra/matchit'
Plug 'chrisbra/vim-diff-enhanced'

Plug 'daeyun/vim-matlab'

Plug 'Yggdroot/indentLine'
Plug 'mbbill/undotree'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Plug 'vim-latex/vim-latex'
call plug#end()

nmap <F6> :IndentLinesToggle<CR>
nmap <Down> <C-e>
call togglebg#map("<F5>")
set foldmethod=syntax


set hlsearch
set number
set cursorline
set colorcolumn=+1

"set paste
set hidden " allows modified buffers to stay in the background
set confirm " provides actions when quitting a modified buffer
set showcmd " show commands as they are being written, at the bottom right

set termguicolors     " enable true colors support
"let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
colorscheme my_ayu

" augroup NoLspWarnColor
"   autocmd!
"   autocmd ColorScheme *  hi! link LspWarningHighlight Normal
"   autocmd User lsp_diagnostics_updated  hi! link LspWarningHighlight Normal
" augroup END

augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
autocmd BufRead,BufNewFile COMMIT_EDITMSG set textwidth=72


" Autocomplete matching pairs
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap ' ''<Left>
inoremap " ""<Left>
inoremap { {}<Left>
inoremap [[ [
inoremap (( (
inoremap '' '
inoremap "" "
inoremap {{ {
nnoremap <c-q> :vim /\c/ **/*<Left><Left><Left><Left><Left><Left>
"" Conflicts with incrementing a number
" nnoremap <c-a> :Texvim 
nnoremap ]c ]czz
nnoremap [c [czz

nmap <F6> :call setqflist([])<CR>
nmap <F2> :tp<CR>
nmap <F3> :tn<CR>
  
" Toggle soft-wrapping in the current window
nnoremap <silent> <leader>w :setlocal wrap!<CR>

" Turn off wrapping for quickfix list
augroup quickfixListAndLocationListNoWrap
    autocmd!
    autocmd FileType qf setlocal nowrap
augroup END


" Disable cursorline in diff mode
autocmd VimEnter,BufWinEnter * if &diff | set nocursorline | endif

" Define a custom highlight group for the currently selected match
highlight CurrentSearchMatch ctermfg=Black ctermbg=Yellow
highlight CurrentSearchUnmatch ctermfg=None ctermbg=None

" Automatically highlight the current search match
"autocmd CursorMoved * call HighlightCurrentSearchMatch()

" Function to highlight the current search match
function! HighlightCurrentSearchMatch()
    match CurrentSearchMatch /\%#\v/
endfunction

function! HighlightCurrentSearchUnmatch()
    match CurrentSearchUnmatch /\%#\v/
endfunction
noremap <leader>s :noh<CR>:call HighlightCurrentSearchUnmatch()<CR>
noremap n n:call HighlightCurrentSearchMatch()<CR>

" Enable UltiSnips and set Tab key to trigger snippets
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'




augroup codeAutoWrap
  autocmd!
  autocmd FileType python,c,cpp,java,javascript,typescript,go,rust,sh
       \ setlocal linebreak      |
       \ setlocal breakindent    |
       \ let &l:showbreak=' + ' 
augroup END

augroup codeFolding
  autocmd!
  autocmd FileType python 
    \ setlocal foldmethod=indent | 
    \ setlocal formatoptions-=t | 
    \ setlocal textwidth=79
augroup END

" Custom mapping for <C-R> in Visual mode for MATLAB files
augroup matlabCustomMappings
	autocmd!
	autocmd FileType matlab vmap <C-R> :normal 0i% <CR>gv
	" Use MATLAB-like indentation
	"autocmd FileType matlab vmap <C-T> :if getline('.') =~# '\s*%\s' | s/\s*\zs%\s// | endif<CR>:noh<CR>gvh 

	autocmd FileType matlab vmap <C-T> :s/^\s*\zs%\s//<CR>:noh<CR>gvh 
	autocmd FileType matlab syn keyword matlabStatement continue break
	autocmd FileType matlab :set textwidth=75
	autocmd FileType matlab set path+=**
	let g:MATLAB_function_indent = 1
augroup END

augroup	latexCustomMappings
	autocmd!
	"Disables identLine plugging for tex files because it enables
	"concealing which in turn messes up latex equations in $$
	autocmd FileType tex let g:indentLine_enabled=0
	autocmd FileType tex set conceallevel=0
	autocmd FileType tex set textwidth=76
	" autocmd FileType tex setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
	" Define a custom text object for LaTeX environments
	autocmd FileType tex  onoremap <silent> ie :<C-U>call SelectLatexEnvironment(1)<CR>
	autocmd FileType tex  onoremap <silent> ae :<C-U>call SelectLatexEnvironment(0)<CR>
	autocmd FileType tex  xnoremap <silent> ie :<C-U>call SelectLatexEnvironment(1)<CR>
	autocmd FileType tex  xnoremap <silent> ae :<C-U>call SelectLatexEnvironment(0)<CR>

    autocmd FileType tex command! -nargs=1 Texvim call LatexSearchIgnoreNewlines(<q-args>)
augroup END
"
" Function to perform the search
function! LatexSearchIgnoreNewlines(input)
  " Replace spaces with \_s (matches any whitespace, including newlines)
  let pattern = substitute(a:input, '[ \r]\+', '\\_s\\+', 'g')
  " Execute the search command with the constructed pattern
  execute 'vim /' . pattern . '/ **/*.tex'
endfunction


function! SelectLatexEnvironment(offset)
    let start_line = search('\s*\\begin{\w\+}', 'bnW')
    let start_line_test = search('\s*\\end{\w\+}', 'bnW')
    if start_line == 0 || start_line<=start_line_test
        return 
    endif
    let end_line = search('\s*\\end{\w\+}', 'enW')
    let end_line_test = search('\s*\\begin{\w\+}', 'enW')
    if end_line == 0 || (end_line_test>0 && end_line>=end_line_test) 
    return 
    endif
    execute 'normal! ' . (start_line + a:offset) . 'GV' . (end_line - a:offset) . 'G'
endfunction
"
" Function to cycle through available colorschemes
function! CycleColorschemes(direction)
	" Get the current colorscheme name
	let current_scheme = g:colors_name

	" Get the list of all available colorschemes
	let available_schemes = getcompletion('', 'color')

	" Find the index of the current colorscheme in the list
	let current_index = index(available_schemes, current_scheme)

	" Calculate the index of the next colorscheme
	if a:direction =='next'
		let next_index = (current_index + 1) % len(available_schemes)
	elseif a:direction == 'prev'
		let next_index = (current_index - 1 + len(available_schemes)) % len(available_schemes)
	endif
	" Get the name of the next colorscheme
	let next_scheme = available_schemes[next_index]
	" Set the next colorscheme
	" setlocal lazyredraw
	execute 'colorscheme' next_scheme
	redraw
	echo g:colors_name
endfunction

" Map a key (e.g., F8) to cycle through colorschemes
nnoremap <F8> :call CycleColorschemes('next')<CR>
nnoremap <F7> :call CycleColorschemes('prev')<CR>


set expandtab tabstop=4 softtabstop=4 shiftwidth=4


"================= LSP Settings =================
let g:lsp_settings_filetype_python = ['basedpyright-langserver', 'ruff'] 

" Defer hover to Pyright, not Ruff

" let g:lsp_settings_filetype_python = ['basedpyright-langserver', 'pylsp-all'] 

" Disable all language servers by default
" let g:lsp_settings = {
" \   '*': {
" \     'disabled': 0,
" \   },
" \   'pylsp-all': {
" \     'disabled': 1,  
" \   }
" \}

let g:lsp_settings = {
\  'pylsp-all': {
\    'workspace_config': {
\      'pylsp': {
\        'plugins': {
\          'pycodestyle': { 'ignore': ['E501'] },
\        },
\      },
\    },
\  },
\}

" if executable('pylsp')
"     " pip install python-lsp-server
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pylsp',
"         \ 'cmd': {server_info->['pylsp']},
"         \ 'allowlist': ['python'],
"         \ 'workspace_config':{
"         \   'pylsp':{
"         \     'plugins':{
"         \       'pycodestyle': {'ignore':['E501']},
"         \     },
"         \   },
"         \ },
"         \ })
" endif
 


let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
" Disable messages showing within the main window
let g:lsp_diagnostics_virtual_text_enabled=0
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes

    let l:cap = lsp#get_server_capabilities('ruff')
    if !empty(l:cap)
      let l:cap.hoverProvider = v:false
    endif

    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    nnoremap <buffer> <expr><leader>d lsp#scroll(+4)
    nnoremap <buffer> <expr><leader>u lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
"================= LSP Settings (END) =================

" Show the differences compared to the file on disk
command! DiffSaved
  \ let s:ft = &l:filetype |
  \ vert new |
  \ read ++edit # |
  \ 0d_ |
  \ setlocal buftype=nowrite bufhidden=wipe noswapfile |
  \ execute 'setlocal filetype=' .. s:ft |
  \ diffthis |
  \ setlocal nocursorline |
  \ wincmd p |
  \ setlocal nocursorline |
  \ diffthis |
  \ wincmd p


augroup DiffNoCursorline
  autocmd!
  " When leaving diff mode, restore cursorline
  autocmd OptionSet diff if !&l:diff | setlocal cursorline | endif
augroup END



"================= Async complete setup =================
set completeopt=menu,noinsert
inoremap <silent> <leader><Tab> <C-x><C-o>
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
let g:asyncomplete_auto_popup = 0


function! s:ACRefresh() abort
  call asyncomplete#force_refresh()
  return ''
endfunction

inoremap <silent> <BS>  <BS><C-r>=<SID>ACRefresh()<CR>
inoremap <silent> <C-h> <BS><C-r>=<SID>ACRefresh()<CR>

function! s:AsynReopenAfterDelete() abort
  call timer_start(1, {-> feedkeys(asyncomplete#force_refresh(), 'm')})
  return ''
endfunction

inoremap <silent><expr> <BS>
      \ pumvisible()
      \ ? "\<BS>\<C-r>=<SID>AsynReopenAfterDelete()\<CR>"
      \ : "\<BS>"

inoremap <silent><expr> <C-h>
      \ pumvisible()
      \ ? "\<BS>\<C-r>=<SID>AsynReopenAfterDelete()\<CR>"
      \ : "\<BS>"

inoremap <silent><expr> <C-w>
      \ pumvisible()
      \ ? "\<C-w>\<C-r>=<SID>AsynReopenAfterDelete()\<CR>"
      \ : "\<C-w>"

"================= Async complete setup (END) =================
