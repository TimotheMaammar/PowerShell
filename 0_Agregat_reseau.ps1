# SGT MAAMMAR - Stage Hyper-V - 2021
# Renommage pertinent de la carte réseau reliée au domaine et création d'un agrégat réseau avec toutes les autres pour améliorer les performances.

# Le domaine était en 172.X.X.X dans ce stage
# On peut aussi vérifier en regardant quelle carte réseau a le nom du domaine dans la liste
Rename-NetAdapter -Name (Get-NetIPAddress -IPAddress 172*).InterfaceAlias -NewName MGMT

# On ne veut que deux cartes dans notre cas
# ‘?’ est un alias pour ‘Where-Object’ 
$membres = (Get-NetAdapter |? Name -NotLike MGMT |select -First 2).Name

# Création de l’agrégat
# D’après le lieutenant le teaming mode idéal serait LACP mais la virtualisation ne gère pas encore cette norme
New-NetLbfoTeam -Name "Agrégat" -TeamMembers $membres -TeamingMode SwitchIndependent -LoadBalancingAlgorithm IPAddresses -Confirm:$false
