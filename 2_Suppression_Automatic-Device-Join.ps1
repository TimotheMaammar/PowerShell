# SGT MAAMMAR - 22/02/2022
# Suppression de la tâche planifiée "Automatic-Device-Join" sur toutes les machines joignables du domaine
# Cette tâche génère plein de faux-positifs au SOC
# Elle semble s'activer puis se désactiver toute seule, même avec la GPO de désactivation et la clé de registre autoWorkplaceJoin à 0

$ordis = Get-ADComputer -Filter * | Where-Object {$_.Name -Like "UC*"}
$path = "\Microsoft\Windows\Workplace Join\Automatic-Device-Join" # Chemin de la tâche

foreach($ordi in $ordis) {

    $nom = $ordi.Name.ToString()
    echo $nom

    # L'utilitaire schtasks permet la gestion des tâches planifiées
    # Taper "schtasks /?" pour voir toutes les options
    schtasks /delete /s $nom /tn $path /f 
} 


