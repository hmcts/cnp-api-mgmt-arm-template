#!/bin/bash
set -e

APIM_NAME=$1     
RESOURCE_GROUP_NAME=$2        
KEYVAULT_NAME=$3

if [ -z "${RESOURCE_GROUP_NAME}" ] ; then
  echo "Resource Group name is required." 
  exit 1
fi

if [ -z "${APIM_NAME}" ] ; then
  echo "API Management instance name is required." 
  exit 1
fi

if [ -z "${KEYVAULT_NAME}" ] ; then
  echo "Associated Key Vault name is required." 
  exit 1
fi

MI_PRINCIPAL_ID=$(az resource list --resource-type 'Microsoft.ApiManagement/service' --resource-group ${RESOURCE_GROUP_NAME} --query "[?name=='${APIM_NAME}'].identity.principalId" --output tsv)

if [ -z "${MI_PRINCIPAL_ID}" ] ; then
  echo "Managed Identity not enabled for the requested API Management '${APIM_NAME}' instance." 
  exit 1
fi

az keyvault set-policy -n ${KEYVAULT_NAME} --object-id ${MI_PRINCIPAL_ID} --certificate-permissions get list
echo "A certificates policy for the Managed Identity '${APIM_NAME}' has been added to Keyvault '${KEYVAULT_NAME}'"