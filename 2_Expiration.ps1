# SGT MAAMMAR - 09/03/2022
# Suppression des utilisateurs désactivés dont la date d'expiration remonte à plus d'un an

$date = ((Get-Date).AddMonths(-12))

# Bien ajouter le '-WhatIf' pour tester avant
Search-ADAccount -SearchBase "OU=XXX,DC=XXX,DC=XXX,DC=XXX,DC=XXX,DC=XXX" -UsersOnly -AccountDisabled | Where-Object {$_.AccountExpirationDate -lt $date } | Remove-ADUser # -WhatIf
