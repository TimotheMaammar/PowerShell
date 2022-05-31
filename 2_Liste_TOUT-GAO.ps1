# SGT MAAMMAR - 20/03/2022
# Script permettant de sortir des adresses du groupe de distribution dynamique "TOUT-GAO" depuis un fichier
# Bien mettre une adresse par ligne dans le fichier si vous copiez/coller la liste depuis un mail
# C'est au final une simple modification de l'attribut personnalisé n°1 puisque le groupe dynamique se base dessus
# SCRIPT À LANCER SUR UN SERVEUR EXCHANGE


# Chemin du fichier contenant les adresses
$fichier = Get-Content W:\01-Scripts\Maammar\Extractions\Adresses_à_exclure.txt

foreach($adresse in $fichier)
{
    echo $adresse
    $identity = ($adresse).Split('@')[0] # Permet d'avoir la partie avant '@'

    # On remplace l'ancien attribut n°1 qui contenait "GAO" par "X"
    # De ce fait la liste "TOUT-GAO" ne contiendra plus l'adresse puisque l'une des conditions ne sera plus respectée
    Set-MailBox -Identity $identity -CustomAttribute1 "X"

}

# Utiliser cette commande pour voir le détail des conditions du groupe rapidement sans passer par l'ECP :

# Get-DynamicDistributionGroup TOUT-GAO | Select-Object -ExpandProperty RecipientFilter

# Chercher les conditions ressemblant à "CustomAttribute1 -eq 'GAO'"
