# SGT MAAMMAR - 14/04/2022
# Script permettant de trouver où sont liées toutes les GPO existantes
# Ce script permet de repérer en un coup d'oeil quelles GPO ne servent à rien
# Utile pour le ménage


# On récupère tous les GUID 
$liste = (Get-GPO -All).Id

foreach($id in $liste)
{
    # On génère un rapport XML pour chaque GPO
    # Cela permettra ensuite d'accéder à beaucoup d'attributs intéressants
    [XML]$XML = Get-GPOReport -ReportType XML -Guid $id

    foreach($i in $XML)
    {
        Write-Host $i.GPO.Name -BackgroundColor Green
        echo $i.GPO.LinksTo.SOMPath
    }
}
