function __load_nvm() {
  unset -f node npm npx yarn pnpm corepack __load_nvm 2>/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
}

function __node()     { __load_nvm; command node "$@"; }
function __npm()      { __load_nvm; command npm "$@"; }
function __npx()      { __load_nvm; command npx "$@"; }
function __yarn()     { __load_nvm; command yarn "$@"; }
function __pnpm()     { __load_nvm; command pnpm "$@"; }
function __corepack() { __load_nvm; command corepack "$@"; }
