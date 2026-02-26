$outlook = New-Object -ComObject Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")
$namespace.Logon("Outlook", $null, $false, $true)

function Create-Professional-Draft($to, $contactName, $company, $hook) {
    $mail = $outlook.CreateItem(0)
    $mail.To = $to
    $mail.Subject = "Project Support: SoCal Installation Partnership ($company)"
    
    $salutation = if ($contactName) { "Hi $contactName," } else { "Hi," }
    
    $body = @"
$salutation

If you're placing furniture in Los Angeles, Orange County, or San Diego we should talk.

Vector Installation Services is a commercial furniture installation company based in Buena Park, CA with a 20,000 sq ft warehouse and full receiving, storage, delivery, and installation capabilities all under one roof.

$hook

We work exclusively with dealers as a white label partner so your brand is on site and our crew does the work. Our installers have hands on experience with all major systems lines including Herman Miller, Haworth, Steelcase, and Knoll.

We accept direct factory shipments at our warehouse so your client never has to coordinate receiving. We manage the full punch list and quality control on every project and our crews are clean, professional, and represent your brand the way you would want.

We also know Southern California. The buildings, the loading docks, the freight elevators, the parking situations. That local knowledge makes a real difference on install day.

Dealers work with us when they need a reliable partner in SoCal they do not have to babysit. If you have an upcoming project out here or just want a backup installer you can count on, I would love a quick 15 minute call to see if we are a good fit.

Would Wednesday or Thursday work for you?

Best,

Alex Becerra
(714) 631-7451
www.vectorinstallations.com
6388 Artesia Blvd.
Buena Park, CA 90620
"@
    
    $mail.Body = $body
    $mail.Save()
    Write-Output "Upgraded draft created for: $company"
}

# Clean up the "Terrible" drafts first
$inbox = $namespace.GetDefaultFolder(6)
$items = $inbox.Items
for ($i = $items.Count; $i -ge 1; $i--) {
    $item = $items.Item($i)
    if ($item.Subject -like "Partnership:*") {
        $item.Delete()
    }
}

$targets = Get-Content "targets.json" | ConvertFrom-Json
$count = 0

# Process next batch with the CORRECT high-intensity copy
foreach ($target in $targets) {
    # Skip the first 10 we already messed up (or re-do them if you want, let's start fresh with the next 15 to hit the goal)
    if ($count -lt 10) { $count++; continue } 
    if ($count -ge 25) { break }
    
    $to = "alex@vectorinstallations.com"
    Create-Professional-Draft -to $to -contactName $target.contact_name -company $target.company -hook $target.hook
    $count++
}

Write-Output "Batch of $($count - 10) high-intensity drafts created."
