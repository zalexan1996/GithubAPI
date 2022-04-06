<#
.SYNOPSIS
Creates a new codespace, owned by the authenticated user.
This endpoint requires either a repository_id OR a pull_request but not both.
You must authenticate using an access token with the codespace scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER repository_id
Required. Repository id for this codespace
         
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
         
.PARAMETER pull_request
Required. Pull request number for this codespace


.LINK
https://docs.github.com/en/rest/reference/codespaces
#>
Function Create-ACodespaceForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$repository_id,
		[Parameter(Mandatory=$FALSE)][string]$ref,
		[Parameter(Mandatory=$FALSE)][string]$location,
		[Parameter(Mandatory=$FALSE)][string]$machine,
		[Parameter(Mandatory=$FALSE)][string]$working_directory,
		[Parameter(Mandatory=$FALSE)][int]$idle_timeout_minutes,
		[Parameter(Mandatory=$FALSE)][string]$display_name,
		[Parameter(Mandatory=$FALSE)][object]$pull_request
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "repository_id",
		"ref",
		"location",
		"machine",
		"working_directory",
		"idle_timeout_minutes",
		"display_name",
		"pull_request" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/codespaces?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/codespaces"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
