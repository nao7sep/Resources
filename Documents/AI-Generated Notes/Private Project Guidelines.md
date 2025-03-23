## Private Project Guidelines

### 1. Repository Naming and Privacy
All private projects must have names that **start with an underscore** (e.g., `_imgLab`). Additionally, they must be set to **private** on GitHub. This ensures that only authorized collaborators have access to the repository.

### 2. README File Requirement
Each private repository must contain a `README.md` file. This file should include a link to this Markdown document for reference. Example:

```md
[Project Guidelines](project-guidelines.md)
```

### 3. No License File
Private projects should **not** include a `LICENSE` file. This prevents any implied licensing terms from being associated with the repository.

### 4. Exclusion of Assembly Information
The repository must **not** contain any assembly information files (e.g., `AssemblyInfo.cs` or similar metadata files). These files should be removed or excluded to maintain project privacy and avoid unnecessary metadata exposure.

### 5. Build Tool Settings
The project's settings file in the build tool must be updated to **ignore the private project** to ensure it is not automatically built. Ensure that the necessary configurations are added to prevent unintended inclusion in the build process.

### 6. Additional Considerations
- Ensure access is granted only to necessary team members.
- Regularly review repository settings to confirm compliance.
- Maintain documentation within the repository as needed.

By following these guidelines, private projects will remain secure and well-structured within GitHub.
