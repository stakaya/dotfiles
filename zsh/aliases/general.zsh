# General command aliases
alias ls='ls --color'
alias weather='curl -H "Accept-Language: ja" wttr.in/tokyo'
alias search='find ./ -type f -not -path "*/.git/*" | xargs grep --no-messages $1 --color'

# Suffix aliases
alias -s {md,markdown,txt,conf,toml,json,yml,yaml}=vi
alias -s {gz,tgz,zip,bz2,tar}=extract 