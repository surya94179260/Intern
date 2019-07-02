#!/bin/bash
if [[ ! -z "$1" ]]; then  
	. setpeer.sh APEDA peer0 
export CHANNEL_NAME="mangotracechannel"
	peer chaincode install -n recordkeeper -v $1 -l golang -p  github.com/recordkeeper
	. setpeer.sh Exporters peer0 
export CHANNEL_NAME="mangotracechannel"
	peer chaincode install -n recordkeeper -v $1 -l golang -p  github.com/recordkeeper
	. setpeer.sh Importers peer0 
export CHANNEL_NAME="mangotracechannel"
	peer chaincode install -n recordkeeper -v $1 -l golang -p  github.com/recordkeeper
	peer chaincode upgrade -o orderer.xnet.com:7050 --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C mangotracechannel -n recordkeeper -v $1 -c '{"Args":["init",""]}' -P " OR( 'APEDAMSP.member','ExportersMSP.member','ImportersMSP.member' ) " 
else
	echo ". recordkeeper_updchain.sh  <Version Number>" 
fi
