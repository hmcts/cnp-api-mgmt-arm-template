#!/bin/bash
set -e

RESOURCE_GROUP_NAME=$1
APIM_SUBNET_NAME=$2
VNET_NAME=$3
NSG_NAME=$4
        
if [ -z "${RESOURCE_GROUP_NAME}" ] ; then
  echo "Resource Group name is required." 
  exit 1
fi

if [ -z "${APIM_SUBNET_NAME}" ] ; then
  echo "APIM Subnet name is required." 
  exit 1
fi

if [ -z "${VNET_NAME}" ] ; then
  echo "VNET name is required." 
  exit 1
fi

if [ -z "${NSG_NAME}" ] ; then
  echo "NSG name is required." 
  exit 1
fi

az network vnet subnet update -g ${RESOURCE_GROUP_NAME} -n ${APIM_SUBNET_NAME} --vnet-name ${VNET_NAME} --network-security-group ${NSG_NAME} --verbose
echo "The NSG Rule '${NSG_NAME}' has been associate with the subnet '${APIM_SUBNET_NAME}'"
