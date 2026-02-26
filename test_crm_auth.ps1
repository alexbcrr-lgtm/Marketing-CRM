$apiUrl = "https://marketing-crm-nu.vercel.app/api/auth"
try {
    $resp = Invoke-RestMethod -Uri $apiUrl -Method Get
    Write-Output "AUTH SUCCESS"
} catch {
    Write-Output "AUTH FAILED - Status $($_.Exception.Response.StatusCode.Value__)"
}
