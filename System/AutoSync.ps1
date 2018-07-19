# run the bat of freeFileSync to update the local folder to the remote folder
Start-Process C:\Users\USER\Documents\Template-Project-Repository\System\syncLocalFolder2Server.ffs_batch
# Sleep for 2 seconds
Write-Host "Files Sync Done. Please wait 10 seconds for cleaning temporary caches."
sleep 10 # seconds

### In the local folder, automatically create links to link data in the remote folder
$LocalPath = "C:\Users\USER\Documents\Template-Project-Repository\Data\links"
$RemotePath = "\\222.195.69.205\wenlab\Young\test\Data"

# if RemotePath or LocalPath does not exist create one
if (!(Test-Path -path $RemotePath)) {New-Item $RemotePath -ItemType Directory}
if (!(Test-Path -path $LocalPath)) {New-Item $LocalPath -ItemType Directory)


# remove invalid links in the local folder
$links = Get-ChildItem $LocalPath -recurse -include *.lnk

# for each link
foreach ($link in $links) {
    $LShell = New-Object -comObject WScript.Shell
    $linkFile = $link.FullName
    $target = $WshShell.CreateShortcut($linkFile).targetpath
    if(![System.IO.File]::Exists($target)) # if target does not exist, remove the link
    {
        Remove-Item -Path $linkFile -Force  
    }
}


# Get all files on the remote path
$files = Get-ChildItem $RemotePath -recurse # there could be filters
$re = "^" + [regex]::Escape("$RemotePath\")
#Foreach-Object
foreach ($file in $files) {
    $WshShell = New-Object -comObject WScript.Shell
    $targetPath = $file.FullName
    $relativePath = $targetPath -replace $re
    if (Test-Path -path $targetPath -PathType container) # create folders for folders
    {   
        $LocalDir = "$LocalPath\$relativePath"
        if (!(Test-Path -path $LocalDir)) {New-Item $LocalDir -ItemType Directory}
    }
    else{
        # create a link for a file
        $linkPath = "$LocalPath\$relativePath.lnk" 
        if(![System.IO.File]::Exists($linkPath))
        {
            $Shortcut = $WshShell.CreateShortcut($linkPath)
            $Shortcut.TargetPath = $targetPath
            $Shortcut.Save()
        }
    } 
    
    
}
Write-Host "Synchronization Done. The program will exit in 10 seconds"
# hold-on for 10 seconds to check out the messaged in the console
sleep 10
