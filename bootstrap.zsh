#!/bin/zsh

cd "$(dirname "${(%):-%N}")";

git pull origin master;

function doIt() {
    rsync --exclude ".git/" \
        --exclude ".DS_Store" \
        --exclude "bootstrap.sh" \
        --exclude "README.md" \
        -avh --no-perms . ~;
}

if [ "$1" = "--force" -o "$1" = "-f" ]; then
    doIt;
else
    read "cont?This may overwrite existing files in your home directory. Are you sure? (y/n) "
    echo "";
    if [[ "$cont" =~ ^[Yy]$ ]]; then
        doIt;
    fi;
fi;

unset doIt;
