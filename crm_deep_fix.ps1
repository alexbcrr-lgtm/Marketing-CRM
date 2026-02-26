$apiUrl = "https://becerra-commander.vercel.app/api/commander"
$token = "alex"
$headers = @{ "x-api-token" = $token; "Content-Type" = "application/json" }

# Test 1: Using 'message' instead of 'data' (matching heartbeat style)
$body1 = @{
    action = "log_communication"
    bot_name = "IC_Leads"
    tag = "TEST"
    message = "Test message only"
} | ConvertTo-Json

# Test 2: Using 'payload' as a generic key
$body2 = @{
    action = "log_communication"
    bot_name = "IC_Leads"
    tag = "TEST"
    payload = "Test payload"
} | ConvertTo-Json

# Test 3: Standard documentation format check (flat structure)
$body3 = @{
    action = "log_communication"
    bot_name = "IC_Leads"
    tag = "NEW_LEAD"
    company = "Test Co"
    contact = "Test Contact"
} | ConvertTo-Json

function Try-Request($name, $body) {
    Write-Output "Running $name..."
    try {
        $resp = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
        Write-Output "SUCCESS: $name"
        Write-Output ($resp | ConvertTo-Json)
        return $true
    } catch {
        Write-Output "FAILED: $name - Status $($_.Exception.Response.StatusCode.Value__)"
        return $false
    }
}

Try-Request "Test 1 (Message Only)" $body1
Try-Request "Test 2 (Payload Key)" $body2
Try-Request "Test 3 (Flat Structure)" $body3
