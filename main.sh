#!/bin/bash
#
main() {

	trap "{ exit 0; }" SIGINT SIGTERM ERR EXIT
	ACTIONS=('Install Node Packages' "Install System Pakcages" "Clone configs from git" "exit")
	ACTION=$(gum choose --cursor-prefix "○ " --selected-prefix "◉ " --unselected-prefix="○ " "${ACTIONS[@]}")

	if [[ $ACTION == "Install Node Packages" ]]; then
		echo "Installing Node Packages"
		bash ./node-installer.sh
	elif [[ $ACTION == "Install System Pakcages" ]]; then
		echo "Installing System Pakcages"
		bash ./sys-installer.sh
	elif [[ $ACTION == "Clone configs from git" ]]; then
		echo "Cloning configs from git"
	elif [[ $ACTION == "exit" ]]; then
		exit 0
	fi
	main
}

main "$@"
