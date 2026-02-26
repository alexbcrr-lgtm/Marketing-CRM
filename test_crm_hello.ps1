$apiUrl = "https://marketing-crm-nu.vercel.app/api/hello"
try {
    $resp = Invoke-RestMethod -Uri $apiUrl -Method Get
    Write-Output "HELLO SUCCESS"
} catch {
    Write-Output "HELLO FAILED - Status $($_.Exception.Response.StatusCode.Value__)"
}
