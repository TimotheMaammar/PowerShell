# SGT MAAMMAR - 05/04/2022
# Script permettant de décaler d'un mois les dates d'expiration de tous les utilisateurs du domaine
# Fait à la demande du PCAV suite à une recrudescence de problèmes de comptes expirés

# Nom de l'OU contenant tous les utilisateurs
$ou = "OU=XXX,DC=XXX,DC=XXX"

# -notlike ""
$users = Get-ADUser -Filter * -Properties * -SearchBase $ou | Where-Object {$_.AccountExpirationDate -notlike ""} 

foreach($user in $users)
{
    # Technique de conversion de la date d'expiration actuelle
    $old = [System.DateTime]::FromFileTime($user.AccountExpires)
    $new = $old.AddDays(31) # Régler le nombre de jours ici

    Set-ADUser $user.Name -AccountExpirationDate $new # -WhatIf

}

Read-Host("Appuyez sur Entrée pour sortir ")
