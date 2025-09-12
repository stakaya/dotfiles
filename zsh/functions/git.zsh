function git_switch() {
  local branches branch
  branches=$(git branch -vv) && \
    branch=$(echo "$branches" | fzf +m) && \
    git switch $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

function git_fetch() {
  local branches branch
  branches=$(git branch -vv -r) && \
    branch=$(echo "$branches" | fzf +m) && \
    git fetch $(echo "$branch" | awk '{print $1}' | sed "s/\// /")
}

function git_add() {
  local out q n addfiles
  while out=$(git status --short | awk '{if (substr($0,2,1) !~ / /) print $2}' | fzf-tmux --multi --exit-0 --expect=ctrl-d);
  do
    q=$(head -1 <<< "$out")
    n=$[$(wc -l <<< "$out") - 1]
    addfiles=(`echo $(tail "-$n" <<< "$out")`)
    [[ -z "$addfiles" ]] && continue
    if [ "$q" = ctrl-d ]; then
      git diff --color=always $addfiles | less -R
    else
      git add $addfiles
    fi
  done
}
