# .NET Project Release Procedure

## Setup

Configure necessary parameters (such as directory paths) for build_changed_projects.py and find_unpushed_commits.py.

## Release

Ensure there is no archive of the latest version source files for the project you want to archive. For example, if the latest version of yyLib is v0.3, remove yyLib-v0.3-src.zip. Normally, update the version number when updating the program. This plans the generation of archives for the source files and binaries corresponding to that version. If you want to recreate an archive of an already existing version, check the archive's timestamp in Explorer or Finder and delete the new archive.

### Finalizing the Source Code

* Make sure there are no uncloned repositories
* Run commands like cleanDesk to display hidden directories and files
* Use find_unpushed_commits.py to check and fetch differences from the remote side
* Run yyBom to fix files with encoding or BOM issues
* Start build_changed_projects.py
* Confirm build success with the "Build" command
* Execute the "Update NuGet packages" command
* Process forgotten commits and stages with find_unpushed_commits.py

### Rebuild and Archive

* Execute the "Rebuild and archive" command
* Verify the contents of the log
* Review and stage the filenames and contents of the created archives for each project
* Delete unnecessary archives (e.g., those for class libraries or test apps)
* Confirm that archives for all updated projects are created
* Commit and push the repository files
* Use find_unpushed_commits.py to ensure no tasks are forgotten

### Creating Mac Version

* Ensure there are no uncloned repositories
* By following the steps above, execute up to the archiving.
* Confirm the binary is operational
* Delete unnecessary archives
* Push the necessary archives
* Check find_unpushed_commits.py

### Finalizing

* Run commands like cleanDesk to hide directories and files that are done being processed
* Update the binaries and settings deployed on each computer
* Check find_unpushed_commits.py
