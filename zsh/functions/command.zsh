
# vimgrep
look() {
  if [ -z "$1" ]; then
    echo "Usage: look <search_word>"
    return 1
  fi
  vi "+grep $1"
}
