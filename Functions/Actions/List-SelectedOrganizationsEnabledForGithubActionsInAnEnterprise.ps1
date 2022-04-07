<#
.SYNOPSIS
Lists the organizations that are selected to have GitHub Actions enabled in an enterprise. To use this endpoint, the enterprise permission policy for enabled_organizations must be configured to selected. For more information, see "Set GitHub Actions permissions for an enterprise."
You must authenticate using an access token with the admin:enterprise scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "total_count": 1,
  "organizations": [
    {
      "login": "octocat",
      "id": 161335,
      "node_id": "MDEwOlJlcG9zaXRvcnkxMjk2MjY5",
      "url": "https://api.github.com/orgs/octo-org",
      "repos_url": "https://api.github.com/orgs/octo-org/repos",
      "events_url": "https://api.github.com/orgs/octo-org/events",
      "hooks_url": "https://api.github.com/orgs/octo-org/hooks",
      "issues_url": "https://api.github.com/orgs/octo-org/issues",
      "members_url": "https://api.github.com/orgs/octo-org/members{/member}",
      "public_members_url": "https://api.github.com/orgs/octo-org/public_members{/member}",
      "avatar_url": "https://github.com/images/error/octocat_happy.gif",
      "description": "A great organization"
    }
  ]
}
#>
Function List-SelectedOrganizationsEnabledForGithubActionsInAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $Querys = @()
    $QueryStrings = @(
        "per_page",
		"page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/permissions/organizations?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/permissions/organizations"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
