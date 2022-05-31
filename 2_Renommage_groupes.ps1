# SGT MAAMMAR - 14/03/2022
# Renommage des groupes AD
# Une énorme partie des groupes DL s'appelait 'GAO_GL_...' au lieu de 'GAO_DL...' et c'était gênant pour l'administration en plus d'être moche
# Ce script les renomme massivement, j'ai choisi de procéder OU par OU pour plus de sécurité et de propreté
# Cela ne pose pas de problème pour l'arborescence puisque le SID du groupe ne change pas, seul le nom "superficiel" est modifié
# Le nom Pre-Windows 2000 n'est pas modifié par ce script donc c'est normal qu'ils ne correspondent plus et que le nom Pre-Windows 2000 soit toujours en "GAO_GL_..."
# Quand le groupe existe déjà il suffit de vérifier lequel est utilisé dans le DFS et de supprimer l'autre avant de relancer le script


# Nom de l'OU
$ou = "OU=XXX,DC=XXX,DC=XXX"

$groupes = Get-ADGroup -Filter {Name -like 'GAO_GL_*'} -SearchBase $ou

foreach($groupe in $groupes) {

    $nouveau_nom = $groupe.Name.Replace("GAO_GL_", "GAO_DL_")
    echo $groupe.Name

    try
    {
        Rename-ADObject -Identity $groupe -NewName $nouveau_nom # -WhatIf
    }
    catch
    {
        echo "$nouveau_nom existe déjà !"
    }
    
    # Extraction de tous les groupes modifiés par ce script au cas où il faudrait faire machine arrière
    echo $groupe.Name >> W:\01-Scripts\Maammar\Extractions\Groupes_DL_renommés.txt

}
