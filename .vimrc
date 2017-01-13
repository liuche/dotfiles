""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible | filetype indent plugin on | syn on

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Show trailing whitespace.
set listchars=tab:>-,trail:·,eol:$

" Humane tab settings.
set shiftwidth=2
set tabstop=2
set expandtab

set backspace=indent,eol,start " allow backspacing over everything in insert mode.
set foldmethod=indent          " folds determined by indent level
set hidden                     " allow backgrounding of buffers.
set history=1000               " keep 100 lines of command line history
set incsearch		               " do incremental searching
set mouse=a                    " Enable use of mouse
set nobackup		               " don't keep a backup file on overwrite
set nofoldenable               " have folds open by default
set nu                         " line numbers on
set ruler		                   " show the line/position of cursor all the time
set showcmd		                 " display incomplete commands
set showmatch                  " show matching brackets  		
set so=3		                   " search context lines
set tags+=tags;/               " use ctags from upstream directories
set visualbell

" Use ack. See http://petdance.com/ack/
set grepprg=/usr/local/bin/ack

" Mac clipboard.
set clipboard=unnamed

" Autocompletion.
set wildmenu
set wildmode=list:longest,full

" Don't autocomplete FASLs, either.
set wildignore=*.o,*.obj,*.fasl,*.dfsl,*~
set suffixes=.back,~,.o,.h,.info,.swp,.obj,.fasl,.dfsl

" Always display a status line.
set laststatus=2
set statusline=%f\ %y%00(\ %m%*%)%00(\ %r%*%)%00(\ %h%w%)\ %36(\ L:\ %l\/%L,\ C:\ %c\ [0x%B]\ Buf\ %n%)

" Color scheme.
if ! has("gui_running")
  set t_Co=256
endif
set background=dark

set t_Co=256
"Configure the Solarized colorscheme -- really good contrast
" let g:solarized_termtrans  = 1
let g:solarized_termcolors = 256
let g:solarized_contrast   = "high"
let g:solarized_visibility = "high"
colorscheme solarized
" colors peaksea

" == Mappings ===============================================================
" NERDTree mappings
let g:explVertical=1	" Split vertically
let g:explSplitRight=1    " Put new window to the right of the explorer
noremap <silent> <CR> :noh<CR><CR>

" In visual mode, hit * to search on the current selection.
vmap * :<C-U>let old_reg=@"<CR>gvy/<C-R><C-R>=substitute(escape(@",'\\/.*$^~[]'),"\\n$","","")<CR><CR>:let @"=old_reg<CR>

" Syntax highlighting for other filetypes.
au BufNewFile,BufRead *.jsm set filetype=javascript

