# SGT MAAMMAR - Stage Hyper-V - 2021
# Paramétrage initial

Import-Module Hyper-V 


# Autoriser les migrations
Enable-VMMigration

# Permettre les migrations depuis n’importe où
Set-VMHost -UseAnyNetworkForMigration $True

# Kerberos pour l’authentification parce qu’on est dans un domaine AD
Set-VMHost -VirtualMachineMigrationAuthenticationType Kerberos

# Session étendue => Grand écran, copier/coller possible entre différentes VM
Set-VMHost -EnableEnhancedSessionMode $True

# Emplacement par défaut des disques virtuels
Set-VMHost -VirtualHardDiskPath "T:\Hyper-V\Disks"

# Emplacement par défaut des fichiers de configuration des VM
Set-VMHost -VirtualMachinePath "T:\Hyper-V\Machines"


