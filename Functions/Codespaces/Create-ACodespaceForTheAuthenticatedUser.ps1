
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
         
.PARAMETER Properties of thepull_requestobject



.LINK
https://docs.github.com/en/rest/reference/codespaces
#>
Function Create-ACodespaceForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$repository_id,
		[Parameter(Mandatory=$FALSE)][string]$ref,
		[Parameter(Mandatory=$FALSE)][string]$location,
		[Parameter(Mandatory=$FALSE)][string]$machine,
		[Parameter(Mandatory=$FALSE)][string]$working_directory,
		[Parameter(Mandatory=$FALSE)][string]$idle_timeout_minutes,
		[Parameter(Mandatory=$FALSE)][string]$display_name,
		[Parameter(Mandatory=$FALSE)][string]$pull_request,
		[Parameter(Mandatory=$FALSE)][string]$Properties of thepull_requestobject
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/codespaces?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/codespaces"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"repository_id" = "$repository_id"
	"ref" = "$ref"
	"location" = "$location"
	"machine" = "$machine"
	"working_directory" = "$working_directory"
	"idle_timeout_minutes" = "$idle_timeout_minutes"
	"display_name" = "$display_name"
	"pull_request" = "$pull_request"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