" Use Home and End to jump between buffers.
" TODO remap something to jump between buffers
" nmap <silent> <Home> :winc k<CR><CR>
" nmap <silent> <End> :winc j<CR><CR>
" imap <silent> <Home> :winc k<CR><CR>
" imap <silent> <End> :winc j<CR><CR>
" TODO <wut>
" Map searching for unmatched parentheses.
map [9 [(
map [0 [)

" Maths.
" Full current line, answer below:
" nnoremap <Leader>ma yyp^y$V:!perl -e '$x = <C-R>"; print $x'<CR>-y0j0P 

" Visual:
" vnoremap <Leader>ma yo<ESC>p^y$V:!perl -e '$x = <C-R>"; print $x'<CR>-y0j0P 

" Current replace:
" nnoremap <Leader>mr ^"gy0^y$V:!perl -e '$x = <C-R>"; print $x'<CR>^"gP 

" Visual replace:
" vnoremap <Leader>mr "aygvrXgv"by:r !perl -e '$x = <C-R>a; print $x'<CR>0"cyWddk:s/<C-R>b/<C-R>c/<CR> 

" So you can hit C-k on a line, and it'll remove useless whitespace beneath.
noremap <silent> <C-j> :call AddEmptyLineBelow()<CR> 
noremap <silent> <C-k> :call DelEmptyLineBelow()<CR> 
noremap <silent> <C-i> :call DelEmptyLineAbove()<CR> 
noremap <silent> <C-o> :call AddEmptyLineAbove()<CR> 

" Abbreviations.
cabbrev tn tabnew
" cabbrev NT NERDTree
cabbrev vsb vert sb

" == Plugins =================================================================
" Plugins for VAM to install
" VAM cron-maintained list at:
" https://raw.github.com/MarcWeber/vim-addon-manager-known-repositories/master/db/vimorgsources.json 
let plugin_names = ['ctrlp', 'ack', 'Solarized', 'jshint2']
" Supertab, The_NERD_tree

" --- CtrlP options --- 
" Change default mapping and default command to invoke CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Set CtrlP starting directory to the nearest ancestor .<repo> directory or
" current directory if no ancestor found.
let g:ctrlp_working_path_mode = 'ra'

" Root markers. To set, 'touch .ctrlp' in the directory to mark.
let g:ctrlp_root_markers = ['.ctrlp']

" CtrlP custom ignore
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"   \ 'file': '\v\.(exe|so|dll)$',
"   \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
"   \ }

" :help ctrlp-options for more options
" --------------------

" Set up VAM
fun! EnsureVamIsOnDisk(plugin_root_dir)
" windows users may want to use http://mawercer.de/~marc/vam/index.php
" to fetch VAM, VAM-known-repositories and the listed plugins
" without having to install curl, 7-zip and git tools first
" -> BUG [4] (git-less installation)
let vam_autoload_dir = a:plugin_root_dir.'/vim-addon-manager/autoload'
if isdirectory(vam_autoload_dir)
return 1
else
if 1 == confirm("Clone VAM into ".a:plugin_root_dir."?","&Y\n&N")
" I'm sorry having to add this reminder. Eventually it'll pay off.
call confirm("Remind yourself that most plugins ship with ".
\"documentation (README*, doc/*.txt). It is your ".
\"first source of knowledge. If you can't find ".
\"the info you're looking for in reasonable ".
\"time ask maintainers to improve documentation")
call mkdir(a:plugin_root_dir, 'p')
execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.
\ shellescape(a:plugin_root_dir, 1).'/vim-addon-manager'
" VAM runs helptags automatically when you install or update
" plugins
exec 'helptags '.fnameescape(a:plugin_root_dir.'/vim-addon-manager/doc')
endif
return isdirectory(vam_autoload_dir)
endif
endfun
fun! SetupVAM(plugins_list)
" Set advanced options like this:
" let g:vim_addon_manager = {}
" let g:vim_addon_manager.key = value
" Pipe all output into a buffer which gets written to disk
" let g:vim_addon_manager.log_to_buf =1
" Example: drop git sources unless git is in PATH. Same plugins can
" be installed from www.vim.org. Lookup MergeSources to get more control
" let g:vim_addon_manager.drop_git_sources = !executable('git')
" let g:vim_addon_manager.debug_activation = 1
" VAM install location:
let c = get(g:, 'vim_addon_manager', {})
let g:vim_addon_manager = c
let c.plugin_root_dir = expand('$HOME/.vim/vim-addons', 1)
if !EnsureVamIsOnDisk(c.plugin_root_dir)
echohl ErrorMsg | echomsg "No VAM found!" | echohl NONE
return
endif
let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
" Tell VAM which plugins to fetch & load:
call vam#ActivateAddons(a:plugins_list, {'auto_install' : 0})
" sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
" Also See "plugins-per-line" below
" Addons are put into plugin_root_dir/plugin-name directory
" unless those directories exist. Then they are activated.
" Activating means adding addon dirs to rtp and do some additional
" magic
" How to find addon names?
" - look up source from pool
" - (<c-x><c-p> complete plugin names):
" You can use name rewritings to point to sources:
" ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
" ..ActivateAddons(["github:user/repo", .. => github://user/repo
" Also see section "2.2. names of addons and addon sources" in VAM's documentation
endfun
call SetupVAM(plugin_names)
" experimental [E1]: load plugins lazily depending on filetype, See
" NOTES
" experimental [E2]: run after gui has been started (gvim) [3]
" option1: au VimEnter * call SetupVAM()
" option2: au GUIEnter * call SetupVAM()
" See BUGS sections below [*]
" Vim 7.0 users see BUGS section [3]

" source ~/.vim/plugins/repeat.vim
" source ~/.vim/plugins/grep.vim
" source ~/.vim/plugins/csspretty.vim
" source ~/.vim/plugins/xmlpretty.vim
" source ~/.vim/plugins/fugitive.vim

" NERDTree only works on Vim 7 and up.
" if version > 700
"   source ~/.vim/plugin/NERD_tree.vim
"   let NERDTreeIgnore=['\~$', '\.pyc$']
" endif

" taglist-plus options.
" let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

" let treeExplVertical=1

" == Functions & Macros ===================================================

" Trailing whitespace for JS.
function TrimWhiteSpace()
  %s/\s\+$//
  ''
endfunction

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

nmap <silent>  ;=  :call AlignAssignments()<CR>
function AlignAssignments ()
    "Patterns needed to locate assignment operators...
    let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
    let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)'

    "Locate block of code to be considered (same indentation, no blanks)
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif

    "Find the column at which the operators should be aligned...
    let max_align_col = 0
    let max_op_width  = 0
    for linetext in getline(firstline, lastline)
        "Does this line have an assignment in it?
        let left_width = match(linetext, '\s*' . ASSIGN_OP)

        "If so, track the maximal assignment column and operator width...
        if left_width >= 0
            let max_align_col = max([max_align_col, left_width])

            let op_width      = strlen(matchstr(linetext, ASSIGN_OP))
            let max_op_width  = max([max_op_width, op_width+1])
         endif
    endfor

    "Code needed to reformat lines so as to align operators...
    let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1),
    \                                    max_op_width,  submatch(2))'

    " Reformat lines with operators aligned in the appropriate column...
    for linenum in range(firstline, lastline)
        let oldline = getline(linenum)
        let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
        call setline(linenum, newline)
    endfor
endfunction

" Removing blank lines.
function! AddEmptyLineBelow() 
  call append(line("."), "") 
endfunction

function! AddEmptyLineAbove() 
    let l:scrolloffsave = &scrolloff 
    " Avoid jerky scrolling with ^E at top 
    " of window 
    set scrolloff=0 
    call append(line(".") - 1, "") 
    if winline() != winheight(0) 
        silent normal!  
    end 
    let &scrolloff = l:scrolloffsave 
endfunction

function! DelEmptyLineBelow() 
    if line(".") == line("$") 
        return 
    end 
    let l:line = getline(line(".") + 1) 
    if l:line =~ '^\s*$' 
        let l:colsave = col(".") 
        .+1d 
        '' 
        call cursor(line("."), l:colsave) 
    end 
endfunction

function! DelEmptyLineAbove() 
    if line(".") == 1 
        return 
    end 
    let l:line = getline(line(".") - 1) 
    if l:line =~ '^\s*$' 
        let l:colsave = col(".") 
        .-1d 
        silent normal!  
        call cursor(line("."), l:colsave) 
    end 
endfunction

" == Autocmd ===============================================================
" only do this part when compiled with support for autocommands.
if has("autocmd")

  " enable file type detection.
  " use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in c files, etc.
  " also load indent files, to automatically do language-dependent indenting.
  filetype indent plugin on

  " put these in an autocmd group, so that we can delete them easily.
  augroup vimrcex
  au!

  " for all text files set 'textwidth' to 78 characters.
  autocmd filetype text setlocal textwidth=78

  autocmd filetype lisp set lisp
  autocmd filetype scm  set lisp
  
  " sparql syntax highlighting.
  autocmd bufread,bufnewfile *.rq      set syntax=sparql
  autocmd bufread,bufnewfile *.sparql  set syntax=sparql
  autocmd bufread,bufnewfile *.lisp    set syntax=lisp
  
  " for python.
"  autocmd filetype python set ts=4 sw=4 sta et sts ai

  " for markdown.
  autocmd bufread *.mkd set syntax=mkd
  
  " for remind.
  autocmd bufread *.remind set syntax=remind

  " when editing a file, always jump to the last known cursor position.
  " don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd bufreadpost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup end

else
  set autoindent		" always set autoindenting on
endif " has("autocmd")


" Things to maybe keep
" Don't use Ex mode, use Q for formatting
" map Q gq

" == Things to Read Through and Figure Out Wtf They Do =====================
nmap \m i\\code{<ESC>ea}<ESC>

nmap <C-j> :cn<CR>
nmap <C-k> :bn<CR>

" ConquTerm options.
" let g:ConqueTerm_CWInsert = 1
" let g:ConqueTerm_TERM = 'xterm'
" let g:ConqueTerm_Syntax = 'conque'
" let g:ConqueTerm_ReadUnfocused = 1
" let g:ConqueTerm_CloseOnEnd = 1
" let g:ConqueTerm_PyVersion = 3


" TODO: l9
