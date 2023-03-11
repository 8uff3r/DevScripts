#!/bin/bash

main() {
	[[ -x "$(command -v node)" ]] || bash ./sys-installer.sh nodejs
	PACKAGES="$(cat ./packages/npm/packages)"
	echo "Selct your favourite node packages manager"
	NPM=$(gum choose --cursor-prefix "○ " --selected-prefix "◉ " "npm" "pnpm" "yarn")
	SELECTED="$(gum choose --cursor-prefix "○ " --selected-prefix "◉ " --no-limit $PACKAGES)"
	$NPM install -g $SELECTED
}
main "$@"
