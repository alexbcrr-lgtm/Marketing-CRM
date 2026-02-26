$apiUrl = "https://becerra-commander.vercel.app/api/commander"
$token = "alex"

$headers = @{
    "x-api-token" = $token
    "Content-Type" = "application/json"
}

$body = @{
    action = "heartbeat"
    bot_name = "IC_Leads"
    current_task = "Testing CRM Connectivity"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
    Write-Output "CRM Status: SUCCESS"
    Write-Output ($response | ConvertTo-Json)
} catch {
    Write-Output "CRM Status: FAILED"
    Write-Output $_.Exception.Message
}
