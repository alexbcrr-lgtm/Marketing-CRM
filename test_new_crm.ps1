$apiUrl = "https://marketing-crm-nu.vercel.app/api/commander" # Updated Endpoint
$token = "alex"
$headers = @{ "x-api-token" = $token; "Content-Type" = "application/json" }

# Test 1: Heartbeat to New CRM
$body1 = @{
    action = "heartbeat"
    bot_name = "IC_Leads"
    current_task = "Syncing 53 Targets - New CRM"
} | ConvertTo-Json

# Test 2: Log Communication to New CRM
$body2 = @{
    action = "log_communication"
    bot_name = "IC_Leads"
    tag = "SYNC_TARGET"
    message = "Syncing initial target batch to Supreme Elite CRM"
} | ConvertTo-Json

function Try-Request($name, $body) {
    Write-Output "Running $name..."
    try {
        $resp = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
        Write-Output "SUCCESS: $name"
        Write-Output ($resp | ConvertTo-Json)
    } catch {
        Write-Output "FAILED: $name - Status $($_.Exception.Response.StatusCode.Value__)"
        if ($_.Exception.Response) {
             $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
             Write-Output "Error Detail: $($reader.ReadToEnd())"
        }
    }
}

Try-Request "Heartbeat (New CRM)" $body1
Try-Request "Log Communication (New CRM)" $body2
