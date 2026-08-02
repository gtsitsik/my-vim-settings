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

Plug 'puremourning/vimspector'
" Plug 'vim-latex/vim-latex'
call plug#end()


let s:cursor_style = "\e[2 q\e]12;#426963\x07"
let &t_ti.=s:cursor_style
let &t_SI.=s:cursor_style
let &t_EI.=s:cursor_style
" Keep the same cursor appearance after Vim exits.
let &t_te.=s:cursor_style


nmap <F6> :IndentLinesToggle<CR>
call togglebg#map("<F5>")
set foldmethod=syntax


set hlsearch
set number
set cursorline
set colorcolumn=+1

"set paste
set hidden " allows modified buffers to stay in the background
set confirm " provides actions when quitting a modified buffer
set showcmd " show normal commands as they are being typed, at the bottom right
set wildmenu " show selection menu when pressing tab to autocomplete in command-line mode
set incsearch " start searching immediately without pressing enter
set linebreak " visual wrapping wraps only entire words

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


inoremap <expr> <C-c> <SID>test_ctrl_c()
"
" Autocomplete matching pairs
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap ' ''<Left>
inoremap " ""<Left>
inoremap { {}<Left>
inoremap < <><Left>
inoremap [[ [
inoremap (( (
inoremap () ()
inoremap [] []
inoremap {} {}
inoremap <> <>
inoremap '' '
inoremap "" "
inoremap {{ {
inoremap << <
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
noremap <silent> <leader>s :noh<CR>:call HighlightCurrentSearchUnmatch()<CR>
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

augroup vimCustomMappings
	autocmd!
	autocmd FileType vim vmap <C-R> :normal 0i"" <CR>gv
	autocmd FileType vim vmap <C-T> :s/^\s*\zs"\s//<CR>:noh<CR>gvh 
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


augroup pythonCustomMappings
	autocmd!
	autocmd FileType python vmap <C-R> :normal 0i# <CR>gv

	autocmd FileType python vmap <C-T> :s/^\s*\zs#\s//<CR>:noh<CR>gvh 
augroup END

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


"================================================
"================= LSP Settings =================
"================================================

" FIXME: This is probably a messy solution and may cause unexpected issues.
" Some vim-lsp popup windows seem to close automatically after a set amount of
" time defined by the updatetime variable. Setting this variable to 0 solves
" the issue, but since it is involved in other operations it is probably
" better to leave it unchanged. Removing the CursorHold event from vim-lsp
" definitions seems to solve the issue.
function! RemoveVimLspCursorHold() abort
    let l:acs = autocmd_get({'event': 'CursorHold'})

    for l:ac in l:acs
        if l:ac.group =~# '^__callbag_fromEvent_prefix_\d\+__$'
            call autocmd_delete([{
                \ 'group': l:ac.group,
                \ 'event': 'CursorHold',
                \ 'pattern': l:ac.pattern,
                \ }])
        endif
    endfor
endfunction
augroup my_lsp_cleanup
    autocmd!
    autocmd User lsp_buffer_enabled call RemoveVimLspCursorHold()
augroup END




let g:lsp_settings_filetype_python = ['basedpyright-langserver', 'ruff'] 
" let g:lsp_settings_filetype_python = ['jedi-language-server', 'ruff'] 


" let g:lsp_settings_filetype_python = ['basedpyright-langserver', 'pylsp-all'] 



"================ Improve documentation popup formatting. ================
function! s:python_plaintext_lsp_capabilities(server_info) abort
  let l:cap = lsp#default_get_supported_capabilities(a:server_info)
  let l:name = get(a:server_info, 'name', '')

  " Apply only to Python language servers, especially basedpyright/pyright/jedi.
  if l:name =~# '\v(basedpyright|pyright|jedi)'
    " Hover: :LspHover
    let l:cap.textDocument.hover.contentFormat = ['plaintext']
  endif

  return l:cap
endfunction

let g:lsp_get_supported_capabilities = [function('s:python_plaintext_lsp_capabilities')]

" Then color hover popup as Python
augroup lsp_hover_python_syntax
  autocmd!
  autocmd User lsp_float_opened call s:lsp_hover_python_syntax()
  autocmd User lsp_float_opened call timer_start(1, {-> s:lsp_hover_python_syntax()})
augroup END

function! s:lsp_hover_python_syntax() abort
  let l:winid = lsp#document_hover_preview_winid()
  if l:winid <= 0
    return
  endif

  let l:bufnr = winbufnr(l:winid)

  call setbufvar(l:bufnr, '&syntax', 'python')
endfunction
"=========================================================================


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
 

augroup lsp_preview_formatting
  autocmd!
  autocmd FileType markdown setlocal conceallevel=0
  autocmd FileType markdown setlocal tabstop=4 shiftwidth=4
  autocmd FileType markdown setlocal wrap linebreak breakindent
augroup END
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 0

" Disable messages showing within the main window
let g:lsp_diagnostics_virtual_text_enabled = 0

" Keep floating windows bigger when vim window is not wide enough
let g:lsp_float_max_width = 90


" Prevent vim-lsp from taking over <C-c>.
 nmap <silent><buffer> <Plug>(MyLspFloatCloseGuard) <Plug>(lsp-float-close)

" FIXME: This may be too broad and may have unexpected side effects 
" Diagnostic messages do not close using <C-c> by default
" nnoremap <silent> <C-c> :call popup_clear()<CR><C-c>
nnoremap <expr><buffer> <C-c> popup_list()->empty() ? "\<C-c>" : "\<Cmd> call popup_clear()\<CR>"


function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes

" Defer hover to Pyright, not Ruff
    if &filetype ==# 'python'
        let l:cap = lsp#get_server_capabilities('ruff')
        if !empty(l:cap)
          let l:cap.hoverProvider = v:false
        endif
    endif

    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gD <plug>(lsp-document-diagnostics)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> <leader>gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> <C-k> <plug>(lsp-hover-preview)
    nmap <buffer> <leader>ca <plug>(lsp-code-action)
    nnoremap <buffer> <leader>b <Cmd>silent w \| LspDocumentBuild<CR>
    nnoremap <buffer> <leader>B <Cmd>silent w \| LspDocumentBuildCurrent <CR>
    nnoremap <buffer> <leader>v <Cmd>call ToggleLspVirtualText()<CR>

    " When popup exists, scroll within the popup instead of the buffer itself
    nnoremap <expr><buffer> <C-e> popup_list()->empty() ? "\<C-e>" : lsp#scroll(1)
    nnoremap <expr><buffer> <C-y> popup_list()->empty() ? "\<C-y>" : lsp#scroll(-1)
    nnoremap <expr><buffer> <C-d> popup_list()->empty() ? "\<C-d>" : lsp#scroll(10)
    nnoremap <expr><buffer> <C-u> popup_list()->empty() ? "\<C-u>" : lsp#scroll(-10)

    inoremap <expr> <C-c> pumvisible() ? "\<C-e>" : "\<C-c>"
    
    " Insert mode: autocomplete popup/menu
    inoremap <expr><buffer> <C-e> popup_list()->empty() ? "\<C-e>" : lsp#scroll(1)
    inoremap <expr><buffer> <C-y> popup_list()->empty() ? "\<C-y>" : lsp#scroll(-1)
    inoremap <expr><buffer> <C-d> popup_list()->empty() ? "\<C-d>" : lsp#scroll(10)
    inoremap <expr><buffer> <C-u> popup_list()->empty() ? "\<C-u>" : lsp#scroll(-10)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
   
    " TODO: make a pull request to add this functionality. The need for
    " InsertLeave should also probably be mitigated in the final
    " implementation
"     function! ToggleLspVirtualText()
"         if g:lsp_diagnostics_virtual_text_enabled
"             let g:lsp_diagnostics_virtual_text_enabled = 0
"             call lsp#internal#diagnostics#virtual_text#_disable()
"         else
"             let g:lsp_diagnostics_virtual_text_enabled = 1
"             call lsp#internal#diagnostics#virtual_text#_enable()
"             call lsp#internal#diagnostics#state#_force_notify_buffer(bufnr('%'))
"             " doautocmd <nomodeline> InsertLeave
"         endif
"     endfunction

    function! ToggleLspVirtualText()
        if g:lsp_diagnostics_virtual_text_enabled
            call lsp#disable_diagnostics_virtual_text()
        else
            call lsp#enable_diagnostics_virtual_text()
        endif
    endfunction

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
"================================================
"============== LSP Settings (END) ==============
"================================================




" Show the differences compared to the file on disk
command! DiffSaved
  \ let s:ft = &l:filetype |
  \ vert new |
  \ read ++edit # |
  \ 0d_ |
  \ setlocal buftype=nofile bufhidden=wipe noswapfile |
  \ execute 'setlocal filetype=' .. s:ft |
  \ diffthis |
  \ setlocal nocursorline |
  \ wincmd p |
  \ setlocal nocursorline |
  \ diffthis |
  \ wincmd p

nnoremap <leader>d :DiffSaved<cr>


augroup DiffNoCursorline
  autocmd!
  " When leaving diff mode, restore cursorline
  autocmd OptionSet diff if !&l:diff | setlocal cursorline | endif
augroup END



"================= Async complete setup =================
let g:asyncomplete_matchfuzzy = 0
set completeopt=menu,noinsert
inoremap <silent> <leader><Tab> <cmd>call <SID>AsynReopenAfterDelete()<cr>
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Select current completion and close popup
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
let g:asyncomplete_auto_popup = 0




function! s:ToggleAsyncompleteFuzzy() abort
  let g:asyncomplete_matchfuzzy = !get(g:, 'asyncomplete_matchfuzzy', exists('*matchfuzzypos'))

  if g:asyncomplete_matchfuzzy
    echo 'asyncomplete fuzzy matching: ON'
  else
    echo 'asyncomplete fuzzy matching: OFF'
  endif

  if mode() ==# 'i'
    call <SID>AsynReopenAfterDelete()
  endif
endfunction

nnoremap <leader>fz <Cmd>call <SID>ToggleAsyncompleteFuzzy()<CR>
inoremap <leader>fz <Cmd>call <SID>ToggleAsyncompleteFuzzy()<CR>









" let s:asyncomplete_reopen_timer = -1
" 
" function! s:ScheduleAsyncReopenAfterTyping() abort
"   if mode() !=# 'i'
"     return
"   endif
" 
"   if !pumvisible()
"     return
"   endif
" 
"   if s:asyncomplete_reopen_timer != -1
"     call timer_stop(s:asyncomplete_reopen_timer)
"   endif
" 
"   let s:asyncomplete_reopen_timer =
"         \ timer_start(20, {-> s:DoAsyncReopenAfterTyping()})
" endfunction
" 
" function! s:DoAsyncReopenAfterTyping() abort
"   let s:asyncomplete_reopen_timer = -1
" 
"   if mode() ==# 'i' && pumvisible()
"     call feedkeys(asyncomplete#force_refresh(), 'm')
"   endif
" endfunction
" 
" augroup asyncomplete_reopen_while_typing
"   autocmd!
"   autocmd TextChangedP * call s:ScheduleAsyncReopenAfterTyping()
" augroup END




let s:asyncomplete_reopen_timer = -1

function! s:ScheduleAsyncReopenForTypedChar() abort
  " Only while autocomplete popup menu is visible.
  if !pumvisible()
    return
  endif

  " Do not trigger for Tab / Enter-like characters.
  if v:char ==# "\t" || v:char ==# "\r" || v:char ==# "\n"
    return
  endif

  " Ignore other control characters.
  if strlen(v:char) == 1 && char2nr(v:char) < 32
    return
  endif

  if s:asyncomplete_reopen_timer != -1
    call timer_stop(s:asyncomplete_reopen_timer)
  endif

  let s:asyncomplete_reopen_timer =
        \ timer_start(20, {-> s:DoAsyncReopenAfterTyping()})
endfunction

function! s:DoAsyncReopenAfterTyping() abort
  let s:asyncomplete_reopen_timer = -1

  if mode() ==# 'i' && pumvisible()
    call feedkeys(asyncomplete#force_refresh(), 'm')
  endif
endfunction

augroup asyncomplete_reopen_while_typing
  autocmd!
  autocmd InsertCharPre * call s:ScheduleAsyncReopenForTypedChar()
augroup END



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
      \ : "\<BS>

inoremap <silent><expr> <C-w>
      \ pumvisible()
      \ ? "\<C-w>\<C-r>=<SID>AsynReopenAfterDelete()\<CR>"
      \ : "\<C-w>"

"================= Async complete setup (END) =================


"================= QuickFix list autojump =================
augroup QuickFix
 au FileType qf nnoremap <buffer> <silent> j :set eventignore+=BufEnter,FocusGained,InsertLeave,WinEnter<cr> j<cr>zzzv :set eventignore-=BufEnter,FocusGained,InsertLeave,WinEnter<cr> <c-w>p 
 au FileType qf nnoremap <buffer> <silent> k :set eventignore+=BufEnter,FocusGained,InsertLeave,WinEnter<cr> k<cr>zzzv :set eventignore-=BufEnter,FocusGained,InsertLeave,WinEnter<cr> <c-w>p 
augroup END
"================= QuickFix list autojump (END) =================



let g:codex_buf = -1

function! CodexOpen()
    " Codex buffer doesn't exist anymore: start a new one.
    if g:codex_buf == -1 || !bufexists(g:codex_buf)
        topleft vertical terminal codex
        execute 'vertical resize ' . (&columns / 4)
        let g:codex_buf = bufnr('%')
        wincmd p
        return
    endif

    " Codex exists and is already visible.
    if bufwinid(g:codex_buf) != -1
        return
    endif

    " Codex exists but is hidden: show the existing terminal buffer.
    execute 'vertical sbuffer ' . g:codex_buf
    wincmd p
endfunction


function! CodexHide()
    if g:codex_buf == -1 || !bufexists(g:codex_buf)
        return
    endif

    let winid = bufwinid(g:codex_buf)

    if winid != -1
        call win_execute(winid, 'hide')
    endif
endfunction

function! CodexAsk() abort
    " Start/show Codex if necessary.
    if g:codex_buf == -1
                \ || !bufexists(g:codex_buf)
                \ || bufwinid(g:codex_buf) == -1
        call CodexOpen()
    endif

    " Make sure we're back in Normal mode in the editing window.
    stopinsert

    let question = input('Codex: ')

    if empty(question)
        return
    endif

    let file = expand('%:p')
    let lineno = line('.')
    let column = col('.')
    let word = expand('<cword>')

    let prompt = printf(
        \ "I'm referring to %s:%d:%d, with my cursor on `%s`. %s",
        \ file,
        \ lineno,
        \ column,
        \ word,
        \ question
        \ )

    call term_sendkeys(g:codex_buf, prompt)
    call timer_start(100, {-> term_sendkeys(g:codex_buf, "\<CR>")})
endfunction

command! CodexOpen call CodexOpen()
command! CodexHide call CodexHide()
command! CodexAsk  call CodexAsk()

augroup CodexResize
    autocmd!
    autocmd VimResized * call CodexResize()
augroup END

function! CodexResize()
    if g:codex_buf == -1 || !bufexists(g:codex_buf)
        return
    endif

    let winid = bufwinid(g:codex_buf)

    if winid != -1
        call win_execute(
            \ winid,
            \ 'vertical resize ' . (&columns / 4)
            \ )
    endif
endfunction

function! CodexFixLayout() abort
    if g:codex_buf == -1 || !bufexists(g:codex_buf)
        return
    endif

    let l:winid = bufwinid(g:codex_buf)

    " Codex is currently hidden.
    if l:winid == -1
        return
    endif

    " Force Codex to be the outermost full-height left window.
    call win_execute(l:winid, 'wincmd H')

    " Keep it at one quarter of Vim's total width.
    call win_execute(
        \ l:winid,
        \ 'vertical resize ' . (&columns / 4)
        \ )
endfunction

augroup CodexLayout
    autocmd!
    autocmd WinNew * call timer_start(0, {-> CodexFixLayout()})
    autocmd VimResized * call CodexFixLayout()
augroup END


nnoremap <leader>] :VimCodexMcpAsk<CR>
nnoremap <leader>[ :VimCodexMcpToggle<CR>

set runtimepath^=/home/gtsitsikas/tmp/vim_codex/vim


nmap ]a <Plug>(VimCodexMcpNextMessage)
nmap [a <Plug>(VimCodexMcpPreviousMessage)


nnoremap <leader>t :UndotreeToggle<CR>:UndotreeFocus<CR>
