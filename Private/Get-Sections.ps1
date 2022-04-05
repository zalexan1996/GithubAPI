
<#
.SYNOPSIS
Given a valid web driver, it will navigate to the GitHub API reference page and return a list of sections in the reference.

.PARAMETER Driver
A valid web driver that's been created. It doesn't have to be at a specific page or done any sort of authentications beforehand.

.OUTPUTS
An array of:
@{
    [String]Name
    [String]$Url
}
#>
Function Get-Sections
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$TRUE, ValueFromPipeline)][Object]$Driver
    )

    # The XPATH used to find the sections of the API reference
    $xpath = "//ul[@data-testid='table-of-contents']//a[starts-with(@href, '/en/rest/reference/')]"

    # Navigate to the API Reference
    Enter-SeUrl -Driver $Driver -Url "https://docs.github.com/en/rest/reference"

    # Get all table of content items
    $Driver.FindElementsByXPath($xpath) | Select-Object @{
        Name="name"
        Expression={ $_.Text }
    }, @{
        Name = "href"
        Expression = {$_.GetProperty("href")}
    } | Write-Output
}