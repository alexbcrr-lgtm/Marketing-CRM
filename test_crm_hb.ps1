$apiUrl = "https://marketing-crm-nu.vercel.app/api/heartbeat"
try {
    $resp = Invoke-RestMethod -Uri $apiUrl -Method Get
    Write-Output "HB SUCCESS"
} catch {
    Write-Output "HB FAILED - Status $($_.Exception.Response.StatusCode.Value__)"
}
