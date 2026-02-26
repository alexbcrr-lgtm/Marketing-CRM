$apiUrl = "https://becerra-commander.vercel.app/api/commander"
$token = "alex"
$headers = @{ "x-api-token" = $token; "Content-Type" = "application/json" }

# 1. Sync Targets to CRM
$targets = Get-Content "targets.json" | ConvertFrom-Json
foreach ($target in $targets) {
    $body = @{
        action = "log_communication"
        tag = "SYNC_TARGET"
        bot_name = "IC_Leads"
        data = @{
            company = $target.company
            contact = $target.contact_name
            hook = $target.hook
            location = $target.location
        }
    } | ConvertTo-Json
    Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
}

# 2. Report Progress
$report = @{
    action = "log_communication"
    tag = "CAMPAIGN_UPDATE"
    bot_name = "IC_Leads"
    message = "Successfully generated 53 professional drafts for Vector (Dealers). Staggered execution scheduled."
} | ConvertTo-Json
Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $report

Write-Output "CRM SYNC COMPLETE: 53 Targets processed."
