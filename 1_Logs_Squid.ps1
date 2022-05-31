# SGT MAAMMAR - 18/11/2021
# TARANIS 2021
# Script d'archivage des logs du proxy Squid
# À exécuter en tâche planifiée la nuit sur le serveur hébergeant le proxy

# Formatage de la date de la veille (YYYY-MM-DD)
$annee= (get-date (get-date).AddDays(-1) -UFormat "%Y")
$mois = (get-date (get-date).AddDays(-1) -UFormat "%m")
$jour = (get-date (get-date).AddDays(-1) -UFormat "%d")
$date_veille = "$annee-$mois-$jour"

# Chemins
$src_file = "E:\squid\logs\access.log"
$dst_folder = "E:\squid\logs\Archivage\"
$name = "Logs_Squid_" + $date_veille +".txt"
$dst_file = $dst_folder + $name
$sauvegarde = "\\127.0.0.1\Sauvegardes"

# Squid doit être relancé pour générer un nouveau fichier access.log
Stop-Service -DisplayName "Squid"

Move-Item -Path $src_file -Destination $dst_file

Start-Service -DisplayName "Squid"

Copy-Item -Path $dst_file -Destination $sauvegarde
