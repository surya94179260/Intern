#!/bin/bash
. setpeer.sh APEDA peer0 
export CHANNEL_NAME="mangotracechannel"
peer chaincode install -n recordkeeper -v 1.0 -l golang -p  github.com/recordkeeper
. setpeer.sh Exporters peer0 
export CHANNEL_NAME="mangotracechannel"
peer chaincode install -n recordkeeper -v 1.0 -l golang -p  github.com/recordkeeper
. setpeer.sh Importers peer0 
export CHANNEL_NAME="mangotracechannel"
peer chaincode install -n recordkeeper -v 1.0 -l golang -p  github.com/recordkeeper
peer chaincode instantiate -o orderer.xnet.com:7050 --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C mangotracechannel -n recordkeeper -v 1.0 -c '{"Args":["init",""]}' -P " OR( 'APEDAMSP.member','ExportersMSP.member','ImportersMSP.member' ) " 
