### The original script was downloaded from: 
# https://superuser.com/questions/226828/how-to-monitor-a-folder-and-trigger-a-command-line-action-when-a-file-is-created
# then modified by Wenbin Yang (bysin7@gmail.com)
# this script is compatible with PowerShell 6.0 or later
# you can download PowerShell from https://github.com/PowerShell/PowerShell

# last modified by Wenbin Yang (bysin7@gmail.com) on Jul. 17, 2018






### User defined functions

### User defined variables
    $global:desFolder = "\\222.195.69.205\wenlab\Young\test\Data"
    $global:monitorFolder = "C:\Users\USER\Documents\Template-Project-Repository\Data"
    $global:excludedExtensions = ".lnk",".tmp"
    $global:excludedPrefix = "`$~"
    $global:stopWatch = New-Object -TypeName System.Diagnostics.Stopwatch
    $global:stopWatch.Start()
    $global:lastEventTime = 0
    $global:lastEventPath = ""
    $global:interval = 1000
   
    

### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO
    # Modification watcher
    $mwatcher = New-Object System.IO.FileSystemWatcher
    $mwatcher.Path = $global:monitorFolder
    $mwatcher.Filter = "*.*"
    $mwatcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite
    $mwatcher.IncludeSubdirectories = $true
    $mwatcher.EnableRaisingEvents = $true  

    # Watcher for other events
    
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $global:monitorFolder
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

                $changeType = $Event.SourceEventArgs.ChangeType
                $logline = "$(Get-Date), $changeType, $path"
                Add-content "C:\Users\USER\Documents\DirMonitoringLog.txt" -value $logline

                $remoteFile = "$desFolder\$basename$extension"
                if ([System.IO.File]::Exists($remoteFile))
                {
                    # Delete the corresponding file
                    # remove-item  -Path $remoteFile -Force
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

                $changeType = $Event.SourceEventArgs.ChangeType
                $logline = "$(Get-Date), $changeType, $path"
                Add-content "C:\Users\USER\Documents\DirMonitoringLog.txt" -value $logline

                $remoteFile = "$desFolder\$oldBasename$oldExtension"
                if ([System.IO.File]::Exists($remoteFile))
                {
                    # Rename the corresponding file
                    $newName = $basename + $extension
                    rename-item  -Path $remoteFile -NewName $newName
                    # Replace the old link with a new link
                    $oldLinkFile = "$parentFolder\$oldBasename.lnk"
                    remove-item -path $oldLinkFile -Force
                    # Create a new link item
                    $linkFile = "$parentFolder\$basename.lnk"
                    $WshShell = New-Object -comObject WScript.Shell
                    $Shortcut = $WshShell.CreateShortcut($linkFile)
                    $newRemoteFile = "$desFolder\$basename$extension"
                    $Shortcut.TargetPath = $newRemoteFile
                    $Shortcut.Save()
                    
                }
                else
                {
                    # Show warning message
                    # pop up a warning window
                    $popupShell = New-Object -ComObject Wscript.Shell
                    $popupShell.Popup("No file exists at $remoteFile",0,"Warning!",0x1)
                }
                
      }
      $actionOnChanged = {
                $global:path = $Event.SourceEventArgs.FullPath
                $curTimeBound = $global:stopWatch.ElapsedMilliseconds - $global:interval
                if ($global:path -eq $global:lastEventPath -and $curTimeBound -lt $global:lastEventTime)
                {
                    # abolish this event since it is probably one of the multiple events 
                    # taht triggered by a single file
                    return
                }
                
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

                $remoteFile = "$desFolder\$basename$extension"
                if ([System.IO.File]::Exists($remoteFile))
                {
                    # remove the remote item
                    remove-item  -Path $remoteFile -Force
                    # copy the modified item to the remote folder
                    copy-item $path -Destination $desFolder

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

                $global:lastEventPath = $global:path
                $global:lastEventTime = $global:stopWatch.ElapsedMilliseconds
      }


### DECIDE WHICH EVENTS SHOULD BE WATCHED 
    #Register-ObjectEvent $watcher "Created" -Action $actionOnCreated # dealed in the onChange event
    Register-ObjectEvent $watcher "Deleted" -Action $actionOnDeleted
    Register-ObjectEvent $watcher "Renamed" -Action $actionOnRenamed   
    Register-ObjectEvent $mwatcher "Changed" -Action $actionOnChanged  # also watching onCreated events  
    while ($true) {sleep 5}