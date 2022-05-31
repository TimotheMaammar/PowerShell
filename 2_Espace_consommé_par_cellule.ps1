# SGT MAAMMAR - 13/03/2022
# Script calculant le poids de chaque sous-dossier dans le partage public, suite à la demande du CO GTRS
# Ce script est très long à exécuter et les résultats sont approximatifs (à quelques Go près) à cause de quelques fichiers au nom trop long qui renvoient des erreurs
# Retirer '-ErrorAction SilentlyContinue' à la ligne 15 pour voir ces erreurs



# Remplacer 'T:\' par 'S:\' pour avoir le partage des cellules au lieu du partage public
$dossiers = Get-ChildItem 'T:\'

foreach($dossier in $dossiers)
{

echo $dossier.FullName

# Ligne de calcul qui descend récursivement au bout de chaque sous-dossier et fait la somme de ce qu'elle trouve
"{0:N2} GB" -f ((Get-ChildItem $dossier.FullName -Recurse -Force | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum / 1GB)

}

