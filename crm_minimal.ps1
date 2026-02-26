$apiUrl = "https://becerra-commander.vercel.app/api/commander"
$token = "alex"
$headers = @{ "x-api-token" = $token; "Content-Type" = "application/json" }

# Test 6: Final check - does log_communication require 'tag' but reject 'message'/'data'?
# Or is it perhaps looking for 'action' = 'log' or 'communication'?
$body6 = @{
    action = "log_communication"
    bot_name = "IC_Leads"
    tag = "NEW_LEAD"
} | ConvertTo-Json

try {
    $resp = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body6
    Write-Output "SUCCESS: Base log_communication"
    Write-Output ($resp | ConvertTo-Json)
} catch {
    Write-Output "FAILED: Base log_communication - Status $($_.Exception.Response.StatusCode.Value__)"
}
