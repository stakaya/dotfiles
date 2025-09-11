
# vimgrep
look() {
  if [ -z "$1" ]; then
    echo "Usage: look <search_word>"
    return 1
  fi
  vi "+grep $1"
}

# Anthropic Claude API
claude-cli() {
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
codex-cli() {
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
