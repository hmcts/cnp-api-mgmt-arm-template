# cnp-api-mgmt-arm-template

This repository contains ARM templates for building out an Azure API Managment instance with the following components:

* An API Management Instance
* The CCD DataStore API.
* OAuth Authentication
* API Policies


### Pre-Requsites
The following resources are expected to be in place in order for the API Management instance to be deployed successfully.

* A virtual network
* A subnet
* An OAuth endpoint.

### APIM NSG Rules
As part of this ARM deployment, a NSG will be created which secure the APIM subnet. These NSG rules have been derived from the following Microsoft [Documentation](https://docs.microsoft.com/en-us/azure/api-management/api-management-using-with-vnet#-common-network-configuration-issues).

Please note that not all rules have been applied due to them not being applicable.

|Source / Destination Port(s)|Direction|Transport protocol|Transport protocol|Purpose|
|---|---|---|---|---|
| * / 80, 443|Inbound|TCP|VIRTUAL_NETWORK / VIRTUAL_NETWORK|Client communication to API Management|
|* / 3443|Inbound|TCP|ApiManagement / VIRTUAL_NETWORK|Management endpoint for Azure portal and Powershell|
|* / 80, 443|Outbound|TCP|VIRTUAL_NETWORK / Storage|Dependency on Azure Storage|
|* / 1433|Outbound|TCP|VIRTUAL_NETWORK / SQL|Access to Azure SQL endpoints|
|* / 5672|Outbound|TCP|VIRTUAL_NETWORK / EventHub|Dependency for Log to Event Hub policy and monitoring agent|
|* / 1886|Outbound|TCP|VIRTUAL_NETWORK / INTERNET|Needed to publish Health status to Resource Health|
|* / 443|Outbound|TCP|VIRTUAL_NETWORK / AzureMonitor|Publish Diagnostics Logs and Metrics|
