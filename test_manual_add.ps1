$outlook = New-Object -ComObject Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")
$namespace.Logon("Outlook", $null, $false, $true)

$drafts = $namespace.GetDefaultFolder(16)
$mail = $drafts.Items.Add(0) # olMailItem
$mail.To = "alex@vectorinstallations.com"
$mail.Subject = "DEBUG TEST: High Intensity Copy"
$mail.Body = "Test Body"
$mail.Save()
Write-Output "Manual Add Success"
