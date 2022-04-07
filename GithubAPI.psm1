<#
.SYNOPSIS
A Powershell module for interacting with the GithubAPI. All 800 functions have been generated dynamically by scraping 
the documentation webpage at https://docs.github.com/en/rest/reference. Most of these functions are untested. Believe it or not,
I haven't tested all 800. Please report any bugs and broken functions that you find so that I can fix the scraper.

.DESCRIPTION
Before importing this module, you need to either put your Github token in $ENV:AppData\github.token or you need to pass it into
the module as an argument.

.PARAMETER UseSections
Specify an array of sections that you want to import. Sections are taken from https://docs.github.com/en/rest/reference
Use ALL if you want to import all the functions.

.PARAMETER Regenerate
Set to true if you want to rescrape the function definitions before importing the code. 
If UseSections are specified, it will only scrape the sections specified. 

If set to FALSE, it imports whatever sections you've specified (assuming the sections have been scraped.)

.PARAMETER Token
Pass your github oauth token here. 
By default, it'll try to read it from $ENV:APPDATA\github.token
#>
Param(
    [Parameter(Mandatory=$FALSE)]
    [ValidateSet(
    "Actions",              "Activity",                                 "Apps",
    "Billing",              "Branches",                                 "Checks",
    "Codes of conduct",     "Code scanning",                            "Codespaces",
    "Collaborators",        "Commits",                                  "Dependabot",
    "Dependency graph",     "Deploy Keys",                              "Deployments",
    "Emojis",               "GitHub Enterprise administration",         "Gists",
    "Git database",         "Gitignore",                                "Interactions",
    "Issues",               "Licenses",                                 "Markdown",
    "Meta",                 "Metrics",                                  "Migrations",
    "Organizations",        "Packages",                                 "Pages",
    "Projects",             "Pulls",                                    "Rate limit",
    "Reactions",            "Releases",                                 "Repositories",
    "SCIM",                 "Search",                                   "Secret scanning",
    "Teams",                "Users",                                    "Webhooks",
    "ALL"
    )]
    [String[]]$UseSections = @("ALL"),

    [Parameter(Mandatory=$FALSE)][Bool]$Regenerate = $FALSE,
    [Parameter(Mandatory=$FALSE)][String]$Token = (Get-Content $env:APPDATA\github.token)
)


$Global:GithubToken = $Token

# Alright, now go to lunch!
if ($Regenerate) {
    . "$PSScriptRoot\Private\Start-Chrome.ps1"
    . "$PSScriptRoot\Private\Get-Sections.ps1"
    . "$PSScriptRoot\Private\Get-Endpoints.ps1"
    

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
                    Set-Content -Path "$PSScriptRoot\Functions\$($Section.Name)\$($_.FunctionName).ps1" -Value $_.Code -Force
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