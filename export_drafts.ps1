$targets = Get-Content "targets.json" | ConvertFrom-Json
$count = 0

foreach ($target in $targets) {
    if ($count -ge 30) { break }
    
    $type = if ($count -lt 15) { "Installation" } else { "Moving" }
    $company = $target.company
    $hook = $target.hook
    $contactName = $target.contact_name
    $salutation = if ($contactName) { "Hi $contactName," } else { "Hi," }
    
    $fileName = "Draft_$($count)_$($company.Replace(' ', '_').Replace('|', '_')).txt"
    
    if ($type -eq "Installation") {
        $content = @"
SUBJECT: Project Support: SoCal Installation Partnership ($company)

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
    } else {
        $content = @"
SUBJECT: Commercial Relocation Support: SoCal ($company)

$salutation

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
    
    $content | Out-File -FilePath "C:\Users\alexb\.openclaw\workspace\drafts\$fileName" -Encoding utf8
    $count++
}

Write-Output "Successfully created $count text-based drafts in \workspace\drafts\"
