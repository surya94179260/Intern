
#!/bin/bash -e
export PWD=`pwd`

export FABRIC_CFG_PATH=$PWD
export ARCH=$(uname -s)
export CRYPTOGEN=$PWD/bin/cryptogen
export CONFIGTXGEN=$PWD/bin/configtxgen

function generateArtifacts() {
	
	echo " *********** Generating artifacts ************ "
	echo " *********** Deleting old certificates ******* "
	
        rm -rf ./crypto-config
	
        echo " ************ Generating certificates ********* "
	
        $CRYPTOGEN generate --config=$FABRIC_CFG_PATH/crypto-config.yaml
        
        echo " ************ Generating tx files ************ "
	
		$CONFIGTXGEN -profile OrdererGenesis -outputBlock ./genesis.block
		
		$CONFIGTXGEN -profile mangotracechannel -outputCreateChannelTx ./mangotracechannel.tx -channelID mangotracechannel
		
		echo "Generating anchor peers tx files for  APEDA"
		$CONFIGTXGEN -profile mangotracechannel -outputAnchorPeersUpdate  ./mangotracechannelAPEDAMSPAnchor.tx -channelID mangotracechannel -asOrg APEDAMSP
		
		echo "Generating anchor peers tx files for  Exporters"
		$CONFIGTXGEN -profile mangotracechannel -outputAnchorPeersUpdate  ./mangotracechannelExportersMSPAnchor.tx -channelID mangotracechannel -asOrg ExportersMSP
		
		echo "Generating anchor peers tx files for  Importers"
		$CONFIGTXGEN -profile mangotracechannel -outputAnchorPeersUpdate  ./mangotracechannelImportersMSPAnchor.tx -channelID mangotracechannel -asOrg ImportersMSP
		

		

}
function generateDockerComposeFile(){
	OPTS="-i"
	if [ "$ARCH" = "Darwin" ]; then
		OPTS="-it"
	fi
	cp  docker-compose-template.yaml  docker-compose.yaml
	
	
	cd  crypto-config/peerOrganizations/apeda.gov.in/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/APEDA_PRIVATE_KEY/${PRIV_KEY}/g"  docker-compose.yaml
	
	
	cd  crypto-config/peerOrganizations/importers.in/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/IMPORTERS_PRIVATE_KEY/${PRIV_KEY}/g"  docker-compose.yaml
	
	
	cd  crypto-config/peerOrganizations/exporters.in/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/EXPORTERS_PRIVATE_KEY/${PRIV_KEY}/g"  docker-compose.yaml
	
}
generateArtifacts 
cd $PWD
generateDockerComposeFile
cd $PWD

