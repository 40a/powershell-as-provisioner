$source_server = "jdgscmedprd00"
$title = "This script removes ALL content from local server and import content and users from $source_server"
$message = "Do you want to continue?"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
    "All content and users on the local host will be deleted and the content and users from $source_server will be imported"

$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
    "Aborting."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

$result = $host.ui.PromptForChoice($title, $message, $options, 0)

switch ($result)
    {
        0 { .\cm7_import_content_from_serverXY.ps1 $source_server }
        1 {"You selected No. Aborting."}
    }