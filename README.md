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

For the Data folder, only link files will be tracked and uploaded to GitHub. Moreover, all data put in the Data folder would be automatically synchronized to the corresponding folder in the server.

For the Results folder, it is a folder where lots of cooperation happen. Therefore we need a perfect solution to tame Office files, Matlab figures, pictures and (even some videos) in Git way. Currently, the solution is using pull requests manually solve all conflicts.
