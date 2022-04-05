
<#
.SYNOPSIS
Creates a codespace owned by the authenticated user for the specified pull request.
You must authenticate using an access token with the codespace scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER pull_number

         
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
Function Create-ACodespaceFromAPullRequest
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$pull_number,
		[Parameter(Mandatory=$FALSE)][string]$location,
		[Parameter(Mandatory=$FALSE)][string]$machine,
		[Parameter(Mandatory=$FALSE)][string]$working_directory,
		[Parameter(Mandatory=$FALSE)][string]$idle_timeout_minutes,
		[Parameter(Mandatory=$FALSE)][string]$display_name
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/$pull_number/codespaces?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/$pull_number/codespaces"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"location" = "$location"
	"machine" = "$machine"
	"working_directory" = "$working_directory"
	"idle_timeout_minutes" = "$idle_timeout_minutes"
	"display_name" = "$display_name"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

