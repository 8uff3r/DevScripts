#!/bin/bash

distro() {
	if [ -f /etc/os-release ]; then
		# freedesktop.org and systemd
		. /etc/os-release
		OS=$ID
		OSLIKE=$ID_LIKE
	elif type lsb_release >/dev/null 2>&1; then
		# linuxbase.org
		OS=$(lsb_release -si)
	elif [ -f /etc/lsb-release ]; then
		# For some versions of Debian/Ubuntu without lsb_release command
		. /etc/lsb-release
		OS=$DISTRIB_ID
	elif [ -f /etc/debian_version ]; then
		# Older Debian/Ubuntu/etc.
		OS=Debian
	else
		# Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
		OS=$(uname -s)
	fi
}

install() {
	os=$1
	oslike=$2
	if [[ $os == "arch" || $oslike == "arch" ]]; then
		echo sudo pacman -S
	elif [[ $os == "fedora" ]]; then
		echo sudo dnf install
	elif [[ $os == "centos" || $os == "rocky" || $os == "rhel" || $oslike == "rhel" ]]; then
		echo sudo yum install
	elif [[ $os == "ubuntu" || $os == "debian" || $os == "linuxmint" || $oslike == "ubuntu" || $oslike == "debian" ]]; then
		echo sudo apt install
	elif [[ $os == "opensuse" || $os == "suse" || $oslike == "suse" ]]; then
		echo sudo zypper in
	else
		exit 1
	fi
}

main() {
	distro
	INSTALL=$(install "$OS" "$ID_LIKE")
	if [[ $# == 0 ]]; then
		if [[ -f ./packages/"${OS}" ]]; then
			PACKAGES="$(cat ./packages/"${OS}")"
		elif [[ -f ./packages/"${OSLIKE}" ]]; then
			PACKAGES="$(cat ./packages/"${OSLIKE}")"
		else
			echo "Distro Not Supported" && exit 1
		fi
		echo "Please choose the packages you want to install:"
		ACTIONS=$(gum choose --cursor-prefix "○ " --selected-prefix "◉ " --no-limit $PACKAGES)
		echo
		$INSTALL $ACTIONS
	else
		$INSTALL "$@"
	fi

}

main "$@"
