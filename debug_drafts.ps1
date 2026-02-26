$outlook = New-Object -ComObject Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")
$namespace.Logon("Outlook", $null, $false, $true)

$draftsFolder = $namespace.GetDefaultFolder(16)
$items = $draftsFolder.Items

if ($items.Count -eq 0) {
    Write-Output "DEBUG: Drafts folder is empty."
} else {
    Write-Output "DEBUG: Found $($items.Count) items in Drafts."
    foreach ($item in $items) {
        Write-Output "Subject: $($item.Subject) | Saved: $($item.CreationTime)"
    }
}
