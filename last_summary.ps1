# DAILY SUMMARY — last_summary.ps1
$SUPABASE_URL = "https://swmfwrlwthcnjpabnldo.supabase.co"
$SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN3bWZ3cmx3dGhjbmpwYWJubGRvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE4OTA2MTUsImV4cCI6MjA4NzQ2NjYxNX0.Y3PGRST1bk1krAbErM9zksGo4yZwLdnjffjeJu31CVU"

$h = @{ "apikey"=$SUPABASE_KEY; "Authorization"="Bearer $SUPABASE_KEY" }
$yesterday = (Get-Date).AddDays(-1).ToString("yyyy-MM-dd")
$today = (Get-Date).ToString("yyyy-MM-dd")

$sentYesterday = Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/leads?updated_at=gte.${yesterday}T00:00:00&updated_at=lt.${today}T00:00:00&status=neq.new&select=brand,status,company" -Headers $h
$replies = Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/leads?status=eq.replied&select=brand,company,contact" -Headers $h
$overdue = Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/leads?status=in.(touch1,touch2,touch3)&next_follow_up=lte.$today&select=brand,company,status" -Headers $h
$newLeads = Invoke-RestMethod -Uri "$SUPABASE_URL/rest/v1/leads?status=eq.new&select=brand,company" -Headers $h

$icSent = ($sentYesterday | Where-Object { $_.brand -eq "vector" }).Count
$bmgSent = ($sentYesterday | Where-Object { $_.brand -eq "bmg" }).Count
$icReplies = ($replies | Where-Object { $_.brand -eq "vector" }).Count
$bmgReplies = ($replies | Where-Object { $_.brand -eq "bmg" }).Count
$icNew = ($newLeads | Where-Object { $_.brand -eq "vector" }).Count
$bmgNew = ($newLeads | Where-Object { $_.brand -eq "bmg" }).Count

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "BECERRA DAILY SUMMARY — $yesterday" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "YESTERDAY'S SENDS" -ForegroundColor Yellow
Write-Host "  IC:  $icSent sent" -ForegroundColor White
Write-Host "  BMG: $bmgSent sent" -ForegroundColor White
Write-Host ""
Write-Host "TOTAL REPLIES (all time)" -ForegroundColor Yellow
Write-Host "  IC:  $icReplies replied" -ForegroundColor Green
Write-Host "  BMG: $bmgReplies replied" -ForegroundColor Green
if ($replies.Count -gt 0) {
    Write-Host "  Latest replies:" -ForegroundColor White
    $replies | Select-Object -Last 3 | ForEach-Object { Write-Host "    $($_.brand.ToUpper()) - $($_.company) ($($_.contact))" -ForegroundColor Green }
}
Write-Host ""
Write-Host "OVERDUE: $($overdue.Count)" -ForegroundColor $(if($overdue.Count -gt 0){"Red"}else{"Green"})
if ($overdue.Count -gt 0) { $overdue | ForEach-Object { Write-Host "  $($_.brand.ToUpper()) - $($_.company) ($($_.status))" -ForegroundColor Red } }
Write-Host ""
Write-Host "NEW LEADS QUEUED" -ForegroundColor Yellow
Write-Host "  IC:  $icNew ready" -ForegroundColor White
Write-Host "  BMG: $bmgNew ready" -ForegroundColor White
Write-Host ""
Write-Host "CRM: https://marketing-crm-nu.vercel.app/" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
