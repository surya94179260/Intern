
#!/bin/bash
export ORDERER_CA=/opt/ws/crypto-config/ordererOrganizations/xnet.com/msp/tlscacerts/tlsca.xnet.com-cert.pem

if [ $# -lt 2 ];then
	echo "Usage : . setpeer.sh APEDA|Importers|Exporters| <peerid>"
fi
export peerId=$2

if [[ $1 = "APEDA" ]];then
	echo "Setting to organization APEDA peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.apeda.gov.in:7051
	export CORE_PEER_LOCALMSPID=APEDAMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/apeda.gov.in/peers/$peerId.apeda.gov.in/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/apeda.gov.in/peers/$peerId.apeda.gov.in/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/apeda.gov.in/peers/$peerId.apeda.gov.in/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/apeda.gov.in/users/Admin@apeda.gov.in/msp
fi

if [[ $1 = "Importers" ]];then
	echo "Setting to organization Importers peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.importers.in:7051
	export CORE_PEER_LOCALMSPID=ImportersMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/importers.in/peers/$peerId.importers.in/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/importers.in/peers/$peerId.importers.in/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/importers.in/peers/$peerId.importers.in/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/importers.in/users/Admin@importers.in/msp
fi

if [[ $1 = "Exporters" ]];then
	echo "Setting to organization Exporters peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.exporters.in:7051
	export CORE_PEER_LOCALMSPID=ExportersMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/exporters.in/peers/$peerId.exporters.in/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/exporters.in/peers/$peerId.exporters.in/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/exporters.in/peers/$peerId.exporters.in/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/exporters.in/users/Admin@exporters.in/msp
fi

	