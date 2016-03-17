#!/bin/bash
gen_key() {
  keytype=$1
  ks="${keytype}_"
  key="keys/ssh_host_${ks}key"
  if [ "$keytype" == "ed25519" ] ; then
    bits=521
  else
    bits=4096
  fi

  if [ ! -e "${key}" ] ; then
    ssh-keygen -t ${keytype} -f "${key}" -N '' -b $bits
    return $?
  fi
}

mkdir -p keys
gen_key rsa && gen_key ed25519 || exit 1
