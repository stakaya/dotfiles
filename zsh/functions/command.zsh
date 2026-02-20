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
  elif [[ "${BUFFER}" == "vi " || "${BUFFER}" == "vim " || "${BUFFER}" == "nvim " ]]; then
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

# Anthropic
function claude-cli() {
  # 使い方: cat input.md | claude-cli "指示文" > output.md
  if [ $# -lt 1 ]; then
    echo "Usage: claude-cli <instruction>" >&2
    return 1
  fi
  local instruction="$*"

  # input_file の内容を JSON エスケープして組み立て
  local payload
  payload="$(jq -Rs --arg instr "$instruction" \
    '{model:"claude-3-opus-20240229",
      max_tokens: 2048,
      messages:[{role:"user",content:[
        {type:"text",text:$instr},
        {type:"text",text:.}
      ]}]}')"

  curl -sS https://api.anthropic.com/v1/messages \
    -H "x-api-key: ${ANTHROPIC_API_KEY}" \
    -H "anthropic-version: 2023-06-01" \
    -H "content-type: application/json" \
    --data-binary "$payload"  \
  | jq -r '.content[0].text'
}

# OpenAI
function codex-cli() {
    # 使い方: cat input.md | codex-cli "指示文" > output.md
  if [ $# -lt 1 ]; then
    echo "Usage: codex-cli <instruction>" >&2
    return 1
  fi
  local instruction="$*"

  local payload
  payload="$(jq -Rs --arg instr "$instruction" \
    '{model:"gpt-5.2",
      messages:[
        {role:"system", content:$instr},
        {role:"user",   content:.}
      ]}')"

  curl -sS https://api.openai.com/v1/chat/completions \
    -H "Authorization: Bearer ${OPENAI_API_KEY}" \
    -H "Content-Type: application/json" \
    --data-binary "$payload" \
  | jq -r '.choices[0].message.content'
}

# Google
function gemini-cli() {
  # 使い方: cat input.md | gemini-cli "指示文" > output.md
  if [ $# -lt 1 ]; then
    echo "Usage: gemini-cli <instruction>" >&2
    return 1
  fi
  local instruction="$*"
  # 標準入力の本文を読み取り、指示文と結合して1本のプロンプトとして送る
  local body; body="$(cat)"
  printf "%s\n\n-----\n%s\n" "$instruction" "$body" | gemini
}

function xcode-nuke() {
  echo "⚠️  This will COMPLETELY reset Xcode environment."
  echo "   - DerivedData"
  echo "   - Simulators"
  echo "   - Xcode caches & preferences"
  echo ""
  read "ans?Type YES to continue: "

  if [[ "$ans" != "YES" ]]; then
    echo "Aborted."
    return 1
  fi

  echo "Stopping Xcode related services..."
  killall Xcode 2>/dev/null
  killall Simulator 2>/dev/null
  killall -9 com.apple.CoreSimulator.CoreSimulatorService 2>/dev/null

  echo "Removing Xcode data..."
  rm -rf ~/Library/Developer/Xcode
  rm -rf ~/Library/Developer/CoreSimulator
  rm -rf ~/Library/Caches/com.apple.dt.Xcode
  rm -rf ~/Library/Preferences/com.apple.dt.Xcode.plist
  rm -rf ~/Library/Saved\ Application\ State/com.apple.dt.Xcode.savedState

  echo "✅ Xcode environment nuked. Reboot Xcode when ready."
}
