{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      darcula
      lightline-vim
      vim-fakeclip
      fzf-vim
      unite-vim
      vimfiler
      vim-matchup
      tcomment_vim
      vim-abolish
      vim-surround
      copilot-vim
      eskk-vim
      dicwin-vim
      editorconfig-vim
      urilib-vim
      open-browser-vim
      vim-qfreplace
      previm
      vim-markdown
      typescript-vim
      vim-jsx-typescript
      vim-toml
      emmet-vim
      webapi-vim
      gist-vim
      vim-ai
      hz-ja_vim
      vim-lsp
      vim-lsp-settings
      vim-lsp-icons
      asyncomplete-vim
      asyncomplete-lsp
    ];
    extraConfig = ''
      " Keymap settings
      " Japanese keyboard compatibility mapping
      nnoremap ( *
      nnoremap ! ~
      nnoremap & ^
      vnoremap ( *
      vnoremap ! ~
      vnoremap & ^

      " Swap semicolon and colon keybindings
      nnoremap ; :
      nnoremap : ;
      vnoremap ; :
      vnoremap : ;

      " Delete with backspace in visual mode
      vnoremap <BS> d

      " Windows-style clipboard operations
      vnoremap <C-X> "+x
      vnoremap <C-C> "+y

      " Paste with Ctrl+V (supports each mode)
      map <C-V> "+gP
      cmap <C-V> <C-R>+
      exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
      exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

      " Save file with Ctrl+S
      noremap <C-S> :update<CR>
      vnoremap <C-S> <C-C>:update<CR>
      inoremap <C-S> <C-O>:update<CR>

      " Improved Redo operation
      nnoremap <silent> U <C-R>

      " Undo with Ctrl+Z
      noremap <C-Z> u
      inoremap <C-Z> <C-O>u

      " Select all with Ctrl+A (supports each mode)
      noremap <C-A> gggH<C-O>G
      inoremap <C-A> <C-O>gg<C-O>gH<C-O>G

      " Improved pasting when text is selected
      " Paste from register 0 (not affected by deleted content)
      nnoremap P "0P

      " History navigation commands
      nnoremap <silent> H <C-O>
      nnoremap <silent> L <C-I>

      " Alternative to the ESC key
      inoremap <silent> jj <ESC>

      " Simplified rectangular selection
      nnoremap <silent> vv <C-V>

      " Format the entire file
      nnoremap == ggvG$=<C-O><C-O>

      " Skip the following settings when using VSCode
      if exists('g:vscode')
        finish
      endif

      " Screen splitting operations
      noremap _ :split<CR><C-W>w
      noremap <BAR> :vsplit<CR><C-W>w

      " Window switching
      noremap <TAB> <C-W>w
      onoremap <TAB> <C-C><C-W>w

      " Buffer navigation
      noremap gb :bnext<CR>
      noremap gB :bprev<CR>

      " Tab operations
      noremap gn :tabnew<CR>

      " Window resizing
      noremap <S-LEFT> <C-W><
      noremap <S-RIGHT> <C-W>>
      noremap <S-DOWN> <C-W>+
      noremap <S-UP> <C-W>-

      " Basic settings
      scriptencoding utf-8
      set clipboard=unnamed
      set inccommand=split

      let g:mapleader = "\<space>"

      set termguicolors
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

      highlight Terminal guibg=#2a2a2a
      highlight Terminal guifg=#bbbbbb

      let g:terminal_ansi_colors = [
            \ '#000000',
            \ '#fd6b67',
            \ '#097e00',
            \ '#ccca00',
            \ '#5496ef',
            \ '#fd75ff',
            \ '#39cbcc',
            \ '#bbbbbb',
            \ '#676767',
            \ '#fd8784',
            \ '#73f961',
            \ '#fefb00',
            \ '#7eaff4',
            \ '#fd9cff',
            \ '#6ed9d9',
            \ '#f1f1f1',
            \ ]

      set ambiwidth=single
      set autoindent
      set autowrite
      set cursorline
      set encoding=utf-8
      set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,japan
      set fileformats=unix,dos,mac
      set formatoptions+=mMj
      set hlsearch
      set ignorecase
      set iminsert=0
      set imsearch=-1
      set incsearch
      set laststatus=2
      set mouse=a
      set nofoldenable
      set nolist
      set noshowmode
      set noswapfile
      set nowrap
      set number
      set ruler
      set shiftwidth=4
      set showcmd
      set smartindent
      set splitbelow
      set tabstop=4
      set vb t_vb=
      set virtualedit=all

      if executable('rg')
        set grepprg=rg\ --vimgrep
        set grepformat=%f:%l:%c:%m,%f:%l:%m
      endif

      set statusline=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
      set statusline+=%=%l:%c

      augroup cursorLine
        autocmd!
        autocmd WinLeave * set nocursorline
        autocmd WinEnter,BufRead * set cursorline
      augroup END

      filetype plugin indent on

      augroup fileTypeIndent
        autocmd!
        autocmd BufNewFile,BufRead *.txt,*.md setlocal wrap expandtab
        autocmd BufNewFile,BufRead *.json,*.md,*.html,*.css,*.ts,*.js,*vimrc* setlocal tabstop=2 shiftwidth=2
        autocmd BufNewFile,BufRead *.ts,*.js setlocal cindent expandtab shiftround
        autocmd BufNewFile,BufRead *.rules set filetype=javascript
        autocmd BufNewFile,BufRead *.mdc set filetype=markdown
      augroup END

      augroup fileTypeBinary
        autocmd!
        autocmd BufReadPre *.bin let &bin=1
        autocmd BufReadPost *.bin if &bin | %!xxd
        autocmd BufReadPost *.bin set ft=xxd | endif
        autocmd BufWritePre *.bin if &bin | %!xxd -r
        autocmd BufWritePre *.bin endif
        autocmd BufWritePost *.bin if &bin | %!xxd
        autocmd BufWritePost *.bin set nomod | endif
      augroup END

      autocmd VimEnter * if argc() == 0 | startinsert | endif
      autocmd BufEnter * if isdirectory(expand('%:p:h')) | lcd %:p:h | endif
      autocmd QuickfixCmdPost make,grep,vimgrep copen

      inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
      inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
      nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

      if has('win32') || has('win64')
        noremap <silent> <leader>t :terminal ++close ++curwin ubuntu<CR>
      else
        noremap <silent> <leader>t :terminal<CR>
      endif

      tnoremap <silent> <C-l> <C-W>N
      tnoremap <silent> <C-n> <DOWN>
      tnoremap <silent> <C-p> <UP>
      nnoremap <leader>r "zyiw:let @/ = @z<CR>:set hlsearch<CR>:%s/<C-r>///g<Left><Left>
      vnoremap <leader>r "zy:let @/ = @z<CR>:set hlsearch<CR>:%s/<C-r>///g<Left><Left>
      vnoremap <leader>R :s///g<Left><Left><Left>
      nnoremap <silent> <leader>c :call setline(".",eval(getline(".")))<CR>
      vnoremap <silent> <leader>c :!awk '{sum += $1} END {print sum}'<CR>
      vnoremap <silent> <leader>n :s/^/\=printf("%d", line(".") - line("'<") + 1)/<CR>
      noremap <silent> <leader>wb :set wrap<CR>
      noremap <silent> <leader>ww :set nowrap<CR>
      nnoremap <silent> <leader>utf :set ff=unix<CR>:set fileencoding=utf-8<CR>:set fenc=utf-8 bomb<CR>
      nnoremap <silent> <leader>* "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>:call GrepGitFiles(@z)<CR>
      vnoremap <silent> <leader>* "zy:let @/ = @z<CR>:set hlsearch<CR>:call GrepGitFiles(@z)<CR>
      nnoremap <leader>d "zyiw:let @/ = @z<CR>:set hlsearch<CR>:g/<C-r>//d<Left><Left>
      vnoremap <leader>d "zy:let @/ = @z<CR>:set hlsearch<CR>:g/<C-r>//d<Left><Left>
      nnoremap <leader>M qz
      nnoremap <leader>m @z
      noremap <silent> <leader>kk :<C-F>

      function! GrepGitFiles(keyword)
        let l:file_extension = '*.' . expand('%:e')
        if l:file_extension == '*.'
          let l:file_extension = expand('%')
        endif
        let l:git_dir = expand('%:p:h')
        let l:cache_key = 'git_status_' . substitute(l:git_dir, '[^a-zA-Z0-9]', '_', 'g')
        if !exists('g:' . l:cache_key) || (localtime() - get(g:, l:cache_key . '_time', 0)) > 30
          let l:is_git = system('git -C ' . shellescape(l:git_dir) . ' rev-parse --git-dir 2>/dev/null')
          let g:[l:cache_key] = !v:shell_error
          let g:[l:cache_key . '_time'] = localtime()
        endif
        if g:[l:cache_key]
          exe ':vimgrep /' . a:keyword . '/ `git ls-files ' . shellescape(expand('%:p:h')) . '`'
        else
          exe ':vimgrep /' . a:keyword . '/ **/' . l:file_extension
        endif
      endfunction

      " Plugin settings
      " darcula
      colorscheme darcula

      " lightline
      let g:lightline = { 'colorscheme': 'wombat' }

      " fzf.vim
      nnoremap <silent> <space>; :Commands<CR>
      nnoremap <silent> <space>w :Buffers<CR>
      nnoremap <silent> <space><space> :call FzfOmniFiles()<CR>

      if executable('rg')
        nnoremap <silent> <space>g "zyiw:let @/ =  @z<CR>:set hlsearch<CR>:Rg<Space><C-r>/<CR>
        vnoremap <silent> <space>g "zy:let @/ = @z<CR>:set hlsearch<CR>:Rg<Space><C-r>/<CR>
      endif

      function! FzfOmniFiles()
        let l:git_dir = expand('%:p:h')
        let l:cache_key = 'fzf_git_' . substitute(l:git_dir, '[^a-zA-Z0-9]', '_', 'g')
        if !exists('g:' . l:cache_key) || (localtime() - get(g:, l:cache_key . '_time', 0)) > 30
          let l:is_git = system('git -C ' . shellescape(l:git_dir) . ' rev-parse --git-dir 2>/dev/null')
          let g:[l:cache_key] = !v:shell_error
          let g:[l:cache_key . '_time'] = localtime()
        endif
        if g:[l:cache_key]
          :GitFiles
        else
          :Files
        endif
      endfunction

      " unite.vim
      if executable('rg')
        let g:unite_source_grep_command = 'rg'
        let g:unite_source_grep_default_opts = '-n --no-heading --color never'
        let g:unite_source_grep_recursive_opt = ''
      endif

      " vimfiler
      let g:vimfiler_as_default_explorer=1
      let g:vimfiler_safe_mode_by_default=0
      let g:netrw_liststyle=3
      nnoremap <silent> <space>e :VimFilerExplorer<CR>

      " tcomment_vim
      nnoremap <silent> <D-/> :TComment<CR>
      nnoremap <silent> <C-_> :TComment<CR>
      vnoremap <silent> <D-/> :TComment<CR>
      vnoremap <silent> <C-_> :TComment<CR>

      " vim-abolish
      nnoremap <silent>* "zyiw:let @/ = @z<CR>:S/<C-r>/<CR>
      vnoremap <silent>* "zy:let @/ = @z<CR>:S/<C-r>/<CR>

      " copilot.vim
      let g:copilot_no_tab_map = v:true
      imap <silent><script><expr> <C-Y> copilot#Accept("\<CR>")

      " eskk.vim
      if has('vim_starting')
        if has('win32') || has('win64')
          let s:dictionary_dir = expand($HOME.'\vimfiles\dict')
        else
          let s:dictionary_dir = expand('~/.vim/dict')
        endif
        let g:eskk#marker_henkan = "💬"
        let g:eskk#marker_henkan_select = "✅"
        let g:eskk#marker_jisyo_touroku = "📖"
        let g:eskk#egg_like_newline = 1
        let g:eskk#dictionary = { 'path': s:dictionary_dir.'/SKK-JISYO.user', 'sorted': 0, 'encoding': 'utf-8' }
        let g:eskk#large_dictionary = { 'path': s:dictionary_dir.'/SKK-JISYO.L', 'sorted': 1,	'encoding': 'euc-jp' }
        augroup eskk
          autocmd!
          autocmd User eskk-enable-post lmap <buffer> l <Plug>(eskk:disable)
        augroup END
        imap <C-J> <Plug>(eskk:toggle)
        cmap <C-J> <Plug>(eskk:toggle)
        nmap <C-J> i<Plug>(eskk:toggle)
        imap JJ <Plug>(eskk:toggle)
        nmap <space>j i<Plug>(eskk:toggle)
      endif

      " dicwin-vim
      let g:dicwin_mapleader = "\<C-k>"

      " open-browser.vim
      nnoremap <silent> <space>b "zyiw:let @/ =  @z<CR>:set hlsearch<CR>:OpenBrowserSmartSearch<Space><C-r>/<CR>
      vnoremap <silent> <space>b "zy:let @/ = @z<CR>:set hlsearch<CR>:OpenBrowserSmartSearch<Space><C-r>/<CR>

      " vim-qfreplace
      nnoremap <silent> <space>R :Qfreplace<CR>

      " vim-ai
      let g:vim_ai_token_file_path = '~/.config/openai.token'
      xnoremap <space>edit :AIEdit<space>
      xnoremap <silent> <space>ai :AI<CR>
      xnoremap <silent> <space>fix :AIEdit fix grammar and spelling<CR>
      xnoremap <silent> <space><CR> :AIChat<CR>
      nnoremap <silent> <space><CR> :AIChat<CR>
      nnoremap <silent> <space>img :AIImage<space>
      xnoremap <silent> <space>img :AIImage<CR>

      function! CodeReviewFn(range) range
        let l:prompt = "programming syntax is " . &filetype . ", review the code below:\n" . "レビューの言語は日本語でお願いします。\n"
        let l:config = {
        \  "options": {
        \    "initial_prompt": ">>> system\nyou are a clean code expert",
        \  },
        \}
        exe a:firstline.",".a:lastline . "call vim_ai#AIChatRun(a:range, l:config, l:prompt)"
      endfunction
      command! -range -nargs=? AICodeReview <line1>,<line2>call CodeReviewFn(<range>)

      " vim-lsp
      let g:lsp_diagnostics_echo_cursor = 1
      function! s:on_lsp_buffer_enabled() abort
        setlocal omnicunc=lsp#complete
        setlocal signcolumn=yes
        nmap <buffer> gd <plug>(lsp-definition)
        nmap <buffer> <space>rn <plug>(lsp-rename)
        nnoremap <silent> <space>== :LspDocumentFormat<CR>
      endfunction
      augroup lsp_install
        au!
        autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
      augroup END

      " asyncomplete.vim
      inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
      inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
      inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
    '';
  };
}
