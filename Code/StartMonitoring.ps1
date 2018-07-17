### The original script was downloaded from: 
# https://superuser.com/questions/226828/how-to-monitor-a-folder-and-trigger-a-command-line-action-when-a-file-is-created
# then modified by Wenbin Yang (bysin7@gmail.com)
# this script is compatible with PowerShell 6.0 or later
# you can download PowerShell from https://github.com/PowerShell/PowerShell

# last modified on Jul. 16, 2018



### User defined functions


### User defined variables
    

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

    $actionOnChanged = { 
                 $path = $Event.SourceEventArgs.FullPath
                 $fileName = Split-Path $path -leaf
                 $postfix = [System.IO.Path]::GetExtension($path)
                 if ("$postfix" -ne '.lnk') 
                 {
                    $desFolder = "\\222.195.69.205\wenlab\Young\test\Data"
                    $changeType = $Event.SourceEventArgs.ChangeType
                    $logline = "$(Get-Date), $changeType, $path"
                    Add-content "C:\Users\USER\Documents\DirMonitoringLog.txt" -value $logline
                    

                 }
               }

    $actionOnDeleted = { 
                 $desFolder = "\\222.195.69.205\wenlab\Young\test\Data"
                 $path = $Event.SourceEventArgs.FullPath
                 $postfix = [System.IO.Path]::GetExtension($path)
                 $basename = [System.IO.Path]::GetFileNameWithoutExtension($path)
                 $fileName = Split-Path $path -leaf
                 $parentFolder = Split-Path -Path $path
                 if ("$postfix" -ne '.lnk') 
                 {
                    $changeType = $Event.SourceEventArgs.ChangeType
                    $logline = "$(Get-Date), $changeType, $path"
                    Add-content "C:\Users\USER\Documents\DirMonitoringLog.txt" -value $logline
                    $remoteFile = "$desFolder\$fileName"
                    if ([System.IO.File]::Exists($remoteFile))
                    {
                        # delete the remote file
                        remove-item  -Path $remoteFile -Force
                    }
                    else
                    {
                        $warningLine = "No corresponding file exists in the remote folder"
                        Add-Content "C:\Users\USER\Documents\DirMonitoringLog.txt" -value $warningLine
                    }

                 }
               }

    $actionOnRenamed = { $path = $Event.SourceEventArgs.FullPath
                 $desFolder = "\\222.195.69.205\wenlab\Young\test\Data"
                 $path = $Event.SourceEventArgs.FullPath
                 $oldPath = $Event.SourceEventArgs.OldFullPath
                 $postfix = [System.IO.Path]::GetExtension($path)
                 $basename = [System.IO.Path]::GetFileNameWithoutExtension($path)
                 $parentFolder = Split-Path -Path $path
                 if ("$postfix" -ne '.lnk') 
                 {
                    $changeType = $Event.SourceEventArgs.ChangeType
                    $logline = "$(Get-Date), $changeType, $path"
                    Add-content "C:\Users\USER\Documents\DirMonitoringLog.txt" -value $logline
                    $remoteFile = "$desFolder\$fileName"
                    if ([System.IO.File]::Exists($remoteFile))
                    {
                        # delete the remote file
                        remove-item  -Path $remoteFile -Force
                    }
                    else
                    {
                        $warningLine = "No corresponding file exists in the remote folder"
                        Add-Content "C:\Users\USER\Documents\DirMonitoringLog.txt" -value $warningLine
                    }

                 }
               }


### DECIDE WHICH EVENTS SHOULD BE WATCHED 
    Register-ObjectEvent $watcher "Created" -Action $actionOnCreated
    Register-ObjectEvent $watcher "Changed" -Action $actionOnChanged
    Register-ObjectEvent $watcher "Deleted" -Action $actionOnDeleted
    Register-ObjectEvent $watcher "Renamed" -Action $actionOnRenamed
    while ($true) {sleep 5}

