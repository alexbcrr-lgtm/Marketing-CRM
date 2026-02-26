# BECERRA MARKETING ENGINE — run_campaign.ps1
param(
    [string]$Brand = "both",
    [switch]$DryRun,
    [int]$Limit = 10
)

$SUPABASE_URL = "https://swmfwrlwthcnjpabnldo.supabase.co"
$SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN3bWZ3cmx3dGhjbmpwYWJubGRvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE4OTA2MTUsImV4cCI6MjA4NzQ2NjYxNX0.Y3PGRST1bk1krAbErM9zksGo4yZwLdnjffjeJu31CVU"

$MATON_KEY_IC  = "JEQWmJKuwt5ZOshSxlVkeIT4lSmJ7EN3RlqouAlF5U0L5f_BFKCApA_eKedltYP9aUtaQTaw2nrAjS7NKE8zbwDJtDZ4Gg9M7pdLcoytPw"
$MATON_CONN_IC = "0a246d2f-f18d-43fe-8fc3-39b6f71bce73"

$MATON_KEY_BMG  = "NDswjWNMVE8p-khfaxHT6XxOpOSoWhb73GNioZ6djP44LpoDeOXjti6610_pIlgEdPv2NZnMexdv7EMReZ1HXEPd1FahR94pZpE"
$MATON_CONN_BMG = "cfa1fe2a-f6d1-4d55-b147-dcc949733bbc"

$IC_SUBJECT = "Commercial Furniture Installation - Southern California"
$IC_BODY = "Hi {contact},`n`nIf you're placing furniture in Los Angeles, Orange County, or San Diego we should talk.`n`nVector Installation Services is a commercial furniture installation company based in Buena Park, CA with a 20,000 sq ft warehouse and full receiving, storage, delivery, and installation capabilities all under one roof. We work exclusively with dealers as a white label partner so your brand is on site and our crew does the work.`n`nOur installers have hands on experience with all major systems lines including Herman Miller, Haworth, Steelcase, and Knoll. We accept direct factory shipments at our warehouse so your client never has to coordinate receiving. We manage the full punch list and quality control on every project and our crews are clean, professional, and represent your brand the way you would want.`n`nWe also know Southern California. The buildings, the loading docks, the freight elevators, the parking situations. That local knowledge makes a real difference on install day. Dealers work with us when they need a reliable partner in SoCal they do not have to babysit.`n`nIf you have an upcoming project out here or just want a backup installer you can count on, I would love to put together a walkthrough and a quote at no obligation. Let me know if that would be helpful.`n`nBest,`nAlex Becerra`n(714) 631-7451`nwww.vectorinstallations.com`n6388 Artesia Blvd. Buena Park, CA 90620"

$BMG_SUBJECT = "Commercial Relocation Services - Southern California"
$BMG_BODY = "Hi {contact},`n`nMost commercial moves go sideways because the moving company treats it like a residential job. Furniture gets damaged, things end up in the wrong place, and employees show up Monday morning to a mess.`n`nBusiness Moving Group specializes exclusively in commercial relocations across Los Angeles, Orange County, and San Diego. We are based in Buena Park and operate out of a 20,000 sq ft warehouse where we handle receiving, storage, delivery, and full furniture installation all in house. We only do commercial work so your move is never treated like a side job.`n`nWe can receive your new furniture at our warehouse before move day so everything is staged and ready to go. Our crews handle the full scope including packing, transport, assembly, and final placement so your office is operational from day one. We also work evenings and weekends when needed so you are not disrupting your team.`n`nWhether you are moving 10 people or 500 we build a plan around your timeline and do everything we can to minimize downtime. If you have a relocation coming up in the next few months I would love to put together a walkthrough and a quote at no obligation. Let me know if that would be helpful.`n`nBest,`nAlex Becerra`n(714) 631-7451`nwww.businessmoving.com`n6388 Artesia Blvd. Buena Park, CA 90620"

$BRANDS = @{
    vector = @{ name="Install Champions"; subject=$IC_SUBJECT; body=$IC_BODY; matonKey=$MATON_KEY_IC; matonConn=$MATON_CONN_IC }
    bmg    = @{ name="Business Moving Group"; subject=$BMG_SUBJECT; body=$BMG_BODY; matonKey=$MATON_KEY_BMG; matonConn=$MATON_CONN_BMG }
}

