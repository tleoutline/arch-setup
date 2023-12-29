unalias z

z() {
	local _pwd
	_pwd=${PWD}
	__zoxide_z $@
	autoenv_init "${_pwd}"
	return 0
}
