$mbx = Read-Host "Dirección de calendario"
$newcontact = Read-host "User to add"


$users = @();

$users += (Get-CalendarProcessing -Identity $mbx).BookInPolicy;
Write-host "Los siguientes usuarioss poseen permisos en el calendar $mbx"
foreach ($i in $users) {
Get-Recipient $i | select name
}ma
$anotheruser = Get-Mailbox "$newcontact";

$users += $anotheruser.LegacyExchangeDN;



$title    = 'something'
$question = 'Se sumara el siguiente usuario > ' + $anotheruser.name + ' < Are you sure you want to proceed?'

$choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
    Write-Host 'confirmed'
    try{
    Set-CalendarProcessing -Identity $mbx -BookInPolicy $users;
    }
    catch{
    Write-Host "Error: " + $_.Exception.Message
        }
} else {
    Write-Host 'cancelled'
}
