curl.exe -L -o "C:\Tools\bloodhound-cli-windows-amd64.zip" https://github.com/SpecterOps/bloodhound-cli/releases/latest/download/bloodhound-cli-windows-amd64.zip
cd "C:\Tools"; tar -xf bloodhound-cli-windows-amd64.zip

"C:\Program Files\Docker\Docker\frontend\Docker Desktop.exe"

.\bloodhound-cli install
.\bloodhound-cli config get default_password

curl "http://127.0.0.1:8080/ui/login"
