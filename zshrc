# Zsh-completions
fpath=(~/.zsh-completions $fpath)
autoload -U compinit; compinit 
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin \
                             /usr/local/git/bin
# Source
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Environment
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# TODO 下記のパスに修正
# export ANT_HOME=/usr/local/opt/ant
# export MAVEN_HOME=/usr/local/opt/maven
# export GRADLE_HOME=/usr/local/opt/gradle
# export ANDROID_HOME=/usr/local/opt/android-sdk
# export ANDROID_NDK_HOME=/usr/local/opt/android-ndk
# export PATH=$ANT_HOME/bin:$PATH
# export PATH=$MAVEN_HOME/bin:$PATH
# export PATH=$GRADLE_HOME/bin:$PATH
# export PATH=$ANDROID_HOME/tools:$PATH
# export PATH=$ANDROID_HOME/platform-tools:$PATH
# export PATH=$ANDROID_HOME/build-tools/23.0.3:$PATH

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$HOME/Library/Libs:$PATH"

# Alias
alias adbinstall='find ./ -name *.apk | peco | xargs adb install -r'
alias adblogcat='pidcat `adb shell pm list package | sed -e s/package:// | peco`'
alias adbreset='adb kill-server; adb start-server'
alias adbscreencap='FILE=`date +"%Y%m%d%I%m%S"`.png && adb shell screencap -p /sdcard/$FILE && adb pull /sdcard/$FILE $HOME/Desktop/$FILE && adb shell rm /sdcard/$FILE && open $HOME/Desktop/$FILE'
alias adbuninstall='adb shell pm list package | sed -e s/package:// | peco | xargs adb uninstall'
alias apkpull='adb shell pm list package -f | sed -e "s/package:\([^=]*\).*/\1/g" | peco | xargs adb pull'
alias brewupdate='brew update && brew cask update && brew upgrade && brew cleanup && brew cask cleanup'

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

# Keybind
bindkey -v
zle -N peco-select-history
bindkey '^r' peco-select-history
