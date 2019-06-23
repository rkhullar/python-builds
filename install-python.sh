#!/usr/bin/env bash

file="versions.txt"
while IFS= read -r line
do
    pyenv install ${line} &
done < ${file}

export FAIL=0
for job in `jobs -p`
do
echo ${job}
    wait ${job} || let "FAIL+=1"
done
pyenv global ${DEFAULT_PYTHON_VERSION}
echo ${FAIL}
