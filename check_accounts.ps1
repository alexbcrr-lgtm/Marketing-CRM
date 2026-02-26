$ol = New-Object -ComObject Outlook.Application; $ol.Session.Accounts | ForEach-Object { Write-Host $_.SmtpAddress }
