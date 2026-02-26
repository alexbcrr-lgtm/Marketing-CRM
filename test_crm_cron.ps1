$apiUrl = "https://marketing-crm-nu.vercel.app/api/cron"
try {
    $resp = Invoke-RestMethod -Uri $apiUrl -Method Get
    Write-Output "CRON SUCCESS"
} catch {
    Write-Output "CRON FAILED - Status $($_.Exception.Response.StatusCode.Value__)"
}
