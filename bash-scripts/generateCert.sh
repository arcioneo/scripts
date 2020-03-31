##########
#Generates a certificate from a BASE64 String
##########
#!/bin/bash

###Provide your base path
basePath="SOM_PATH"

base64File="${basePath}/base64"
outJks="${basePath}/OUT.jks"
sampleDer="${basePath}/sample.der"
sampleCert="${basePath}/sample.crt"
keystoreP12="${basePath}/keystore.p12"
serverKey="${basePath}/server.key"

clear

echo "generating JKS file"
base64 --decode ${base64File} > ${outJks}

echo "Exporting .der file"
keytool -export -alias client-access -file ${sampleDer} -keystore ${outJks}

echo "Converting .der file to unencrypted PEM (crt file)"
openssl x509 -inform der -in ${sampleDer} -out ${sampleCert}

echo "Exporting .p12 file"
keytool -importkeystore -srckeystore ${outJks} -destkeystore ${keystoreP12} -deststoretype PKCS12

echo "Converting .p12 file to unencrypted PEM (key file)"
winpty openssl pkcs12 -in ${keystoreP12} -nodes -nocerts -out ${serverKey}

echo "done :)"
