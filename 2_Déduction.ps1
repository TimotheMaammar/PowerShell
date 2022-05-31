# SGT MAAMMAR - 04/04/2022
# Script permettant de "déduire" l'emplacement le plus probable des machines non-rangées dans l'AD
# Le script vérifie d'abord quelles machines ont les partages administratifs ouverts
# Il donne ensuite la liste des profils contenus dans \C$\Users ainsi que leurs groupes (c'est là que l'on trouvera les fonctions et donc les zones)
# J'ai aussi ajouté la date de la dernière connexion de chaque utilisateur pour permettre de trier de manière très fiable et d'ignorer les plus anciens profils
# Bien transmettre les informations aux Helpdesk pour leur suivi
# Script fait dans le cadre du recensement des stations pour le désengagement


# OU à modifier si besoin
$ou = "OU=XXX,OU=XXX,DC=XXX,DC=XXX"

# Liste des ordinateurs contenus dans l'OU elle-même, mais pas en-dessous, puisque l'on cherche justement les non-rangés
# Retirer le "-SearchScope OneLevel" si besoin de descendre récursivement dans les sous-OU
$ordis = (Get-ADComputer -Filter * -SearchBase $ou -SearchScope OneLevel | Where-Object {$_.Name -like "UC*"}).Name

# Liste des profils à ignorer pour gagner du temps et de la visibilité sur l'affichage
$useless = "Administrateur","Public","helpdesk","t.maammar"

# Tableau vide que l'on remplira avec les machines accessibles
$partages_accessibles = @()

# Cette boucle va déterminer quelles machines ont le partage administratif C$\ ouvert
foreach($ordi in $ordis)
{
    try 
    {
        $users = Get-ChildItem "\\$ordi\C$\Users" -ErrorAction Stop
        if($?) 
        { 
            $partages_accessibles += $ordi
            Write-Host "Partage C$ accessible sur $ordi" -BackgroundColor Green
        }
    }
    catch
    {
        Write-Host "Partage C$ inaccessible sur $ordi" -BackgroundColor Red
    }
    
}

# On boucle sur les machines dont le partage est ouvert et on va chercher les informations voulues
foreach($ordi in $partages_accessibles)
{
    Write-Host "Machine $ordi" -BackgroundColor Yellow

    $users = Get-ChildItem "\\$ordi\C$\Users" -ErrorAction Stop

    foreach($user in $users)
    {
        # On retire les comptes qui ne sont pas pertinents avant de tout afficher
        if($user.Name -inotin $useless)
        {
            echo $user.Name

            echo "Groupes de $user :"
            echo (Get-ADPrincipalGroupMembership $user.Name).distinguishedName

            echo "Dernier login de $user : "
            echo (Get-ADUser $user.Name -Properties LastLogonDate).LastLogonDate      
        } 
    }
}

Read-Host("Appuyez sur Entrée pour sortir ")
