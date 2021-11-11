#!/usr/bin/env bash
cd divvy-dev #TODO: working directory
echo "Copying filtered branches to file."
git branch -a | grep -E '/release/(([0-9])+\.)+([0-9])+$' > branches
echo "File created successfully."
