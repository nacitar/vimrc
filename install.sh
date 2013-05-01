#!/bin/bash

pushd "$(dirname "$0")" &>/dev/null

fullname()
{
	echo "$PWD/$@"
}

ln -sf "$(fullname vimrc)" "$HOME/.vimrc"
# update submodules too
git submodule init
git submodule update

popd &>/dev/null
