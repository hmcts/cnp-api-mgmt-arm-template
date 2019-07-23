#!/bin/bash
set -e

KEYVAULT_NAME=$1
CERTIFICATE_NAME=$2    

if [ -z "${CERTIFICATE_NAME}" ] ; then
  echo "Certificate name is required." 
  exit 1
fi

if [ -z "${KEYVAULT_NAME}" ] ; then
  echo  "Key Vault name is required." 
  exit 1
fi

KEYVAULT_ID=$(az keyvault certificate show --name ${CERTIFICATE_NAME} --vault-name ${KEYVAULT_NAME} --query "sid" --output tsv --verbose`)
echo "##vso[task.setvariable variable=Certificate.KeyvaultId;issecret=true]${KEYVAULT_ID}"