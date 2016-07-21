#!/bin/bash

## Rotate update logs

HOMEBREW_PREFIX="$(/usr/local/bin/brew --prefix)"
LOG_DIR="${HOMEBREW_PREFIX}/var/log"

STDOUT_FILE="${LOG_DIR}/homebrew.mxcl.autoupdate.out"
STDERR_FILE="${LOG_DIR}/homebrew.mxcl.autoupdate.err"


if [ -x /usr/bin/gzip ]; then 
	gzext=".gz"; 
else 
	gzext=""; 
fi


## Create log directory
#mkdir -p "${LOG_DIR}" || return 1

i="9"
while [ $i -ge 0 ] ;
do

	if [ -f "${STDOUT_FILE}.${i}${gzext}" ]; then mv -f "${STDOUT_FILE}.${i}${gzext}" "${STDOUT_FILE}.$[$i+1]${gzext}"; fi
	if [ -f "${STDERR_FILE}.${i}${gzext}" ]; then mv -f "${STDERR_FILE}.${i}${gzext}" "${STDERR_FILE}.$[$i+1]${gzext}"; fi

	i=$[$i-1]

done

if [ -f "${STDOUT_FILE}" ]; then mv -f "${STDOUT_FILE}" "${STDOUT_FILE}.0"; fi
if [ -f "${STDERR_FILE}" ]; then mv -f "${STDERR_FILE}" "${STDERR_FILE}.0"; fi

if [ -x /usr/bin/gzip ]; then 
	[ -f "${STDOUT_FILE}.0" ] && gzip -9 "${STDOUT_FILE}.0"
	[ -f "${STDERR_FILE}.0" ] && gzip -9 "${STDERR_FILE}.0"
fi

#touch "${STDOUT_FILE}"
#touch "${STDERR_FILE}"

#exit 0


