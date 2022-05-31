# SGT MAAMMAR - 18/02/2022
# Vérification de la clé de registre "AutoWorkplaceJoin" sur toutes les machines accessibles du domaine pour l'OSIC GBL017
# Ce script écrit les résultats dans un fichier ./dump.txt à vérifier après l'exécution du script
# 0 = Clé désactivée, RAS
# 1 = Clé activée, il faut la désactiver
# 2 = Erreur lors de la vérification

# Remplacer 't.maammar' par un autre administrateur du domaine si besoin
$creds = Get-Credential DOMAINE\t.maammar
$ordis = Get-ADComputer -Filter * | Where-Object {$_.Name -Like "UC*"}

foreach($ordi in $ordis) {

$nom = $ordi.Name.ToString()

# Activation de WinRM au cas où
# Cela m'a évité quelques erreurs sur des machines
Invoke-WmiMethod -ComputerName $nom -Namespace root\cimv2  -Class win32_process -Name Create -ArgumentList "winrm quickconfig -quiet " -ErrorAction SilentlyContinue

# Connexion à chaque machine et vérification de la clé
$session = New-PSSession -ComputerName $nom -Credential $creds -ErrorAction SilentlyContinue
$resultat = Invoke-Command -Session $session {Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin -Name "autoWorkplaceJoin" } 

# Écriture des résultats
if ($resultat.autoWorkplaceJoin -eq 0)    {echo "$nom : 0" >> dump.txt}
elseif($resultat.autoWorkplaceJoin -eq 1) {echo "$nom : 1" >> dump.txt}
else                                      {echo "$nom : 2" >> dump.txt}

} 

