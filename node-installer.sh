#!/bin/bash

main() {
	[[ -x "$(command -v node)" ]] || bash ./sys-installer.sh nodejs
	PACKAGES="$(cat ./packages/npm/packages)"

	echo "Selct your favourite node packages manager"
	npm=$(gum choose --cursor-prefix "○ " --selected-prefix "◉ " --no-limit "npm" "pnpm" "yarn")
	$npm install -g $PACKAGES
}
main "$@"
