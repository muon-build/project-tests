#!/bin/sh

set -eux

export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/share/pkgconfig

wrap_path="/home/src/$1"
proj_name="$2"
packages="$3"
packages_del="$4"
build_options="$5"
do_tests="$6"

muon version
muon -v subprojects fetch -o /home/build/subprojects "$wrap_path"
dir="$(echo "print(import('subprojects').load_wrap('$wrap_path').path)" | muon internal eval -)"
build="/home/build/$proj_name"

if [ -n "$packages_del" ]; then
	apk del $packages_del
fi
if [ -n "$packages" ]; then
	apk add $packages
fi
muon -vC "subprojects/$dir" build $build_options "$build"
