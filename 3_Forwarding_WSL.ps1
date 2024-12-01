wsl hostname -I

netsh interface portproxy add v4tov4 listenport=<PORT_WINDOWS> listenaddress=0.0.0.0 connectport=<PORT_LINUX> connectaddress=<IP_LINUX>

netsh interface portproxy show all 
