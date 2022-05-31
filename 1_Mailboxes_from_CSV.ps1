# SGT MAAMMAR - 11/11/2021
# TARANIS 2021
# Création d'utilisateurs AD avec une boîte aux lettres associée
# Ce script utilise les fichiers .xls (à convertir en .csv) fournis par l'OSSI

### Trucs à importer / désactiver si besoin ###########################
#Set-ExecutionPolicy Unrestricted
#Import-Module ActiveDirectory
#Add-PSSnapin *Exchange*
#######################################################################

############### VARIABLES À MODIFIER ##################################
$fichier = "XXX.csv"
$DB = "XXX"
$OU = "OU=X,OU=X,DC=X,DC=X,DC=X"
#######################################################################

if (! (Test-Path $fichier)) {
	echo "Fichier non trouvé"
	exit
	}

# Bien penser à choisir ';' comme délimliteur lors de la conversion du .xls en .csv et à vérifier avec le bloc-notes en cas d'erreur
$csv = Import-Csv $fichier -Delimiter ";" 

$csv | ForEach-Object {

$login = $_.'LOGIN'
$mdp = $_.'PASSWORD' 
$fonction = $_.'FONCTION'
$personne = $_.'PERSONNE'
$mdp_secure = (ConvertTo-SecureString $mdp -AsPlainText -Force)
$mail = $login + "@domaine.fr"

echo $login 
echo $mdp
echo $fonction
echo $personne
echo $mail

New-Mailbox -Database $DB -UserPrincipalName $mail -Name $login -Password $mdp_secure -DisplayName $personne -OrganizationalUnit $OU

}
