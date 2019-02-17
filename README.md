# OpenVPN Access Server on Azure
Deploy OpenVPN Access Server on Azure via Azure Resource Manager(ARM) template.

## Prepare
- Install Azure Command Line Interface(CLI) `az` from [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest).
- Get a [free Azure account](https://azure.microsoft.com/en-us/free/) if you haven't got one yet.

## Deploy
Run `deploy.ps1` or `sh deploy.sh` on a terminal window.

```sh
> sh deploy.sh
...
---------------------------------------------
Your VPN Server is now ready on: "https://myopenvpn.southcentralus.cloudapp.azure.com:943"
Your username is agent and password is on clipboard
---------------------------------------------
```

## Use
Go to the URL on your device and login to download the vpn profiles.

OpenVPN clients:
- [Android](https://play.google.com/store/apps/details?id=de.blinkt.openvpn)
- [iOS](https://itunes.apple.com/us/app/openvpn-connect/id590379981?mt=8)
- [MacOS Guide](https://openvpn.net/vpn-server-resources/installation-guide-for-openvpn-connect-client-on-macos/)
- [Windows Guide](https://openvpn.net/vpn-server-resources/installation-guide-for-openvpn-connect-client-on-windows/)
