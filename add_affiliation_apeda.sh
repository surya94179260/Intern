
#!/bin/bash
fabric-ca-client enroll  -u https://admin:adminpw@ca.apeda.gov.in:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.apeda.gov.in-cert.pem 
fabric-ca-client affiliation add apeda  -u https://admin:adminpw@ca.apeda.gov.in:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.apeda.gov.in-cert.pem 
