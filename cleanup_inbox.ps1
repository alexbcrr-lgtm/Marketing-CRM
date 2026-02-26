$outlook = New-Object -ComObject Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")
$namespace.Logon("Outlook", $null, $false, $true)

$inbox = $namespace.GetDefaultFolder(6)
$items = $inbox.Items

Write-Output "Scanning Inbox for cleanup..."
for ($i = $items.Count; $i -ge 1; $i--) {
    $item = $items.Item($i)
    if ($item.Subject -like "Partnership:*") {
        Write-Output "Deleting legacy draft: $($item.Subject)"
        $item.Delete()
    }
}
