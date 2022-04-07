<#
.SYNOPSIS
Lists all GitHub Apps in an organization. The installation count includes all GitHub Apps installed on repositories in the organization. You must be an organization owner with admin:read scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/orgs

.OUTPUTS
 {
  "total_count": 1,
  "installations": [
    {
      "id": 25381,
      "account": {
        "login": "octo-org",
        "id": 6811672,
        "node_id": "MDEyOk9yZ2FuaXphdGlvbjY4MTE2NzI=",
        "avatar_url": "https://avatars3.githubusercontent.com/u/6811672?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/octo-org",
        "html_url": "https://github.com/octo-org",
        "followers_url": "https://api.github.com/users/octo-org/followers",
        "following_url": "https://api.github.com/users/octo-org/following{/other_user}",
        "gists_url": "https://api.github.com/users/octo-org/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/octo-org/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/octo-org/subscriptions",
        "organizations_url": "https://api.github.com/users/octo-org/orgs",
        "repos_url": "https://api.github.com/users/octo-org/repos",
        "events_url": "https://api.github.com/users/octo-org/events{/privacy}",
        "received_events_url": "https://api.github.com/users/octo-org/received_events",
        "type": "Organization",
        "site_admin": false
      },
      "repository_selection": "selected",
      "access_tokens_url": "https://api.github.com/app/installations/25381/access_tokens",
      "repositories_url": "https://api.github.com/installation/repositories",
      "html_url": "https://github.com/organizations/octo-org/settings/installations/25381",
      "app_id": 2218,
      "target_id": 6811672,
      "target_type": "Organization",
      "permissions": {
        "deployments": "write",
        "metadata": "read",
        "pull_requests": "read",
        "statuses": "read"
      },
      "events": [
        "deployment",
        "deployment_status"
      ],
      "created_at": "2017-05-16T08:47:09.000-07:00",
      "updated_at": "2017-06-06T11:23:23.000-07:00",
      "single_file_name": "config.yml",
      "has_multiple_single_files": true,
      "single_file_paths": [
        "config.yml",
        ".github/issue_TEMPLATE.md"
      ],
      "app_slug": "github-actions",
      "suspended_at": null,
      "suspended_by": null
    }
  ]
}
#>
Function List-AppInstallationsForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
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
        $FinalURL = "https://api.github.com/orgs/$org/installations?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/installations"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
