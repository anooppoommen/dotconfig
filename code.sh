#!/bin/bash
# simpler helper script that helps run neovim
# instead of the default c command that i'm used too
project_dir=$1
# if we have no project dir set
# choose the current director as the
# project director
if [ -z "$project_dir" ]; then
	project_dir=$(pwd)
fi

current_dir=$(pwd)
cd $project_dir

nvim
# move back to the original folder
cd $current_dir
