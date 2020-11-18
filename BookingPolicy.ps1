
$agendas = "S3_P1ComedorPresidencia@prismamp.com","DT_P3_S1SalaDirectorio@prismamp.com","S3_P1_SalaFlotante@prismamp.com"
$Rooms = foreach ($i in $agendas) { (Get-Mailbox "$i").alias}

foreach ($room in $rooms)
    {
        $realname = (Get-CalendarProcessing $room).bookinpolicy
        $Permisos = foreach ($i in $realname) {(Get-ADObject -filter {Legacyexchangedn -eq $i}).name}
        Write-Host "Permisos sobre: $room" -ForegroundColor Yellow
        Write-Output $Permisos

    }
