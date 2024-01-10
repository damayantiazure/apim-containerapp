
# Deploy the pre requisites : 
az deployment group create --name prerequisites --resource-group apim-containerapp-rg --template-file .\prerequisites.bicep