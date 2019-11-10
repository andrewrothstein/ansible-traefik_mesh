#!/usr/bin/env sh
DIR=~/Downloads
MIRROR=https://github.com/containous/maesh/releases/download

dl()
{
    local ver=$1
    local lchecksums=$2
    local os=$3
    local arch=$4
    local archive_type=${5:-tar.gz}
    local platform="${os}_${arch}"
    local file=maesh_${ver}_${platform}.${archive_type}
    local url=$MIRROR/$ver/$file
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform `fgrep $file $lchecksums | awk '{print $1}'`
}

dl_ver()
{
    local ver=$1
    local checksums=maesh_${ver}_checksums.txt
    local lchecksums=$DIR/$checksums
    local rchecksums=$MIRROR/$ver/$checksums
    if [ ! -e $lchecksums ];
    then
        wget -q -O $lchecksums $rchecksums
    fi

    printf "  # %s\n" $rchecksums
    printf "  %s:\n" $ver

    dl $ver $lchecksums linux arm64
    dl $ver $lchecksums freebsd 386
    dl $ver $lchecksums linux armv7
    dl $ver $lchecksums windows amd64 zip
    dl $ver $lchecksums openbsd 386
    dl $ver $lchecksums freebsd armv5
    dl $ver $lchecksums windows 386 zip
    dl $ver $lchecksums freebsd amd64
    dl $ver $lchecksums freebsd armv6
    dl $ver $lchecksums openbsd armv7
    dl $ver $lchecksums openbsd armv5
    dl $ver $lchecksums freebsd armv7
    dl $ver $lchecksums openbsd armv6
    dl $ver $lchecksums linux 386
    dl $ver $lchecksums darwin amd64
    dl $ver $lchecksums openbsd amd64
    dl $ver $lchecksums linux amd64
    dl $ver $lchecksums linux armv6
    dl $ver $lchecksums linux armv5
}

dl_ver ${1:-v0.7.0}
