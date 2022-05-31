# SGT MAAMMAR - Stage Hyper-V - 2021
# Création d’un pool de stockage avec trois disques et un en Hot Spare.
# On doit séparer la création du pool en deux étapes si il y a deux types de disques différents
# Impossible de faire autrement sur Powershell


# Trois premiers
$disques_1 = (Get-PhysicalDisk -CanPool $True) | Select-Object -First 3

# Dernier
$disques_2 = (Get-PhysicalDisk -CanPool $True) | Select-Object -First (Get-PhysicalDisk).count -1


# Création d’un pool avec les trois premiers disques
New-StoragePool -FriendlyName "POOL" -StorageSubSystemName (Get-StorageSubSystem).Name  -PhysicalDisks $disques_1 

# Ajout du dernier disque
Add-PhysicalDisk -StoragePoolFriendlyName "POOL" -PhysicalDisks $disques_2 -Usage HotSpare

# Création du disque virtuel se basant sur le pool
# Simple = RAID 0
# Fixed = Taille fixe
New-VirtualDisk -FriendlyName "VDISK" -StoragePoolFriendlyName "POOL" -ResiliencySettingName Simple -ProvisioningType Fixed -UseMaximumSize

# Création du volume et association à une lettre
# "| Initialize-Disk" évite d’avoir des problèmes de disque hors-ligne 
New-Volume -DriveLetter T -Disk (Get-Disk -FriendlyName "VDISK") -FriendlyName "VOLUME_POOL" -FileSystem ReFS | Initialize-Disk

# Formatage classique
Format-Volume -DriveLetter T

