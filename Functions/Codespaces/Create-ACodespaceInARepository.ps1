<#
.SYNOPSIS
Creates a codespace owned by the authenticated user in the specified repository.
You must authenticate using an access token with the codespace scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER ref
Git ref (typically a branch name) for this codespace
         
.PARAMETER location
Location for this codespace. Assigned by IP if not provided
         
.PARAMETER machine
Machine type to use for this codespace
         
.PARAMETER working_directory
Working directory for this codespace
         
.PARAMETER idle_timeout_minutes
Time in minutes before codespace stops from inactivity
         
.PARAMETER display_name
Display name for this codespace


.LINK
https://docs.github.com/en/rest/reference/codespaces
#>
Function Create-ACodespaceInARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$ref,
		[Parameter(Mandatory=$FALSE)][string]$location,
		[Parameter(Mandatory=$FALSE)][string]$machine,
		[Parameter(Mandatory=$FALSE)][string]$working_directory,
		[Parameter(Mandatory=$FALSE)][int]$idle_timeout_minutes,
		[Parameter(Mandatory=$FALSE)][string]$display_name
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "ref",
		"location",
		"machine",
		"working_directory",
		"idle_timeout_minutes",
		"display_name" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/codespaces?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/codespaces"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
