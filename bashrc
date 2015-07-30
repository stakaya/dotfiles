# settings for peco
_replace_by_history() {
	declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
	READLINE_LINE="$l"
	READLINE_POINT=${#l}

	${READLINE_LINE}
}
bind -x '"\C-r": _replace_by_history'
bind    '"\C-xr": reverse-search-history'
