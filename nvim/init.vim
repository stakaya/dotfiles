scriptencoding utf-8
set clipboard=unnamed
set inccommand=split

if has('win32') || has('win64')
  source $HOME\_vimrc
  let g:python3_host_prog=$HOME.'\Programs\Python\Python39\python'
else
  source ~/.vim/../vimrc
  let g:python3_host_prog=substitute(system('which python3'),"\n","","")
endif
