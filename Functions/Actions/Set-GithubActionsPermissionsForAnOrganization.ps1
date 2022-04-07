<#
.SYNOPSIS
Sets the GitHub Actions permissions policy for repositories and allowed actions and reusable workflows in an organization.
If the organization belongs to an enterprise that has set restrictive permissions at the enterprise level, such as allowed_actions to selected actions and reusable workflows, then you cannot override them for the organization.
You must authenticate using an access token with the admin:org scope to use this endpoint. GitHub Apps must have the administration organization permission to use this API.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER enabled_repositories
Required. The policy that controls the repositories in the organization that are allowed to run GitHub Actions. Can be one of: all, none, or selected.
         
.PARAMETER allowed_actions
The permissions policy that controls the actions and reusable workflows that are allowed to run. Can be one of: all, local_only, or selected.


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS

#>
Function Set-GithubActionsPermissionsForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$enabled_repositories,
		[Parameter(Mandatory=$FALSE)][string]$allowed_actions
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "enabled_repositories",
		"allowed_actions" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/permissions?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/permissions"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
