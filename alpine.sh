#!/bin/sh

set -eux

export PKG_CONFIG_PATH=/usr/lib/pkgconfig

wrap_path="/home/src/$1"
proj_name="$2"
packages="$3"
build_options="$4"
do_tests="$5"

muon version
muon -v subprojects fetch -o /home/build/subprojects "$wrap_path"
dir="$(echo "print(import('subprojects').load_wrap('$wrap_path').path)" | muon internal eval -)"
build="/home/build/$proj_name"

apk add $packages
muon -vC "subprojects/$dir" build $build_options "$build"
