#!/bin/sh
# Description   : Deploys a resource group with OpenVPN installed on an Ubuntu VM
# Example       : deploy.ps1 -location "westeurope" -dns "ubervpn" -username "agent" -password "P#ssw0rd"

resourceGroup="self-vpn"

read -p "Enter a username (i.e. agent): " username
read -sp "Enter a password (i.e. P#ssw0rd): " password
echo
read -p "Enter a region code (i.e. westeurope): " location
read -p "Enter a dns name prefix (<dns>.westeurope.cloudapp.azure.com): " dns

az login

resourceGroupName="$resourceGroup-$location"
echo "Creating resource group: '$resourceGroupName' in $location"
az group create --location $location --name $resourceGroupName

echo "Starting deployment..."
az group deployment create \
--name VpnDeployment \
--resource-group $resourceGroupName \
--template-file template.json \
--parameters parameters.json \
--parameters \
username=$username \
password=$password \
dns=$dns

serverFqdn=`az group deployment show -g $resourceGroupName -n VpnDeployment --query properties.outputs.resourceID.value`

if [ -n $serverFqdn ]
then
    echo "---------------------------------------------"
    echo "Your VPN Server is now ready on: $serverFqdn"
    echo $password | pbcopy
    echo "Your username is $username and password is on clipboard"
    echo "---------------------------------------------"
else
    echo "Failed to create resources..."
fi