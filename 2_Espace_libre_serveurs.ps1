# SGT MAAMMAR - 13/03/2022
# Script permettant de déterminer l'espace libre sur chaque serveur

$serveurs = Get-ADComputer -Filter "Name -like 'XXX*'"

foreach($serveur in $serveurs)
{

  echo $serveur.Name

  # Partitions C, D et F
  Invoke-Command -ComputerName $serveur.Name {Get-PSDrive -Name C,D,F} -ErrorAction SilentlyContinue 

}
