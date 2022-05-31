# SGT MAAMMAR - 02/2022
# Script permettant de nettoyer des boîtes aux lettres données à partir d'un fichier texte
# Ce script est à utiliser sur le serveur Exchange lui-même pour avoir les commandes Powershell du module Exchange

Add-PSSnapin Microsoft.Exchange.Management.Powershell.Snapin # Au cas où

$adresses = Get-Content -Path C:\Users\adm-sys.permanence\Documents\Adresses_à_vider.txt 

foreach($nom in $adresses)
{ 
    # Gaffe aux permissions, bien vérifier que la personne exécutant ce script est dans le groupe "Exchange Organization Administrators"
    Search-Mailbox $nom -DeleteContent -Force  

    if($?) { Write-Host "La boîte $nom a bien été vidée" -BackgroundColor Green }
    else   { Write-Host "Problème avec la boîte $nom" -BackgroundColor Red }

}

Read-Host("Appuyez sur Entrée pour sortir ")

