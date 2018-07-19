## Register with some website service and mobile APPs
1. Register a GitHub account at [GitHub](https://github.com/) with your USTC email
2. Register a Trello account at [Trello](https://trello.com/) and download the Trello APP
3. Register a IFTTT account at [IFTTT](https://ifttt.com/) for services to integrate Trello with GitHub
4. In IFTTT website, search for "open a GitHub issue by adding a new card in specific list in Trello" and "add a new card in Trello when a GitHub issue is assigned to me" and turn on those two applets with your accounts.


## Step-by-step installation
1. Download and install [git](https://git-scm.com/downloads)
2. Git clone the project repository to your local directory as your project folder, everything related to the project should be placed in this folder or in the project repository on GitHub 
3. Download the sync software [FreeFileSync](https://freefilesync.org/download.php)
4. Install FreeFileSync with the default settings.
5. Configure the PowerShell Script "AutoSync.ps1" with the local folder and the remote folder of your project and the FreeFileSync batch file path.
6. Configure the FreeFileSync batch file with the local folder and the remote folder of your project.
7. Set-up the Windows Task Scheduler as start the program "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" with the argument "& path/to/AutoSync.ps1"


### Supporting tools recommendation
- Google Chrome for processing issues and editing files on GitHub website.
- Sublime with the markdownpreview package as the ultimate markdown (and other languages) editor.

There should be no change.
Git ignore?
Works?
How could this possible?