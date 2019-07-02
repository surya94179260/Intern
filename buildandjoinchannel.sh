
#!/bin/bash -e




	
	echo "Building channel for mangotracechannel" 
	
	. setpeer.sh APEDA peer0
	export CHANNEL_NAME="mangotracechannel"
	peer channel create -o orderer.xnet.com:7050 -c $CHANNEL_NAME -f ./mangotracechannel.tx --tls true --cafile $ORDERER_CA -t 1000s
	
		
        
            . setpeer.sh APEDA peer0
            export CHANNEL_NAME="mangotracechannel"
			peer channel join -b $CHANNEL_NAME.block
		
	
		
        
            . setpeer.sh Exporters peer0
            export CHANNEL_NAME="mangotracechannel"
			peer channel join -b $CHANNEL_NAME.block
		
	
		
        
            . setpeer.sh Importers peer0
            export CHANNEL_NAME="mangotracechannel"
			peer channel join -b $CHANNEL_NAME.block
		
	
	
	
	
		. setpeer.sh APEDA peer0
		export CHANNEL_NAME="mangotracechannel"
		peer channel update -o  orderer.xnet.com:7050 -c $CHANNEL_NAME -f ./mangotracechannelAPEDAMSPAnchor.tx --tls --cafile $ORDERER_CA 
	

	
	
		. setpeer.sh Exporters peer0
		export CHANNEL_NAME="mangotracechannel"
		peer channel update -o  orderer.xnet.com:7050 -c $CHANNEL_NAME -f ./mangotracechannelExportersMSPAnchor.tx --tls --cafile $ORDERER_CA 
	

	
	
		. setpeer.sh Importers peer0
		export CHANNEL_NAME="mangotracechannel"
		peer channel update -o  orderer.xnet.com:7050 -c $CHANNEL_NAME -f ./mangotracechannelImportersMSPAnchor.tx --tls --cafile $ORDERER_CA 
	




