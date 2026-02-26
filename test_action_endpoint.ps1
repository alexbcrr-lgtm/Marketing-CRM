$apiUrl = "https://marketing-crm-nu.vercel.app/api/action" # Attempting /api/action
$token = "alex"
$headers = @{ "x-api-token" = $token; "Content-Type" = "application/json" }

$body = @{
    action = "heartbeat"
    bot_name = "IC_Leads"
} | ConvertTo-Json

try {
    $resp = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
    Write-Output "SUCCESS: /api/action"
    Write-Output ($resp | ConvertTo-Json)
} catch {
    Write-Output "FAILED: /api/action - Status $($_.Exception.Response.StatusCode.Value__)"
}
