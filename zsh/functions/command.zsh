# vimgrep
function look() {
  if [ -z "$1" ]; then
    echo "Usage: look <search_word>"
    return 1
  fi
  vi "+grep $1"
}

function space_widget() {
  # when inptting spack key it changing directory
  if [[ "${BUFFER}" == " " ]]; then
    fzf-cd-widget
  elif [[ "${BUFFER}" == "vi " || "${BUFFER}" == "vim " ]]; then
    fzf-file-widget
  else
    zle self-insert
  fi
}

function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.zip) unzip $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.gz) gzip -d $1;;
    *.bz2) bzip2 -dc $1;;
    *.tar) tar xvf $1;;
  esac
}

# Anthropic Claude API
function claude-cli() {
  # 使い方: claude-cli input.md "指示文" > output.md
  if [ $# -lt 2 ]; then
    echo "Usage: claude-cli <input-file> <instruction>" >&2
    return 1
  fi

  local input_file="$1"; shift
  local instruction="$*"

  # input_file の内容を JSON エスケープして組み立て
  local payload
  payload="$(jq -Rs --arg instr "$instruction" \
    '{model:"claude-3-opus-20240229",
      max_tokens: 2048,
      messages:[{role:"user",content:[
        {type:"text",text:$instr},
        {type:"text",text:.}
      ]}]}' < "$input_file")"

  curl -sS https://api.anthropic.com/v1/messages \
    -H "x-api-key: $ANTHROPIC_API_KEY" \
    -H "anthropic-version: 2023-06-01" \
    -H "content-type: application/json" \
    --data-binary "$payload"  \
  | jq -r '.content[0].text'
}

# OpenAI GPT API
# 事前準備:
# brew install pipx
# pipx ensurepath
# pipx install openai
function codex-cli() {
  # 使い方: codex-cli input.md "指示文" > output.md
  if [ $# -lt 2 ]; then
    echo "Usage: codex-cli <input-file> <instruction>"
    return 1
  fi

  local input_file="$1"
  shift
  local instruction="$*"

  # ファイル内容を変数に読み込む（改行も保持）
  local content
  content="$(<"$input_file")"

  openai api chat.completions.create \
    -m gpt-5 \
    -g system "$instruction" \
    -g user "$content"
}
