
#!/bin/bash
fabric-ca-client enroll  -u https://admin:adminpw@ca.importers.in:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.importers.in-cert.pem 
fabric-ca-client affiliation add importers  -u https://admin:adminpw@ca.importers.in:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.importers.in-cert.pem 
