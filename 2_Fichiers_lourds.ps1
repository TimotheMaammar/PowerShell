# SGT MAAMMAR - 02/2022
# Ce script affiche les 100 fichiers les plus lourds contenus dans un dossier et ses sous-dossiers
# À utiliser pour le ménage sur les serveurs de fichiers

$path = Read-Host("Entrez le chemin à scanner : ")

# On boucle tant que le chemin n'est pas valide ou accessible
While ((Test-Path $path) -eq $false) 
{
    Write-Host("Chemin incorrect")
    $path = Read-Host("Entrez le chemin à scanner : ")
} 
   
Get-ChildItem -Path $path -Recurse | Sort-Object -Property Length -Descending | Select -First 100
