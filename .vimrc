""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/home/janosch/.vim/bundle/Vundle.vim " so that root sees it
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ycm-core/YouCompleteMe'
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe configuration.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Close YCMs preview window automatically.
" See https://vi.stackexchange.com/questions/4056/is-there-an-easy-way-to-close-a-scratch-buffer-preview-window
let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_autoclose_preview_window_after_completion = 1

" Shortcuts.
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Turn on YouCompleteMe only for specific file types.
let g:ycm_filetype_whitelist = {
			\ 'c': 1,
			\ 'cpp': 1,
			\ 'python': 1
			\}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Proven customizations of core features that I understand (kind of).
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight search term.
set hlsearch

" Use Ctrl+C instead of escape, and also trigger InsertLeave event.
ino <C-C> <Esc>

" clear highlighting on escape and Ctrl-C in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
nnoremap <C-C> :noh<return><C-C>
nnoremap <C-C>^[ <C-C>^[

" put backup files (~) in tmp-file
set backupdir=~/.vim/tmp//

" do not continue comments on next line automatically
"autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" keep 1 line below and above the cursor
set scrolloff=1

" assembler file type
autocmd BufRead,BufNewFile *.asm set filetype=nasm
autocmd BufRead,BufNewFile *.asm set ai

" Use ron color scheme, also when using screen.
colorscheme ron

" Hide buffers instead of closing them.
" Allows to open a new file when the current buffer has unsafed changes.
set hidden

" Let 'n' always search forward and 'N' always search backwards.
nnoremap <expr> n (v:searchforward ? 'n' : 'N')
nnoremap <expr> N (v:searchforward ? 'N' : 'n')

" Set the size of the netrw file explorer.
let g:netrw_winsize = 25

" Swap Ctrl-] (which I never want) and g_Ctrl-].
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>

nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>

" Set and configure line numbers.
" See: https://vim.fandom.com/wiki/Display_line_numbers
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set relativenumber


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stuff that I don't understand and just copy-pasted.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" How to Do 90% of What Plugins Do:
" https://www.youtube.com/watch?v=XA2WjJbmmoM
" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer

"" Enumerate tabs. See: https://stackoverflow.com/questions/11366390/how-to-enumerate-tabs-in-vim
fu! MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	let string = fnamemodify(bufname(buflist[winnr - 1]), ':t')
	return empty(string) ? '[unnamed]' : string
endfu

fu! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		" select the highlighting
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif

		" set the tab page number (for mouse clicks)
		"let s .= '%' . (i + 1) . 'T'
		" display tabnumber (for use with <count>gt, etc)
		let s .= ' '. (i+1) . ' ' 

		" the label is made by MyTabLabel()
		let s .= ' %{MyTabLabel(' . (i + 1) . ')} '

		if i+1 < tabpagenr('$')
			let s .= ' |'
		endif
	endfor
	return s
endfu
set tabline=%!MyTabLine()

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"augroup ProjectDrawer
"	  autocmd!
"	    autocmd VimEnter * :Vexplore
"	augroup END

" Color of tab bar.
" See: https://stackoverflow.com/questions/7238113/customising-the-colours-of-vims-tab-bar
hi TabLineFill ctermfg=DarkGray ctermbg=LightGray

