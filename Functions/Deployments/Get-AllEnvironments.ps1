<#
.SYNOPSIS
Get all environments for a repository.
Anyone with read access to the repository can use this endpoint. If the repository is private, you must use an access token with the repo scope. GitHub Apps must have the actions:read permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/deployments

.OUTPUTS
 {
  "total_count": 1,
  "environments": [
    {
      "id": 161088068,
      "node_id": "MDExOkVudmlyb25tZW50MTYxMDg4MDY4",
      "name": "staging",
      "url": "https://api.github.com/repos/github/hello-world/environments/staging",
      "html_url": "https://github.com/github/hello-world/deployments/activity_log?environments_filter=staging",
      "created_at": "2020-11-23T22:00:40Z",
      "updated_at": "2020-11-23T22:00:40Z",
      "protection_rules": [
        {
          "id": 3736,
          "node_id": "MDQ6R2F0ZTM3MzY=",
          "type": "wait_timer",
          "wait_timer": 30
        },
        {
          "id": 3755,
          "node_id": "MDQ6R2F0ZTM3NTU=",
          "type": "required_reviewers",
          "reviewers": [
            {
              "type": "User",
              "reviewer": {
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
              }
            },
            {
              "type": "Team",
              "reviewer": {
                "id": 1,
                "node_id": "MDQ6VGVhbTE=",
                "url": "https://api.github.com/teams/1",
                "html_url": "https://github.com/orgs/github/teams/justice-league",
                "name": "Justice League",
                "slug": "justice-league",
                "description": "A great team.",
                "privacy": "closed",
                "permission": "admin",
                "members_url": "https://api.github.com/teams/1/members{/member}",
                "repositories_url": "https://api.github.com/teams/1/repos",
                "parent": null
              }
            }
          ]
        },
        {
          "id": 3756,
          "node_id": "MDQ6R2F0ZTM3NTY=",
          "type": "branch_policy"
        }
      ],
      "deployment_branch_policy": {
        "protected_branches": false,
        "custom_branch_policies": true
      }
    }
  ]
}
#>
Function Get-AllEnvironments
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
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
        $FinalURL = "https://api.github.com/repos/$owner/$repo/environments?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/environments"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
