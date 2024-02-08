#!/bin/sh
set -e

FEATURE_ID="aws-cli-persistence"

echo "Activating feature '$FEATURE_ID'"
echo "User: ${_REMOTE_USER}     User home: ${_REMOTE_USER_HOME}"

if [ -z "$_REMOTE_USER" ] || [ -z "$_REMOTE_USER_HOME" ]; then
    echo "***********************************************************************************"
    echo "*** Require _REMOTE_USER and _REMOTE_USER_HOME to be set (by dev container CLI) ***"
    echo "***********************************************************************************"
    exit 1
fi

# make /dc/aws-cli folder if doesn't exist
mkdir -p "/dc/aws-cli"

# as to why we move around the folder, check `github-cli-persistence/install.sh`
if [ -e "$_REMOTE_USER_HOME/.aws" ]; then
    echo "Moving existing .aws folder to .aws-old"
    mv "$_REMOTE_USER_HOME/.aws" "$_REMOTE_USER_HOME/.aws-old"
fi

ln -s /dc/aws-cli "$_REMOTE_USER_HOME/.aws"
# chown .aws folder
chown -R "${_REMOTE_USER}:${_REMOTE_USER}" "$_REMOTE_USER_HOME/.aws"

# Create lifecycle script
ON_CREATE_SCRIPT_PATH="/usr/local/share/aws-cli-persistence/"

mkdir -p "$ON_CREATE_SCRIPT_PATH"
cp oncreate.sh "$ON_CREATE_SCRIPT_PATH/oncreate.sh"
