# SGT MAAMMAR - Stage Hyper-V - 2021
# Création d'une VM classique de génération 2 avec 2048 Go de RAM

# Import conditionnel
$module =(Get-Module -Name Hyper-V).count
if($module -eq 0)
    {
        Import-Module Hyper-V
    }


$name = "VM_Powershell"
$iso = "C:\chemin\vers\image.iso"
$disque = "T:\Hyper-V\Disks\VM1_PS.vhdx"

# Création d’un disque
New-VHD -Path $disque -SizeBytes 100GB -Dynamic

# Création d’une VM en précisant quelques options et le disque
New-VM -Name $name -Generation 2 -MemoryStartupBytes 2048MB -VHDPath $disque

# Montage de l'image ISO
Set-VMDvdDrive -VMName $name -Path $iso

# Nom de la carte réseau
$cr = (Get-NetAdapter -Name AGREGAT_TEST).Name 

# Création d'un switch virtuel
$switch = New-VMSwitch -Name "Switch_PWS" -NetAdapterName $cr 

# Association du switch à la VM
Get-VMSwitch "Switch_PWS" | Connect-VMNetworkAdapter -VMName $name 



