$apiUrl = "https://marketing-crm-nu.vercel.app/api/logs" # Attempting /api/logs
$token = "alex"
$headers = @{ "x-api-token" = $token; "Content-Type" = "application/json" }

$body = @{
    bot_name = "IC_Leads"
    tag = "SYNC"
    message = "Testing /api/logs endpoint"
} | ConvertTo-Json

try {
    $resp = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
    Write-Output "SUCCESS: /api/logs"
    Write-Output ($resp | ConvertTo-Json)
} catch {
    Write-Output "FAILED: /api/logs - Status $($_.Exception.Response.StatusCode.Value__)"
}
