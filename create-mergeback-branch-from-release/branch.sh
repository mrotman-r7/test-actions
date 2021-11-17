#!/usr/bin/env bash

source $(dirname "$0")/common.sh

VERSION_NAME=$1
COMMIT_SHA=$2
GIT_USER_NAME=$3
GIT_USER_EMAIL=$4

function configureNewBranch()
{
    local sourceBranch=$1

    echo "##########################"
    echo "Branching from commit id: $commitId"
    echo "##########################"
    date_merge= date +%Y%m%d
    branchReleaseName="mergeback__release/${VERSION_NAME}-$date_merge"
    git checkout $sourceBranch
    echo "Checkout branch: $sourceBranch"
    git branch $branchReleaseName || error "can't checkout branch: $branchReleaseName, source: $sourceBranch"
    git checkout $branchReleaseName
    echo "finish branching project, pushing to repo"
    git push -u origin $branchReleaseName || error "can't push branch: $branchReleaseName to remote"
    echo "Creating pull request with reviewers:"
    gh pr create --title $branchReleaseName --body "automatically created because changes detected" --reviewer rapid7/mrotman-r7 --head $branchReleaseName --base main
    echo "Creating auto merge for pull request"
<<<<<<< HEAD
    gh pr merge $branchReleaseName --auto -m
=======
    gh pr merge $branchReleaseName --auto
>>>>>>> e1bfecd1febe7bf2b160dc243c346b242160a48b
    echo "finished creating pull request"
    echo "##########################"

}

function gitConfig()
{
    echo "Configuring git creds"
    git config --global user.name $GIT_USER_NAME
    git config --global user.email $GIT_USER_EMAIL
}

echo "VERSION_NAME: $VERSION_NAME"
echo "COMMIT_SHA: $COMMIT_SHA"
echo "GIT_USER_NAME: $GIT_USER_NAME"
echo "GIT_USER_EMAIL: $GIT_USER_EMAIL"

gitConfig
if [ -z "${COMMIT_SHA}" ]; then
    echo "COMMIT_SHA is empty"
else
    configureNewBranch ${COMMIT_SHA}
fi
