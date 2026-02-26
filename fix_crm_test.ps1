$apiUrl = "https://becerra-commander.vercel.app/api/commander"
$token = "alex"
$headers = @{ "x-api-token" = $token; "Content-Type" = "application/json" }

# Simplified payload test for CRM 500 Error
$body = @{
    action = "log_communication"
    bot_name = "IC_Leads"
    tag = "HEARTBEAT"
    message = "CRITICAL: log_communication endpoint returning 500. Attempting simplified sync."
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
    Write-Output "CRM FIX TEST: SUCCESS"
    Write-Output ($response | ConvertTo-Json)
} catch {
    Write-Output "CRM FIX TEST: FAILED"
    Write-Output "Status Code: $($_.Exception.Response.StatusCode.Value__)"
    Write-Output "Message: $($_.Exception.Message)"
}
