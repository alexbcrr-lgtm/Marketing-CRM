$outlook = New-Object -ComObject Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")
$namespace.Logon("Outlook", $null, $false, $true)

function Create-Draft($to, $subject, $body) {
    $mail = $outlook.CreateItem(0) # olMailItem
    $mail.To = $to
    $mail.Subject = $subject
    $mail.Body = $body
    $mail.Save()
    Write-Output "Created draft for: $to"
}

$targets = Get-Content "targets.json" | ConvertFrom-Json
$count = 0

foreach ($target in $targets) {
    if ($count -ge 10) { break }
    
    $to = "alex@vectorinstallations.com" # Default for testing or if contact unknown
    if ($target.contact_name) {
        # This is a placeholder since we don't have real emails for everyone yet
        # In a real scenario, we'd lookup or have the email in JSON
    }

    $subject = "Partnership: $($target.company) x Install Champions"
    $body = "Hi $($target.contact_name),`n`nI'm writing from Install Champions. $($target.hook)`n`nWe'd love to support your operations in SoCal.`n`nBest,`nIC_LEADS"
    
    Create-Draft -to $to -subject $subject -body $body
    $count++
}

Write-Output "Batch of $count drafts created."
