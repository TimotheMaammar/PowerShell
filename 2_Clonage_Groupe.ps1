# SGT MAAMMAR - 05/03/2022
# Script permettant de copier tous les groupes (fenêtre "Membre de") d'un groupe AD sur un autre
# À utiliser pour toutes les DEMSIC où le personnel demande les mêmes droits que quelqu'un d'autre


$source = Get-ADGroup -Identity (Read-Host("Entrez le groupe source "))

$destination = Get-ADGroup -Identity (Read-Host("Entrez le groupe de destination "))


$membres = Get-ADPrincipalGroupMembership $source.SAMAccountName

foreach ($membre in $membres) {
    Write-Host "Ajout du groupe " $membre.SAMAccountName " au groupe " $destination.SAMAccountName
    Add-ADGroupMember -Identity $membre.SAMAccountName -Members $destination.SAMAccountName  
}

Read-Host("Appuyez sur Entrée pour sortir ")
