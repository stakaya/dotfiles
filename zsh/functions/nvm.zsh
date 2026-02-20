function __load_nvm() {
  unset -f node npm npx yarn pnpm corepack __load_nvm 2>/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
}

node()     { __load_nvm; command node "$@"; }
npm()      { __load_nvm; command npm "$@"; }
npx()      { __load_nvm; command npx "$@"; }
yarn()     { __load_nvm; command yarn "$@"; }
pnpm()     { __load_nvm; command pnpm "$@"; }
corepack() { __load_nvm; command corepack "$@"; }
