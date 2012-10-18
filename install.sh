#!/bin/bash

pushd "$(dirname "$0")" &>/dev/null

fullname()
{
	readlink -f "$@"
}

ln -sf "$(fullname vimrc)" "$HOME/.vimrc"

popd &>/dev/null
