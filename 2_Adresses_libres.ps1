# SGT MAAMMAR - 02/04/2022
# Script permettant de connaître toutes les adresses IP libres dans les plages principales du domaine
# Le script se base sur l'état du DNS au moment de l'exécution
# Bien vérifier l'adresse en faisant un ping avant de la donner aux Helpdesk

$dc = "XXX"
$zone = "XXX.XXX.XXX"
$plage1 = "1.2.3."
$plage2 = "2.3.4."
$plage3 = "3.4.5."

$tableau1 = @()
$tableau2 = @()
$tableau3 = @()

# La conversion en objet de type [Version] est une astuce pour obtenir les IP rangées par valeur et pas dans un ordre lexicographique
$adresses_presentes = (Get-DnsServerResourceRecord -ComputerName $dc -ZoneName $zone -RRType A).RecordData | Sort-Object {[Version]$_.IPv4Address.ToString() }

# Boucle sur toutes les adresses de 2 à 254
# On ajoute toutes celles qui ne sont pas dans le DNS dans les différents tableaux
for($i=2;$i -lt 255;$i++)
{
    $adresse1 = $plage1+$i.ToString()
    $adresse2 = $plage2+$i.ToString()
    $adresse3 = $plage3+$i.ToString()

    if(!(($adresses_presentes.IPv4Address).Contains($adresse1)))
    {
        $tableau1 += $adresse1
    }

    if(!(($adresses_presentes.IPv4Address).Contains($adresse2)))
    {
        $tableau2 += $adresse2
    }

    if(!(($adresses_presentes.IPv4Address).Contains($adresse3)))
    {
        $tableau3 += $adresse3
    }

}

# Affichage des 100 premières parce que cela suffit largement
for($i=0;$i -lt 100;$i++)
{
    [PSCustomObject]@{

    Plage_1 = $tableau1[$i]
    Plage_2 = $tableau2[$i]
    Plage_3 = $tableau3[$i]

    }
}
