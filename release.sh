#!/bin/bash

name='dabplus-on-air-processing'
version=$1

function checkInput {
    if [[ ! $version ]]; then
        >&2 echo "No version given as first arg."
        exit 1
    fi

    if [[ ! ${version} =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        >&2 echo "Please specify a version in the format MAJOR.MINOR.PATCH using only numbers and following semver."
        exit 1
    fi
}

function checkWorkingCopy {
    if ! git diff-index --quiet HEAD --; then
        >&2 echo "Local modifications detected. Please clean you working copy before releasing."
        exit 1
    fi
}

function applyVersion {
    sed -i -e "s/Version:.*/Version:  ${version}/" ${name}.spec
    sed -i -e "s/Release:.*/Release:  1/" ${name}.spec
}

function commitAndTag {
    git commit -m "Bump version to ${version}" ${name}.spec
    git tag "v${version}"
}

checkInput
checkWorkingCopy
applyVersion
commitAndTag

echo "v${version} of ${name} was tagged locally. Please check the work before running before pushing."
echo "    git push --tags origin master"
