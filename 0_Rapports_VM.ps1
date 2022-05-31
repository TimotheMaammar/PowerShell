# SGT MAAMMAR - Stage Hyper-V - 2021
# Lister les VM ainsi que leur(s) snapshot(s) et tous les supprimer si il y en a

$vms = (Get-VM -Name *)

foreach($vm in $vms)
{
    $uptime = ($vm).Uptime.Days.ToString() + " jours " + ($vm).Uptime.Hours.ToString() + " heures " + ($vm).Uptime.Minutes.ToString() + " minutes "
    
    "La VM '" + ($vm).Name + "' est dans l'état '" + ($vm).State + "', est en cours depuis " + $uptime + " et a le statut '" + ($vm).Status + "' !" | Add-Content -Path "T:\Rapports.txt" 

    echo " " | Out-File -Append "T:\Rapports.txt"

    "Elle possède " + ((Get-VMSnapshot -VMName ($vm).Name)).count + " snapshot(s) !" | Add-Content -Path "T:\Rapports.txt"

    foreach($snap in (Get-VMSnapshot -VMName ($vm).Name))
    {
        Get-VMSnapshot -VMName (($vm).Name) | Out-File -Append "T:\Rapports.txt" 
        Get-VMSnapshot -VMName (($vm).Name) | Remove-VMSnapshot
    }


}

echo "Snapshots supprimés !" | Out-File -Append "T:\Rapports.txt"
