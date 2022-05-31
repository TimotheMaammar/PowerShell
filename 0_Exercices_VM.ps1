# SGT MAAMMAR - Stage Hyper-V - 2021
# Exercices pratiques


### Ajouter un seul vCPU à une VM

Set-VMProcessor -VMName "VM1_01" -Count $($(Get-VM -VMName "VM1_01" | Get-VMProcessor).Count + 1)


### Créer des lots de VM

for($i=0; $i -lt 5; $i++)
{
    New-VHD -Path "T:\Hyper-V\Disks\disque$i.vhdx" -SizeBytes 30GB -Dynamic

    New-VM -Name "VM_$i" -Generation 2 -MemoryStartupBytes 1024MB -VHDPath "T:\Hyper-V\Disks\disque$i.vhdx"
}


### Ajouter le boot sur image ISO par défaut

Get-VM "VM1_01" | Set-VMFirmware -FirstBootDevice $(Get-VM "VM1_01" | Get-VMDvdDrive) # Utiliser Set-VMBios si Génération 1


### Démarrer automatiquement les VM après leur création :

Get-VM -VMName * | Set-VM -AutomaticStartAction Start


### Faire rentrer les caractéristiques d’une VM à l'utilisateur : 

echo "Entrez le nombre de processeurs désiré :" 
$nb_cpu = Read-Host
Set-VMProcessor -VMName "VM1_01" -Count $nb_cpu

$secure_boot = Read-Host("Voulez-vous activer le SecureBoot ? (O/N)")
while(($secure_boot -ne "O") -and ($secure_boot -ne "N"))
{
    if($secure_boot -eq "O")
     {
        Get-VM -VMName "VM1_01" | Set-VMFirmware -EnableSecureBoot On
     }
    else
    {
        Get-VM -VMName "VM1_01" | Set-VMFirmware -EnableSecureBoot Off
    }
}


$ram = read-Host("Entrez la RAM désirée en MB")
Set-VMMemory "VM1_01" -DynamicMemoryEnabled $false -StartupBytes (($ram - 1KB + 1KB) * 1024 * 1024)


echo "Tapez le nom du switch que vous voulez connecter à la VM : "

$i=0
foreach($switch in (Get-VMSwitch *))
{
    $i++
    $ligne = $i.ToString() + " : " + (($switch).Name).ToString()
    echo $ligne
}

$choix = Read-Host(" ")

try
{
    Get-VMSwitch $choix | Connect-VMNetworkAdapter -VMName "VM1_01"
}
catch
{ 
    "Erreur lors de l'ajout du switch !" 
}

