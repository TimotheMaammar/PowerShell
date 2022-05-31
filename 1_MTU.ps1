# SGT MAAMMAR - 22/11/2021
# TARANIS 2021
# Changement du MTU
# Un peu plus rapide qu'en cherchant dans le registre mais pas très utile
# C'est surtout un bon exemple de navigation dans le registre avec Powershell


$interfaces = @()
$i=0

# Chemin du registre qui contient les interfaces dans lesquelles on doit mettre le MTU, trouvable sur Internet
$path = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\"

# On se place sur le bon chemin
Set-Location -Path $path

# On boucle sur toutes les interfaces existantes pour récupérer les informations
Get-ChildItem | ForEach-Object {
    $i+=1
    $mtu_actuel = "Non défini"
    try 
    {  
        $leaf = Split-Path -Path $_.Name -Leaf
        $interfaces += $leaf
        $ip = Get-ItemPropertyValue -Name "IPAddress" -Path $leaf
        $mtu_actuel = Get-ItemPropertyValue -Name "MTU" -Path $leaf

    }
    catch {}
    finally
    {
        Write-Host("#####################") -BackgroundColor Black -ForegroundColor White
        Write-Host("Interface numéro " + $i) -BackgroundColor Black -ForegroundColor White
        Write-Host("IP = " + $ip) -BackgroundColor Black -ForegroundColor White
        Write-Host("MTU = " + $mtu_actuel) -BackgroundColor Black -ForegroundColor White
        Write-Host("#####################") -BackgroundColor Black -ForegroundColor White
        Write-Host("`n")    
    }

}


# On demande à l'utilisateur de donner l'interface qu'il souhaite modifier
# Tant que le chiffre n'est pas entre 1 et le nombre d'interfaces, on lui redemande
Do
{
    try
    {
        [UInt16]$ref = Read-Host("Entrez le numéro de l'interface à modifier, entre 1 et $i")
    }
    catch{ continue }

} Until(($ref -ge 1) -and ($ref -le $i))

# On demande à l'utilisateur de rentrer le MTU désiré
# Tant qu'il n'est pas compris entre 0 et 10 000, on lui redemande
Do
{
    try
    {
        [UInt16]$mtu = Read-Host("Entrez le nouveau MTU, entre 0 et 10 000 :")
    }
    catch{ continue }

} Until(($mtu -gt 0) -and ($mtu -lt 10000))

 
# Création du DWORD, on tente de le détruire avant au cas où il existait déjà
# Détruire puis créer semble bien plus efficace que passer par 'Set-ItemProperty'
try
{
Remove-ItemProperty -Name "MTU" -Path $interfaces[($ref -1)] 
}
catch {}

New-ItemProperty -Name "MTU" -Value $mtu -Path $interfaces[($ref -1)] -PropertyType DWORD
