<#
    .SYNOPSIS
    Deploys a resource group with OpenVPN installed on an Ubuntu VM
    .EXAMPLE
    deploy.ps1 -location "westeurope" -dns "ubervpn" -username "agent" -password "P#ssw0rd"
#>

param(
    [string]$resourceGroup  = "self-vpn",
    [string]$username       = (Read-Host -Prompt 'Enter a username (i.e. agent)'),
    [string]$password       = (Read-Host -Prompt 'Enter a password (i.e. P#ssw0rd)'),
    [string]$location       = (Read-Host -Prompt 'Enter a region code (i.e. westeurope)'),
    [string]$dns            = (Read-Host -Prompt 'Enter a dns name prefix (<dns>.westeurope.cloudapp.azure.com)')
)

Write-Host "Logging in..."
az login

$resourceGroupName = "$resourceGroup-$location"
Write-Host "Creating resource group: '$resourceGroupName' in $location"
az group create --location $location --name $resourceGroupName

Write-Host "Starting deployment..."
az group deployment create `
    --name VpnDeployment `
    --resource-group $resourceGroupName `
    --template-file template.json `
    --parameters parameters.json `
    --parameters `
        username=$username `
        password=$password `
        dns=$dns

$serverFqdn = az group deployment show -g $resourceGroupName -n VpnDeployment --query properties.outputs.resourceID.value

if ($serverFqdn) {
    Write-Host "---------------------------------------------"
    Write-Host "Your VPN Server is now ready on: $serverFqdn"
    Set-Clipboard -Value $password
    Write-Host "Your username is $username and password is on clipboard"
    Write-Host "---------------------------------------------"
}