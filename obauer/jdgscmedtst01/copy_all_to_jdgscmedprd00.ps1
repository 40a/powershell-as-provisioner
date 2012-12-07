.\copy_all_to_serverXY.ps1 jdgscmedprd00

Copy-Item ..\..\jdg_scripts\jdgscmedprd00\* \\jdgscmedprd00.jdg.co.za\e$\jdg_scripts\jdgscmedprd00 -recurse
Copy-Item ..\..\jdg_scripts\certificates\* \\jdgscmedprd00.jdg.co.za\e$\jdg_scripts\certificates -recurse