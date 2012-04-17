#!/usr/bin/env bash

[[ -x /usr/bin/eix-update ]] || exit 0
source ${PALUDIS_EBUILD_DIR}/echo_functions.bash
ebegin "Updating eix database"
opts=

for repo in $(cave print-repositories)
do
[[ $(cave print-repository-metadata ${repo} | grep format | cut -d= -f 2) == "ebuild" ]] || \
[[ $(cave print-repository-metadata ${repo} | grep format | cut -d= -f 2) == "e" ]] || continue

location=$(cave print-repository-metadata ${repo} | grep \^location | cut -d= -f2)
opts="${opts} --add-overlay ${location}"
done

/usr/bin/eix-update -o ${ROOT}/var/cache/eix-tmp -q ${opts}
[ -f ${ROOT}/var/cache/eix ] && /usr/bin/eix-diff ${ROOT}/var/cache/eix ${ROOT}/var/cache/eix-tmp

/bin/mv ${ROOT}/var/cache/eix ${ROOT}/var/cache/eix.old

/bin/mv ${ROOT}/var/cache/eix-tmp ${ROOT}/var/cache/eix
