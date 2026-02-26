$outlook = New-Object -ComObject Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")
$namespace.Logon("Outlook", $null, $false, $true)
$draftsFolder = $namespace.GetDefaultFolder(16) # olFolderDrafts
$count = $draftsFolder.Items.Count
Write-Output "Drafts count: $count"
