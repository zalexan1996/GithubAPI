<#
.SYNOPSIS
Sets the actions and reusable workflows that are allowed in an organization. To use this endpoint, the organization permission policy for allowed_actions must be configured to selected. For more information, see "Set GitHub Actions permissions for an organization."
If the organization belongs to an enterprise that has selected actions and reusable workflows set at the enterprise level, then you cannot override any of the enterprise's allowed actions and reusable workflows settings.
To use the patterns_allowed setting for private repositories, the organization must belong to an enterprise. If the organization does not belong to an enterprise, then the patterns_allowed setting only applies to public repositories in the organization.
You must authenticate using an access token with the admin:org scope to use this endpoint. GitHub Apps must have the administration organization permission to use this API.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER github_owned_allowed
Whether GitHub-owned actions are allowed. For example, this includes the actions in the actions organization.
         
.PARAMETER verified_allowed
Whether actions from GitHub Marketplace verified creators are allowed. Set to true to allow all actions by GitHub Marketplace verified creators.
         
.PARAMETER patterns_allowed
Specifies a list of string-matching patterns to allow specific action(s) and reusable workflow(s). Wildcards, tags, and SHAs are allowed. For example, monalisa/octocat@*, monalisa/octocat@v2, monalisa/*."


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS

#>
Function Set-AllowedActionsAndReusableWorkflowsForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][bool]$github_owned_allowed,
		[Parameter(Mandatory=$FALSE)][bool]$verified_allowed,
		[Parameter(Mandatory=$FALSE)][string[]]$patterns_allowed
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "github_owned_allowed",
		"verified_allowed",
		"patterns_allowed" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/permissions/selected-actions?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/permissions/selected-actions"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
