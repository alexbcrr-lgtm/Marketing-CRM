$apiUrl = "https://becerra-commander.vercel.app/api/commander"
$token = "alex"
$headers = @{ "x-api-token" = $token; "Content-Type" = "application/json" }

# Test 4: Use a different action entirely (intake) to see if it's just the log_communication endpoint
$body4 = @{
    action = "intake"
    bot_name = "IC_Leads"
    data = @{
        name = "Test Lead"
        company = "Test Co"
    }
} | ConvertTo-Json

# Test 5: Try heartbeat with 'message' field
$body5 = @{
    action = "heartbeat"
    bot_name = "IC_Leads"
    message = "Testing if heartbeat accepts message"
} | ConvertTo-Json

function Try-Request($name, $body) {
    Write-Output "Running $name..."
    try {
        $resp = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
        Write-Output "SUCCESS: $name"
        Write-Output ($resp | ConvertTo-Json)
    } catch {
        Write-Output "FAILED: $name - Status $($_.Exception.Response.StatusCode.Value__)"
    }
}

Try-Request "Test 4 (Intake Action)" $body4
Try-Request "Test 5 (Heartbeat + Message)" $body5
