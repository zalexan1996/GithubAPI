
<#
.SYNOPSIS
Sets the GitHub Actions permissions policy for enabling GitHub Actions and allowed actions and reusable workflows in the repository.
If the repository belongs to an organization or enterprise that has set restrictive permissions at the organization or enterprise levels, such as allowed_actions to selected actions and reusable workflows, then you cannot override them for the repository.
You must authenticate using an access token with the repo scope to use this endpoint. GitHub Apps must have the administration repository permission to use this API.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER enabled
Required. Whether GitHub Actions is enabled on the repository.
         
.PARAMETER allowed_actions
The permissions policy that controls the actions and reusable workflows that are allowed to run. Can be one of: all, local_only, or selected.


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Set-GithubActionsPermissionsForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$enabled,
		[Parameter(Mandatory=$FALSE)][string]$allowed_actions
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/permissions?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/permissions"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"enabled" = "$enabled"
	"allowed_actions" = "$allowed_actions"
    }

    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

