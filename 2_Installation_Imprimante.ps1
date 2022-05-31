# SGT MAAMMAR - 28/03/2022
# Script permettant d'installer une imprimante spécifique et de la mettre comme imprimante par défaut
# Fournir ce script à la cellule Helpdesk pour leur éviter des déplacements

# Si l'imprimante est répertoriée sur le serveur d'impression, juste faire directement : 
# Add-Printer -ConnectionName \\Serveur\Imprimante 

### Variables à adapter
# Le nom du port est arbitraire mais il vaut mieux en mettre un propre pour la sémantique
# Le nom du driver se retrouve facilement en essayant d'ajouter l'imprimante manuellement avant
$ip = "X.X.X.X"
$nom = "XXX"
$nom_port = "XXX"
$driver = "XXX"

try 
{
    # Le "-ErrorAction Stop" est obligatoire pour attraper l'exception dans le catch puisqu'elle est non-bloquante par défaut
    Add-PrinterPort -Name $nom_port -PrinterHostAddress $ip -ErrorAction Stop 
}
catch ### [Microsoft.Management.Infrastructure.CimException] 
{ 
    if($_ -like "*existe déjà.*")
    {
        echo "Le port $ip existe déjà."
    }
    else 
    { 
        echo "Erreur indéterminée lors de l'ajout du port." 
    }
}

try 
{
    Add-Printer -Name $nom -PortName $nom_port -DriverName $driver -ErrorAction Stop  
}
catch ### [Microsoft.Management.Infrastructure.CimException] 
{
    if($_ -like "*existe déjà.*")
    {
        echo "L'imprimante $nom existe déjà."
    }
    else 
    { 
        echo "Erreur indéterminée lors de l'ajout de l'imprimante." 
    }
    
}

# Commande permettant de mettre l'imprimante par défaut
Get-CimInstance -Class CIM_Printer | Where {$_.Name -eq $nom } | Invoke-CimMethod -MethodName SetDefaultPrinter | Out-Null

