# SGT MAAMMAR - Stage Hyper-V - 2021
# Création d'un cluster

New-Cluster -Node VM-Noeud-01.hyper-v.cours.virtu.fr, VM-Noeud-03.hyper-v.cours.virtu.fr, VM-Noeud-05.hyper-v.cours.virtu.fr, VM-Noeud-07.hyper-v.cours.virtu.fr -Name "Test"

Get-Cluster -Name "Test"

Test-Cluster -ReportName "Test"

Start-Cluster -Name "Test"

