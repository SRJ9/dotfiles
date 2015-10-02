#-------------------------------------------------------------
# Scripts personalizados
#-------------------------------------------------------------
_custom="$HOME/.bashrc.d/custom/${HOSTNAME}.bash"
if [ -a "$_custom" ]; then
	source "$_custom"
fi

_is_desktop="$HOME/.bashrc.d/custom/is_desktop.bash"
if [[ -a "$_is_desktop" && !$is_server ]]; then
	source "$_is_desktop"
fi

_is_server="$HOME/.bashrc.d/custom/is_server.bash"
if [[ -a "$_is_server" && $is_server ]]; then
	source "$_is_server"
fi