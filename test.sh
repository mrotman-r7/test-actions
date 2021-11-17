#!/usr/bin/env bash

branchDiff=`git diff new_workflow..main`
$branchDiff
if [[ ! -z "$branchDiff" ]]; then
	echo  "not empty"
	echo "$branchDiff"
else
	echo "empty"
fi
