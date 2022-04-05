Param(
    [Parameter(Mandatory=$FALSE)][Bool]$Regenerate
)

# Alright, now go to lunch!
if ($Regenerate)
{
    . "$PSScriptRoot\Private\Start-Chrome.ps1"
    . "$PSScriptRoot\Private\Get-Sections.ps1"
    . "$PSScriptRoot\Private\Get-Endpoints.ps1"
    
    # Remove the old
    Remove-Item -Path $PSScriptRoot\Functions -Recurse -Force -ErrorAction SilentlyContinue

    # Create a new functions folder
    New-Item -Path "$PSScriptRoot\Functions" -ItemType Directory -ErrorAction SilentlyContinue
    
    # Create the driver if we don't have one already.
    if ($NULL -eq $Driver)
    {
        $Driver = Start-Chrome -StartUrl "https://docs.github.com/en/rest/reference" -Visible $TRUE
    }
    
    
    # Get a list of all the sections (Actions, Activity, Branches, Commits, etc)
    $Sections = $Driver | Get-Sections
    
    Foreach ($Section in $Sections)
    {
        # Create a folder for this section if there isn't one already
        New-Item -Path "$PSScriptRoot\Functions\$($Section.Name)" -ItemType Directory -ErrorAction SilentlyContinue
    
        # Parse all functions from the section and save them to file.
        
        Get-Endpoints -SectionURL $Section.Href | % {

            Set-Content -Path "$PSScriptRoot\Functions\$($Section.Name)\$($_.FunctionName).ps1" -Value $_.Code
            
        }
    }
}

    # Make sure your github token (and only your github token) is in C:\Users\Username\Appdata\Roaming\github.token
$Script:GithubToken = Get-Content $env:APPDATA\github.token

# Import all functions
Get-ChildItem $PSScriptRoot/Functions -Recurse -File -Include *ps1 | % {
    . $_.FullName
}