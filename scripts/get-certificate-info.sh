#!/bin/bash
set -e

CERTIFICATE_NAME=$1     
KEYVAULT_NAME=$2

if [ -z "${CERTIFICATE_NAME}" ] ; then
  echo "Certificate name is required." 
  exit 1
fi

if [ -z "${KEYVAULT_NAME}" ] ; then
  echo "Associated Key Vault name is required." 
  exit 1
fi

CERTDATA=$(az keyvault certificate show  --vault-name ${KEYVAULT_NAME} --name ${CERTIFICATE_NAME})

if [ -z "${CERTDATA}" ] ; then
  echo "Certificate data not available for certificate '${CERTIFICATE_NAME}' in keyvault '${KEYVAULT_NAME}'." 
  exit 1
fi

CERTDATA_THUMBPRINT=$(echo ${CERTDATA} | jq -r .x509ThumbprintHex)
CERTDATA_SUBJECT=$(echo ${CERTDATA} | jq -r .policy.x509CertificateProperties.subject)
CERTDATA_EXPIRY=$(echo ${CERTDATA} | jq -r .attributes.expires)

echo "##vso[task.setvariable variable=Certificate.Thumbprint;issecret=true]${CERTDATA_THUMBPRINT}"
echo "##vso[task.setvariable variable=Certificate.Subject;issecret=true]${CERTDATA_SUBJECT}"
echo "##vso[task.setvariable variable=Certificate.Expiry;issecret=true]${CERTDATA_EXPIRY}"