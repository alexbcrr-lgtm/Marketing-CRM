$apiUrl = "https://marketing-crm-nu.vercel.app/api/commander"
$token = "alex"
$headers = @{ "x-api-token" = $token; "Content-Type" = "application/json" }

# Trying GET to see if endpoint exists
try {
    $resp = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers
    Write-Output "GET SUCCESS"
    Write-Output ($resp | ConvertTo-Json)
} catch {
    Write-Output "GET FAILED - Status $($_.Exception.Response.StatusCode.Value__)"
}
