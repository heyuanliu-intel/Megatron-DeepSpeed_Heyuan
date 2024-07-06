#!/bin/bash

ROOT_DIR="$HOME/Megatron-DeepSpeed_Heyuan"
SSH_PORT=60005
CONFIG="$HOME/.ssh/config"
DS_ENV="$HOME/.deepspeed_env"
HOST_FILE=${ROOT_DIR}/scripts/hostsfile

if [ `cat ${HOST_FILE} | wc -l` -gt 1 ]; then

rm -rf ${CONFIG}
for IP in `cut -d " " -f1 ${HOST_FILE}`; 
do cat << EOT >> ${CONFIG}
Host ${IP}
    IdentityFile /root/.ssh/id_rsa
    Port ${SSH_PORT}
EOT
done

#For Tlinux:
#HCCL_SOCKET_IFNAME=bond2,bond3,bond4,bond5,bond6,bond7,dond8,bond9
cat << EOT > ${DS_ENV}
HCCL_OVER_OFI=1 
HCCL_GAUDI_DIRECT=1
HCCL_SOCKET_IFNAME=ens108np0,ens109np0,ens110np0,ens111np0,ens112np0,ens113np0,ens114np0,ens115np0 
LIBFABRIC_ROOT=/opt/habanalabs/libfabric-1.20.0 
LD_LIBRARY_PATH=/opt/openmpi/lib:/opt/ucx/lib:/opt/habanalabs/libfabric-1.20.0/lib:/usr/lib/habanalabs 
EOT

for IP in `cut -d " " -f1 ${HOST_FILE}`; 
    do ssh-keyscan -p ${SSH_PORT} -H $IP >> ~/.ssh/known_hosts
done

for IP in `tail -n -1 ${HOST_FILE} | cut -d " " -f1`; 
    do scp -r ${ROOT_DIR}/ds_config.json root@${IP}:${ROOT_DIR}/ds_config.json
done

fi