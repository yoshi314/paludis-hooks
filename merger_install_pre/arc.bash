#!/usr/bin/env bash

#this will archive generated package into /arc/ just before its installation

export PATH="$(${PALUDIS_EBUILD_DIR}/utils/canonicalise ${PALUDIS_EBUILD_DIR}/utils/ ):${PATH}"
source ${PALUDIS_ECHO_FUNCTIONS_DIR:-${PALUDIS_EBUILD_DIR}}/echo_functions.bash

einfo "Archiving package ${P}"

tar cvzpf "${ROOT}/arc/${P}.tar.gz" -C "${IMAGE}" .

#alternatively : 
#mksquashfs "${IMAGE}" "/arc/${P}.sqfs" -comp xz

einfo "Archiving pakage ${P} finished"