function Log($msg, $color="Cyan") { Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $msg" -ForegroundColor $color }

function SupabaseGet($query) {
    $h = @{ "apikey"=$SUPABASE_KEY; "Authorization"="Bearer $SUPABASE_KEY" }
    try { return Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/$query" -Headers $h -Method GET }
    catch { Log "GET error: $_" "Red"; return $null }
}

function SupabasePatch($id, $body) {
    $h = @{ "apikey"=$SUPABASE_KEY; "Authorization"="Bearer $SUPABASE_KEY"; "Content-Type"="application/json"; "Prefer"="return=minimal" }
    try { Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/leads?id=eq.$id" -Headers $h -Method PATCH -Body ($body|ConvertTo-Json); return $true }
    catch { Log "PATCH error: $_" "Red"; return $false }
}

function SendViaMaton($to, $subject, $body, $matonKey, $matonConn) {
    $h = @{ "Authorization"="Bearer $matonKey"; "Content-Type"="application/json"; "X-Maton-Connection-Id"=$matonConn }
    $payload = @{ message = @{ subject=$subject; body=@{ contentType="Text"; content=$body }; toRecipients=@(@{ emailAddress=@{ address=$to } }) }; saveToSentItems=$true } | ConvertTo-Json -Depth 10
    try { Invoke-RestMethod -Uri "https://gateway.maton.ai/outlook/v1.0/me/sendMail" -Headers $h -Method POST -Body $payload; return $true }
    catch { Log "Maton error: $_" "Red"; return $false }
}

function AdvanceOverdue {
    Log "Checking overdue leads..." "Magenta"
    $today = (Get-Date).ToString("yyyy-MM-dd")
    $overdue = SupabaseGet "leads?status=in.(touch1,touch2,touch3)&next_follow_up=lte.$today"
    if (-not $overdue -or $overdue.Count -eq 0) { Log "Zero Overdue Policy: OK" "Green"; return }
    foreach ($l in $overdue) {
        $ns = switch($l.status){"touch1"{"touch2"}"touch2"{"touch3"}"touch3"{"lost"}}
        $days = switch($ns){"touch2"{4}"touch3"{7}default{0}}
        $patch = @{status=$ns; updated_at=(Get-Date -Format "o")}
        if ($days -gt 0) { $patch.next_follow_up=(Get-Date).AddDays($days).ToString("yyyy-MM-dd") }
        if (SupabasePatch $l.id $patch) { Log "  $($l.company) -> $ns" "Green" }
    }
}

Log "============================================" "Cyan"
Log "BECERRA MARKETING ENGINE" "Cyan"
Log "Brand: $Brand | DryRun: $DryRun | Limit: $Limit" "Cyan"
Log "============================================" "Cyan"

AdvanceOverdue

$sent=0; $errors=0
$brandsToRun = if($Brand -eq "both"){@("vector","bmg")}else{@($Brand)}

foreach ($b in $brandsToRun) {
    $cfg = $BRANDS[$b]
    Log ""; Log "-- $($cfg.name) --" "Cyan"
    $leads = SupabaseGet "leads?brand=eq.$b&status=eq.new&order=value.desc&limit=$Limit"
    if (-not $leads -or $leads.Count -eq 0) { Log "No new leads found" "Yellow"; continue }
    Log "Found $($leads.Count) leads" "White"

    foreach ($l in $leads) {
        $contact = if($l.contact){$l.contact.Split(" ")[0]}else{"there"}
        $subj = $cfg.subject
        $body = $cfg.body -replace "\{contact\}", $contact
        Log "  $($l.company) | $($l.email)" "White"

        if ($DryRun) { Log "  [DRY RUN] $subj -> $($l.email)" "Yellow"; $sent++; continue }
        if (-not $l.email) { Log "  No email - skipping" "Yellow"; $errors++; continue }

        $ok = SendViaMaton $l.email $subj $body $cfg.matonKey $cfg.matonConn
        if ($ok) {
            $fu = (Get-Date).AddDays(3).ToString("yyyy-MM-dd")
            SupabasePatch $l.id @{status="touch1"; updated_at=(Get-Date -Format "o"); next_follow_up=$fu} | Out-Null
            Log "  Sent + CRM updated -> touch1, follow-up $fu" "Green"
            $sent++
        } else { $errors++ }

        $delay = Get-Random -Minimum 480 -Maximum 900
        if (-not $DryRun) {
            $hour = (Get-Date).Hour
            if ($hour -ge 7 -and $hour -lt 17) {
                Log "  Waiting $([math]::Round($delay/60,1)) min..." "DarkGray"
                Start-Sleep -Seconds $delay
            } else {
                Log "  Outside 7am-5pm - pausing until 7am" "Yellow"
                $now = Get-Date
                $addDays = if($now.Hour -ge 17){1}else{0}
                $next7am = (Get-Date -Hour 7 -Minute 0 -Second 0).AddDays($addDays)
                Start-Sleep -Seconds ($next7am - $now).TotalSeconds
            }
        }
    }
}

Log ""; Log "============================================" "Cyan"
Log "DONE: $sent sent, $errors errors" $(if($errors -gt 0){"Red"}else{"Green"})
Log "============================================" "Cyan"

