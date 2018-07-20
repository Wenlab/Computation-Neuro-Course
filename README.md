# Template-Project-Repository
This repository is a template repository for creating new project repositories.

The No.1 principle of the project repository: One project, one folder.

For the project repository, it has four parts (folders):
1. References
2. Code
3. Data
4. Results

For the References folder, we'd like to integrate Endnote with GitHub and make the shared library can be seamlessly used as a third party component in this GitHub based project management system. However, details has to be worked out.

For the Code folder, it is naturally compatible with GitHub which is born for code.

For the Data folder, only link files will be tracked and uploaded to GitHub. Moreover, all data put in the Data folder would be automatically synchronized to the corresponding folder in the server. And add links for each file/folders at the root directory. (will not create links for sub-folders)

Potential issues: if you want to download a link file directly from GitHub, please change the post-fix to .lnk manually to make things work fine. Also you have to make your link files to be read-only before uploading them. (check the [solution](https://github.com/owncloud/client/issues/4300) at here.)

For the Results folder, it is a folder where lots of cooperation happen. Therefore we need a perfect solution to tame Office files, Matlab figures, pictures and (even some videos) in Git way. Currently, the solution is using pull requests manually solve all conflicts.

use FreeFilesSync to automatically synchronize files in the local folder to the remote folder on the server.
[tutorial](https://freefilesync.org/manual.php?topic=schedule-batch-jobs)


In addition, people can use this README as a freeGate to explore other components in this GitHub-based project management system.

Currently, we have:
1. [Wenlab Website][1]
2. [Lab Member Project WikiPage][2]
3. [Wenlab GitHub Pages][3]



[1]: http://www.wenlab.org/
[2]: http://222.195.69.24/wiki/Quan_projects
[3]: https://wenlab.github.io./
