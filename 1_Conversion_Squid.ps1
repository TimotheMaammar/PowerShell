# SGT MAAMMAR - 11/11/2021
# TARANIS 2021
# Conversion de la liste noire fournie par l'OSSI en lignes ACL Squid

$fichier = "XXX.csv"

if (! (Test-Path $fichier)) {
	echo "Fichier non trouvé"
	exit
	}
	
# Bien penser à choisir ';' comme délimiteur lors de la conversion du .xls en .csv et à vérifier avec le bloc-notes en cas d'erreur
$csv = Import-Csv $fichier -Delimiter ";" 


$csv | ForEach-Object {

$ip = $_.'Adresse IP'
$cidr = $_.'CIDR'
$masque = Conversion($cidr)
Write-Host($ip + "/" + $masque)

}


function Conversion($n) 
{
    switch ($n) 
    {
        0 { $mask = "0.0.0.0"} 
        1 { $mask = "128.0.0.0" } 
        2 { $mask = "192.0.0.0" } 
        3 { $mask = "224.0.0.0" } 
        4 { $mask = "240.0.0.0" } 
        5 { $mask = "248.0.0.0" } 
        6 { $mask = "252.0.0.0" } 
        7 { $mask = "254.0.0.0" } 
        8 { $mask = "255.0.0.0" }
        9 { $mask = "255.128.0.0" }
        10 { $mask = "255.192.0.0" }
        11 { $mask = "255.224.0.0" }
        12 { $mask = "255.240.0.0" }
        13 { $mask = "255.248.0.0" }
        14 { $mask = "255.252.0.0" }
        15 { $mask = "255.254.0.0" }
        16 { $mask = "255.255.0.0" }
        17 { $mask = "255.255.128.0" }
        18 { $mask = "255.255.192.0" }
        19 { $mask = "255.255.224.0" }
        20 { $mask = "255.255.240.0" }
        21 { $mask = "255.255.248.0" }
        22 { $mask = "255.255.252.0" }
        23 { $mask = "255.255.254.0" }
        24 { $mask = "255.255.255.0" }
        25 { $mask = "255.255.255.128" }
        26 { $mask = "255.255.255.192" }
        27 { $mask = "255.255.255.224" }
        28 { $mask = "255.255.255.240" }
        29 { $mask = "255.255.255.248" }
        30 { $mask = "255.255.255.252" }
        31 { $mask = "255.255.255.254" }
        32 { $mask = "255.255.255.255" }
    }
	return $mask
}
