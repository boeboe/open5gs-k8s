#!/usr/bin/env bash

CA_CERT_DIR=./ca
F5GC_WEBUI_CERT_DIR=./open5gs-webui
CERT_DOMAIN_NAME=open5gs-webui.udf-demo.org

echo "Generate a Server Certificate for open5gs-webui"
openssl genrsa -out ${F5GC_WEBUI_CERT_DIR}/open5gs-webui.key 4096
openssl req -sha512 -new \
    -subj "/C=BE/ST=Mechelen/L=Hever/O=F5/OU=Presales/CN=${CERT_DOMAIN_NAME}" \
    -key ${F5GC_WEBUI_CERT_DIR}/open5gs-webui.key \
    -out ${F5GC_WEBUI_CERT_DIR}/open5gs-webui.csr
cat > ${F5GC_WEBUI_CERT_DIR}/open5gs-webui-v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=open5gs-webui.udf-demo.org
DNS.2=udf-demo.org
DNS.3=open5gs-webui
DNS.4=localhost
IP.1=10.1.1.4
IP.2=10.1.1.5
IP.3=10.1.1.6
IP.4=10.1.1.7
IP.5=10.1.1.8
IP.6=10.1.1.9
IP.7=127.0.0.1
EOF
openssl x509 -req -sha512 -days 3650 \
    -extfile ${F5GC_WEBUI_CERT_DIR}/open5gs-webui-v3.ext \
    -CA ${CA_CERT_DIR}/ca.crt \
    -CAkey ${CA_CERT_DIR}/ca.key \
    -CAcreateserial \
    -in ${F5GC_WEBUI_CERT_DIR}/open5gs-webui.csr \
    -out ${F5GC_WEBUI_CERT_DIR}/open5gs-webui.crt
    
openssl x509 -inform PEM -in ${F5GC_WEBUI_CERT_DIR}/open5gs-webui.crt -out ${F5GC_WEBUI_CERT_DIR}/open5gs-webui.cert
openssl pkcs12 -export -out ${F5GC_WEBUI_CERT_DIR}/open5gs-webui.pfx -inkey ${F5GC_WEBUI_CERT_DIR}/open5gs-webui.key -in ${F5GC_WEBUI_CERT_DIR}/open5gs-webui.crt
