
#!/bin/bash
fabric-ca-client enroll  -u https://admin:adminpw@ca.exporters.in:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.exporters.in-cert.pem 
fabric-ca-client affiliation add exporters  -u https://admin:adminpw@ca.exporters.in:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.exporters.in-cert.pem 
