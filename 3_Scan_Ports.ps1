$adresse = $args[0]


1..1024 | % {echo ((New-Object Net.Sockets.TcpClient).Connect($adresse, $_)) "Le port TCP $_ est ouvert sur l'adresse $adresse"} 2>$null
