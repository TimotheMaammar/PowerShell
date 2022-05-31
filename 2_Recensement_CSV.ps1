# SGT MAAMMAR - 09/03/2022
# Script permettant de tester la connexion de tous les ordinateurs du domaine et de les recenser avec MAC, IP, description, OS...
# Le script écrit les résultats dans un fichier texte qui est ensuite converti en .csv (séparateur ';')


# Écriture du titre de chaque colonne dans le futur .csv
echo "NOM ; Ping ; IP ; OS ; Description ; Chemin " >> W:\01-Scripts\Maammar\Extractions\Résultat.txt

# On boucle sur absolument toutes les machines du domaine
foreach($machine in ((Get-ADComputer -Filter *).Name))
{
    

    $ip = ([System.Net.Dns]::GetHostAddresses("$machine")).IPAddressToString
    $os = (Get-ADComputer $machine -Properties *).OperatingSystem
    $description = (Get-ADComputer $machine -Properties *).Description
    $chemin = (Get-ADComputer $machine).DistinguishedName

    # Commande qui fait le test du ping et dont on va utiliser le résultat après grâce à la variable '$?'
    Test-Connection -ComputerName $machine

    if($?)
    { 
        echo "$machine ; PING OK ; $ip ; $os ; $description ; $chemin" >> W:\01-Scripts\Maammar\Extractions\Résultat.txt
    }
    else
    { 
        echo "$machine ; FAIL ; $ip ; $os ; $description ; $chemin" >> W:\01-Scripts\Maammar\Extractions\Résultat.txt
    }

}

# Conversion finale
Import-Csv -Path W:\01-Scripts\Maammar\Extractions\Résultat.txt -Delimiter ';' | Export-Csv -Path W:\01-Scripts\Maammar\Extractions\CSV_Recensement.csv -Delimiter ';'
