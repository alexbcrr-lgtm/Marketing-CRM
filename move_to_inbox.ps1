$outlook = New-Object -ComObject Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")
$namespace.Logon("Outlook", $null, $false, $true)

$inbox = $namespace.GetDefaultFolder(6) # olFolderInbox

$store = $namespace.Stores | Where-Object { $_.DisplayName -eq "Alex@vectorinstallations.com" }
$drafts = $store.GetDefaultFolder(16)

$items = $drafts.Items
$count = $items.Count

for ($i = $count; $i -ge 1; $i--) {
    $item = $items.Item($i)
    if ($item.Subject -like "Partnership:*") {
        $item.UnRead = $true
        $item.Move($inbox) | Out-Null
        Write-Output "Moved: $($item.Subject)"
    }
}
