# Make sure your github token (and only your github token) is in C:\Users\Username\Appdata\Roaming\github.token
Param(
    [Parameter(Mandatory=$FALSE)][Bool]$Regenerate,
    [Parameter(Mandatory=$FALSE)][String[]]$UseSections = @("ALL"),
    [Parameter(Mandatory=$FALSE)][String]$Token = (Get-Content $env:APPDATA\github.token)
)


$Global:GithubToken = $Token

# Alright, now go to lunch!
if ($Regenerate) {
    . "$PSScriptRoot\Private\Start-Chrome.ps1"
    . "$PSScriptRoot\Private\Get-Sections.ps1"
    . "$PSScriptRoot\Private\Get-Endpoints.ps1"
    
    # Remove the old
    if (Test-Path $PSScriptRoot\Functions) {
        Remove-Item -Path $PSScriptRoot\Functions -Recurse -Force -ErrorAction SilentlyContinue
    }

    # Create a new functions folder
    New-Item -Path "$PSScriptRoot\Functions" -ItemType Directory -ErrorAction SilentlyContinue

    # Create the driver if we don't have one already.
    if ($NULL -eq $Driver) {
        $Driver = Start-Chrome -StartUrl "https://docs.github.com/en/rest/reference" -Visible $FALSE -ErrorAction SilentlyContinue
        if ($NULL -eq $Driver) {
            throw "Failed to create web driver!"
        }
    }
    
    
    try {

        # Get a list of all the sections (Actions, Activity, Branches, Commits, etc)
        $Sections = $Driver | Get-Sections
        
        Foreach ($Section in $Sections) {
            if ($UseSections -contains $Section.Name -or $UseSections -like "ALL") {
                Write-Verbose "$($Section.Name)"
                # Create a folder for this section if there isn't one already
                New-Item -Path "$PSScriptRoot\Functions\$($Section.Name)" -ItemType Directory -ErrorAction SilentlyContinue
            
                # Parse all functions from the section and save them to file.
                Get-Endpoints -SectionURL $Section.Href -Verbose | Foreach-Object {
                    Set-Content -Path "$PSScriptRoot\Functions\$($Section.Name)\$($_.FunctionName).ps1" -Value $_.Code
                }
            }
        }
    }
    catch {
        Write-Host $_
    }
    finally {
        $Driver.Quit()
    }
}


# Import all functions
Foreach ($Section in $UseSections) {
    if ($Section -like "ALL") {
        Get-ChildItem $PSScriptRoot/Functions -Recurse -File -Include *ps1 | Foreach-Object {
            . $_.FullName
        }
    }
    else {
        Get-ChildItem $PSScriptRoot/Functions/$Section -Recurse -File -Include *ps1 | Foreach-Object {
            . $_.FullName
        }
    }
}