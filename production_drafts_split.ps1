$outlook = New-Object -ComObject Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")
$namespace.Logon("Outlook", $null, $false, $true)

function Create-Professional-Draft($to, $contactName, $company, $hook, $type) {
    try {
        $mail = $outlook.CreateItem(0)
        
        # SPAM PREVENTION: Setting the correct "SentOnBehalfOfName" (Requires the account to be mapped in Outlook)
        if ($type -eq "Installation") {
            $sender = "alex@vectorinstallations.com"
            $subject = "Project Support: SoCal Installation Partnership ($company)"
            $body = @"
Hi $(if ($contactName) { $contactName } else { "" }),

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
        } else {
            $sender = "alex@businessmoving.com"
            $subject = "Commercial Relocation Support: SoCal ($company)"
            $body = @"
Hi $(if ($contactName) { $contactName } else { "" }),

Most commercial moves go sideways because the moving company treats it like a residential job. Furniture gets damaged, things end up in the wrong place, and employees show up Monday morning to a mess.

Business Moving Group specializes exclusively in commercial relocations across Los Angeles, Orange County, and San Diego. We are based in Buena Park and operate out of a 20,000 sq ft warehouse where we handle receiving, storage, delivery, and full furniture installation all in house.

$hook

We only do commercial work so your move is never treated like a side job. We can receive your new furniture at our warehouse before move day so everything is staged and ready to go. Our crews handle the full scope including packing, transport, assembly, and final placement so your office is operational from day one.

We also work evenings and weekends when needed so you are not disrupting your team. Whether you are moving 10 people or 500 we build a plan around your timeline and do everything we can to minimize downtime.

If you have a relocation coming up in the next few months I would love to put together a walkthrough and a quote at no obligation. Let me know if that would be helpful.

Best,

Alex Becerra
(714) 631-7451
www.businessmoving.com
6388 Artesia Blvd.
Buena Park, CA 90620
"@
        }

        $mail.To = $to
        $mail.Subject = $subject
        $mail.Body = $body
        # Setting the sender address specifically
        $mail.SentOnBehalfOfName = $sender
        
        $mail.Save()
        Write-Output "SUCCESS: Created $type draft for $company (From: $sender)"
    } catch {
        Write-Output "FAILURE: Could not create draft for $company. Error: $($_.Exception.Message)"
    }
}

$targets = Get-Content "targets.json" | ConvertFrom-Json
$count = 0

foreach ($target in $targets) {
    if ($count -ge 10) { break } # Test batch of 10
    $to = "alex@vectorinstallations.com" # Internal review first
    $type = if ($count % 2 -eq 0) { "Installation" } else { "Moving" }
    Create-Professional-Draft -to $to -contactName $target.contact_name -company $target.company -hook $target.hook -type $type
    $count++
}
