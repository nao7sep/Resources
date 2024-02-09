# Define the path to search in
$path = "C:\Repositories"

# Search for thumbs.db files including hidden ones
$thumbs = Get-ChildItem -Path $path -Filter thumbs.db -Recurse -Force -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName

# Check if any thumbs.db files are found
if ($thumbs.Count -eq 0) {
    Write-Host "No thumbs.db files found."
} else {
    # List found thumbs.db files
    $thumbs | ForEach-Object { Write-Host $_ }

    # Ask for confirmation to delete
    $confirmation = Read-Host "Do you want to delete all found thumbs.db files? (y/n)"
    if ($confirmation -ieq 'y') {
        $thumbs | ForEach-Object {
            Remove-Item $_ -Force
            Write-Host "Deleted $_"
        }
    } else {
        Write-Host "No files were deleted."
    }
}

# Wait for any key to be pressed before closing the window
Write-Host "Press any key to exit..."
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
