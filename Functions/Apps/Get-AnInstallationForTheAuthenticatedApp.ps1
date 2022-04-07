<#
.SYNOPSIS
Enables an authenticated GitHub App to find an installation's information using the installation id.
You must use a JWT to access this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER installation_id
installation_id parameter


.LINK
https://docs.github.com/en/rest/reference/apps

.OUTPUTS
 {
  "id": 1,
  "account": {
    "login": "octocat",
    "id": 1,
    "node_id": "MDQ6VXNlcjE=",
    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
    "gravatar_id": "",
    "url": "https://api.github.com/users/octocat",
    "html_url": "https://github.com/octocat",
    "followers_url": "https://api.github.com/users/octocat/followers",
    "following_url": "https://api.github.com/users/octocat/following{/other_user}",
    "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
    "organizations_url": "https://api.github.com/users/octocat/orgs",
    "repos_url": "https://api.github.com/users/octocat/repos",
    "events_url": "https://api.github.com/users/octocat/events{/privacy}",
    "received_events_url": "https://api.github.com/users/octocat/received_events",
    "type": "User",
    "site_admin": false
  },
  "access_tokens_url": "https://api.github.com/installations/1/access_tokens",
  "repositories_url": "https://api.github.com/installation/repositories",
  "html_url": "https://github.com/organizations/github/settings/installations/1",
  "app_id": 1,
  "target_id": 1,
  "target_type": "Organization",
  "permissions": {
    "checks": "write",
    "metadata": "read",
    "contents": "read"
  },
  "events": [
    "push",
    "pull_request"
  ],
  "single_file_name": "config.yaml",
  "has_multiple_single_files": true,
  "single_file_paths": [
    "config.yml",
    ".github/issue_TEMPLATE.md"
  ],
  "repository_selection": "selected",
  "created_at": "2017-07-08T16:18:44-04:00",
  "updated_at": "2017-07-08T16:18:44-04:00",
  "app_slug": "github-actions",
  "suspended_at": null,
  "suspended_by": null
}
#>
Function Get-AnInstallationForTheAuthenticatedApp
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$installation_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/app/installations/$installation_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/app/installations/$installation_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
