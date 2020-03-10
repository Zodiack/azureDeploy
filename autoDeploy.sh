#!/bin/bash

gitrepo=https://github.com/Zodiack/DeplyTest.git
token=3923b23c9ec606bfe9882d1160dfe50f891661a2
webappname=mywebapp$RANDOM
resource = myResourceGroup

# Create a resource group.
az group create --location westeurope --name $resource

# Create an App Service plan in `FREE` tier.
az appservice plan create --name $webappname --resource-group $resource --sku FREE

# Create a web app.
az webapp create --name $webappname --resource-group $resource --plan $webappname

# Configure continuous deployment from GitHub. 
# --git-token parameter is required only once per Azure account (Azure remembers token).
az webapp deployment source config --name $webappname --resource-group $resource \
--repo-url $gitrepo --branch master --git-token $token

# Copy the result of the following command into a browser to see the web app.
echo http://$webappname.azurewebsites.net