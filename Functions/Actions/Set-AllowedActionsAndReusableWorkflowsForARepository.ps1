
<#
.SYNOPSIS
Sets the actions and reusable workflows that are allowed in a repository. To use this endpoint, the repository permission policy for allowed_actions must be configured to selected. For more information, see "Set GitHub Actions permissions for a repository."
If the repository belongs to an organization or enterprise that has selected actions and reusable workflows set at the organization or enterprise levels, then you cannot override any of the allowed actions and reusable workflows settings.
To use the patterns_allowed setting for private repositories, the repository must belong to an enterprise. If the repository does not belong to an enterprise, then the patterns_allowed setting only applies to public repositories.
You must authenticate using an access token with the repo scope to use this endpoint. GitHub Apps must have the administration repository permission to use this API.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER github_owned_allowed
Whether GitHub-owned actions are allowed. For example, this includes the actions in the actions organization.
         
.PARAMETER verified_allowed
Whether actions from GitHub Marketplace verified creators are allowed. Set to true to allow all actions by GitHub Marketplace verified creators.
         
.PARAMETER patterns_allowed
Specifies a list of string-matching patterns to allow specific action(s) and reusable workflow(s). Wildcards, tags, and SHAs are allowed. For example, monalisa/octocat@*, monalisa/octocat@v2, monalisa/*."


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Set-AllowedActionsAndReusableWorkflowsForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$github_owned_allowed,
		[Parameter(Mandatory=$FALSE)][string]$verified_allowed,
		[Parameter(Mandatory=$FALSE)][string]$patterns_allowed
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/permissions/selected-actions?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/permissions/selected-actions"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"github_owned_allowed" = "$github_owned_allowed"
	"verified_allowed" = "$verified_allowed"
	"patterns_allowed" = "$patterns_allowed"
    }

    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

