# Development tool aliases
alias apkcheck='jarsigner -verify -verbose -certs $1'
alias brewclean='brew cleanup && brew update && brew upgrade && brew upgrade --cask'
alias indocker='docker exec -it `docker ps -a -f status=running --format "{{.Names}}" | fzf` sh'
alias tmux='tmux -u -2' 