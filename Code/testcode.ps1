#$watcher = New-Object System.IO.FileSystemWatcher
#$watcher.Path = "C:\Users\USER\Documents\Template-Project-Repository\Data"
#$watcher.Filter = "*.*"
#$watcher.IncludeSubdirectories = $true
#$watcher.EnableRaisingEvents = $true  

### User defined functions
    function show-text ($path) {
        #param($path)
        Write-Output $path
    }

### User defined variables
    $global:desFolder = "\\222.195.69.205\wenlab\Young\test\Data"
    $global:excludedExtensions = ".lnk",".tmp"
    $global:excludedPrefix = "`$~"
   
    

### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO

    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = "C:\Users\USER\Documents\Template-Project-Repository\Data"
    $watcher.Filter = "*.*"
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true  

    

### DEFINE ACTIONS AFTER AN EVENT IS DETECTED
    $actionOnCreated = {                
                $path = $Event.SourceEventArgs.FullPath
                $extension = [System.IO.Path]::GetExtension($path)
                $basename = [System.IO.Path]::GetFileNameWithoutExtension($path)
                $parentFolder = Split-Path -Path $path
                if ($excludedExtensions -contains $extension) 
                {
                    return
                }
                    
                $changeType = $Event.SourceEventArgs.ChangeType
                $logline = "$(Get-Date), $changeType, $path"
                Add-content "C:\Users\USER\Documents\DirMonitoringLog.txt" -value $logline
                   
                # check if the same-named file existed on the remote folder
                # potential subfolder issue to solve
                    
                $remoteFile = "$desFolder\$basename$extension"
                if ([System.IO.File]::Exists($remoteFile))
                {
                    # pop up a warning window
                    $popupShell = New-Object -ComObject Wscript.Shell
                    $popupShell.Popup("Pull Request! File already exists at $remoteFile",0,"Pull Request!",0x1)
                    return
                } 
                else
                {
                    # copy the new item to the server
                    copy-item $path -Destination $desFolder
                    # in the local folder, create a link that linked with the copied file in the remote folder
                    $linkFile = "$parentFolder\$basename.lnk"
                    $WshShell = New-Object -comObject WScript.Shell
                    $Shortcut = $WshShell.CreateShortcut($linkFile)
                    $Shortcut.TargetPath = $remoteFile
                    $Shortcut.Save()
                }
                
     }
     $actionOnDeleted = { 
                $path = $Event.SourceEventArgs.FullPath
                $extension = [System.IO.Path]::GetExtension($path)
                $basename = [System.IO.Path]::GetFileNameWithoutExtension($path)
                $parentFolder = Split-Path -Path $path
                if ($excludedExtensions -contains $extension) 
                {
                    return
                }

                $remoteFile = "$desFolder\$basename$extension"
                if ([System.IO.File]::Exists($remoteFile))
                {
                    # Delete the corresponding file
                    remove-item  -Path $remoteFile -Force
                    # Remove the link item too
                    $linkFile = "$parentFolder\$basename.lnk"
                    remove-item -Path $linkFile -Force
                }
                else
                {
                    # Show warning message
                    # pop up a warning window
                    $popupShell = New-Object -ComObject Wscript.Shell
                    $popupShell.Popup("No file exists at $remoteFile",0,"Warning!",0x1)
                    return
                }
      }
      $actionOnRenamed = { 
                $path = $Event.SourceEventArgs.FullPath
                $oldPath = $Event.SourceEventArgs.OldFullPath
                $extension = [System.IO.Path]::GetExtension($path)
                $oldExtension = [System.IO.Path]::GetExtension($oldPath)
                $basename = [System.IO.Path]::GetFileNameWithoutExtension($path)
                $oldBasename = [System.IO.Path]::GetFileNameWithoutExtension($oldPath)
                $parentFolder = Split-Path -Path $path
                if ($excludedExtensions -contains $extension) 
                {
                    return
                }

                $remoteFile = "$desFolder\$oldBasename$oldExtension"
                if ([System.IO.File]::Exists($remoteFile))
                {
                    # Rename the corresponding file
                    $newName = $basename + $extension
                    rename-item  -Path $remoteFile -NewName $newName
                    # Rename the link item too
                    $linkFile = "$parentFolder\$oldBasename.lnk"
                    if ([System.IO.File]::Exists($linkFile))
                    {
                        $newLinkFile = "$parentFolder\$basename.lnk"
                        rename-item -Path $linkFile -NewName $newLinkFile
                    }
                    else
                    {
                        # Create a new link item
                        $linkFile = "$parentFolder\$basename.lnk"
                        $WshShell = New-Object -comObject WScript.Shell
                        $Shortcut = $WshShell.CreateShortcut($linkFile)
                        $newRemoteFile = "$desFolder\$basename$extension"
                        $Shortcut.TargetPath = $newRemoteFile
                        $Shortcut.Save()
                    }
                }
                else
                {
                    # Show warning message
                    # pop up a warning window
                    $popupShell = New-Object -ComObject Wscript.Shell
                    $popupShell.Popup("No file exists at $remoteFile",0,"Warning!",0x1)
                    return
                }
      }


### DECIDE WHICH EVENTS SHOULD BE WATCHED 
    Register-ObjectEvent $watcher "Created" -Action $actionOnCreated
    Register-ObjectEvent $watcher "Deleted" -Action $actionOnDeleted
    Register-ObjectEvent $watcher "Renamed" -Action $actionOnRenamed

    while ($true) {sleep 5}