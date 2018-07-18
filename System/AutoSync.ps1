# run the bat of freeFileSync to update the local folder to the remote folder
Start-Process C:\Users\USER\Documents\Template-Project-Repository\System\syncLocalFolder2Server.ffs_batch
# Sleep for 2 seconds
sleep 10 # seconds

### In the local folder, automatically create links to link data in the remote folder
$LocalPath = "C:\Users\USER\Documents\Template-Project-Repository\Data"
$RemotePath = "\\222.195.69.205\wenlab\Young\test\Data"

# Test if the remote path exists 
if (!(Test-Path -path $RemotePath)) {New-Item $RemotePath -ItemType Directory}
else {
    Write-Host "RemotePath already exists"
}

# Get all files on the remote path
$files = Get-ChildItem $RemotePath # there could be filters

#Foreach-Object
foreach ($file in $files) {
    $WshShell = New-Object -comObject WScript.Shell
    $targetPath = Join-Path $RemotePath $file
    if (Test-Path -path $targetPath -PathType container) { continue } # skip creating links for folders
    $linkPath = Join-Path $LocalPath $file
    if(![System.IO.File]::Exists($linkPath+'.lnk'))
    {
        $Shortcut = $WshShell.CreateShortcut($linkPath+'.lnk')
        $Shortcut.TargetPath = $targetPath
        $Shortcut.Save()
    }
    
}
Write-Host "Synchronization Done. The program will exit in 10 seconds"
# hold-on for 10 seconds to check out the messaged in the console
sleep 10
