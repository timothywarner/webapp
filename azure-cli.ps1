break
# #############################################################################
# Azure CLI v2.0
# AUTHOR:  Tim Warner
# EMAIL: timothy-warner@pluralsight.com
# TWITTER: @TechTrainerTim
# #############################################################################
 
# Press CTRL+M to expand/collapse regions

# Install Azure CLI v2.0

# Download and install the binaries 
Start-Process https://www.python.org/downloads/

# Use Python Package Manager to install the CLI
pip install --user azure-cli

# Make sure to update your PATH so you can launch az.bat
Test-Path C:\Users\Tim\AppData\Roaming\Python\Python36\Scripts
Test-Path C:\Users\Tim\AppData\Roaming\Python\Scripts

# Log in
az
az login
start-process https://aka.ms/devicelogin
# Set your context
az
az account -h
az account list --all -o table
az account set -h
az account set --subscription 'tim-2017'

az account list -h

az account list -o table

# App Service
az appservice -h

az appservice web -h

az appservice web list -h 

# You can run JMESPath ("jamespath") queries; this is a query language for JSON (jmespath.org)

az appservice web list --query "[?state=='Running']"

az appservice web list --query "[].{ hostName: defaultHostName, state: state }"

az vm list --output table --query "[?contains(resourceGroup,'MY')]" 