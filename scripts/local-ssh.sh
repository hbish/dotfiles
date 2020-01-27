#!/usr/bin/env bash

######################################
# Create ssl cert for local testing
######################################

# Once the script completes, install http-server
#  npm i -g http-server
#
# Then add the following to .zshrc
#  function https-server() {
#    readonly dir=${1:?"Specify a directory"}
#    http-server $dir --ssl --cert ~/.local-ssl/localhost.crt --key ~/.local-ssl/localhost.key --no-dotfiles -o
#  }

readonly LOCAL_SSL_DIR="$HOME/.local-ssl"

if [ -d "$LOCAL_SSL_DIR" ]
then
    echo "Directory $LOCAL_SSL_DIR already exists."
else
    echo "Creating $LOCAL_SSL_DIR"
    mkdir "$LOCAL_SSL_DIR"
fi

openssl genrsa -out "$LOCAL_SSL_DIR"/localhost.key 2048
openssl req -new -x509 -key "$LOCAL_SSL_DIR"/localhost.key -out "$LOCAL_SSL_DIR"/localhost.crt -days 3650 -subj /CN=localhost
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$LOCAL_SSL_DIR"/localhost.crt
