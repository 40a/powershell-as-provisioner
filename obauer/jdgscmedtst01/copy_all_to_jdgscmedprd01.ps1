.\copy_all_to_serverXY.ps1 jdgscmedprd01

Copy-Item ..\..\jdg_scripts\jdgscmedprd01\* \\jdgscmedprd01.jdg.co.za\e$\jdg_scripts\jdgscmedprd01 -recurse
Copy-Item ..\..\jdg_scripts\certificates\* \\jdgscmedprd01.jdg.co.za\e$\jdg_scripts\certificates -recurse