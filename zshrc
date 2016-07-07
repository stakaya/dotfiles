# Source
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Environment
export ANDROID_HOME="$HOME/Library/Android/sdk/"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="$HOME/Library/Libs:$PATH"

# Alias
alias adbinstall='find ./ -name *.apk | peco | xargs adb install -r'
alias adblogcat='pidcat `adb shell pm list package | sed -e s/package:// | peco`'
alias adbreset='adb kill-server; adb start-server'
alias adbscreencap='FILE=`date +"%Y%m%d%I%m%S"`.png && adb shell screencap -p /sdcard/$FILE && adb pull /sdcard/$FILE $HOME/Desktop/$FILE && adb shell rm /sdcard/$FILE && open $HOME/Desktop/$FILE'
alias adbuninstall='adb shell pm list package | sed -e s/package:// | peco | xargs adb uninstall'
alias apkpull='adb shell pm list package -f | sed -e "s/package:\([^=]*\).*/\1/g" | peco | xargs adb pull'

# Function
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

function dex-method-count() {
	cat $1 | head -c 92 | tail -c 4 | hexdump -e '1/4 "%d\n"'
}

function dex-method-count-by-package() {
	dir=$(mktemp -d -t dex)
	baksmali $1 -o $dir
	for pkg in `find $dir/* -type d`; do
		smali $pkg -o $pkg/classes.dex
		count=$(dex-method-count $pkg/classes.dex)
		name=$(echo ${pkg:(${#dir} + 1)} | tr '/' '.')
		echo -e "$count\t$name"
	done
	rm -rf $dir   
}

# Keybind
bindkey -v
zle -N peco-select-history
bindkey '^r' peco-select-history
