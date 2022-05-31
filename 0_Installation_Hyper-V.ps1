# SGT MAAMMAR - Stage Hyper-V - 2021
# Installation d’Hyper-V

# L’option IncludeManagementTools apporte la console graphique mais aussi les commandes Powershell associées et c'est très important
Install-WindowsFeature -Name Hyper-V -ComputerName $env:COMPUTERNAME -IncludeManagementTools

# Ligne utile pour vérifier ce qui est installé
Get-WindowsFeature |? InstallState -Like Installed

