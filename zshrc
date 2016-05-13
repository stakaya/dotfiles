# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize
bindkey -v
export ANDROID_HOME="$HOME/Library/Android/sdk/"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"

function apk2src() {
	local dst=${${1##*/}%%.*}
	dst+='.depackaged'
	unzip $1 -d $dst
	d2j-dex2jar ${dst}/classes.dex -o ${dst}/classes_dex2jar.jar
	unzip ${dst}/classes_dex2jar.jar -d ${dst}/Classes
	jad -8 -s java -d ${dst}/src -r ${dst}/**/*.class

	for file in $(find ./${dst} -name '*.xml')
	do
	   java -jar AXMLPrinter2.jar ${file} >> ${file}.dep.xml
	done
}

function peco-select-history() {
local tac
if which tac > /dev/null; then
tac="tac"
else
	tac="tail -r"
	fi
	BUFFER=$(\history -n 1 | \
			eval $tac | \
					peco --query "$LBUFFER")
	CURSOR=$#BUFFER
		zle clear-screen
	}
zle -N peco-select-history
bindkey '^r' peco-select-history
