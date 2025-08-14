cd "C:\Program Files\Microsoft Azure AD Sync"
dir

Get-ADServiceAccount -Identity "Compte_ADSyncMSA" -Properties *

Get-ADSyncScheduler
Get-ADSyncConnector | Format-Table Name,Type,ConnectorServer
Get-ADSyncConnectorStatistics "NomConnecteur"
Get-ADSyncRule | Out-File -FilePath ".\dump.txt"

Get-Command | Select-String "ADSync"
