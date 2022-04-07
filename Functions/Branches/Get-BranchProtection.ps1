<#
.SYNOPSIS
Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see GitHub's products in the GitHub Help documentation.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER branch
The name of the branch.


.LINK
https://docs.github.com/en/rest/reference/branches

.OUTPUTS
 {
  "url": "https://api.github.com/repos/octocat/Hello-World/branches/master/protection",
  "required_status_checks": {
    "url": "https://api.github.com/repos/octocat/Hello-World/branches/master/protection/required_status_checks",
    "contexts": [
      "continuous-integration/travis-ci"
    ],
    "contexts_url": "https://api.github.com/repos/octocat/Hello-World/branches/master/protection/required_status_checks/contexts",
    "enforcement_level": "non_admins"
  },
  "enforce_admins": {
    "url": "https://api.github.com/repos/octocat/Hello-World/branches/master/protection/enforce_admins",
    "enabled": true
  },
  "required_pull_request_reviews": {
    "url": "https://api.github.com/repos/octocat/Hello-World/branches/master/protection/required_pull_request_reviews",
    "dismissal_restrictions": {
      "url": "https://api.github.com/repos/octocat/Hello-World/branches/master/protection/dismissal_restrictions",
      "users_url": "https://api.github.com/repos/octocat/Hello-World/branches/master/protection/dismissal_restrictions/users",
      "teams_url": "https://api.github.com/repos/octocat/Hello-World/branches/master/protection/dismissal_restrictions/teams",
      "users": [
        {
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
      ],
      "teams": [
        {
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
      ]
    },
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": true,
    "required_approving_review_count": 2
  },
  "restrictions": {
    "url": "https://api.github.com/repos/octocat/Hello-World/branches/master/protection/restrictions",
    "users_url": "https://api.github.com/repos/octocat/Hello-World/branches/master/protection/restrictions/users",
    "teams_url": "https://api.github.com/repos/octocat/Hello-World/branches/master/protection/restrictions/teams",
    "apps_url": "https://api.github.com/repos/octocat/Hello-World/branches/master/protection/restrictions/teams",
    "users": [
      {
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
    ],
    "teams": [
      {
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
    ],
    "apps": [
      {
        "id": 1,
        "slug": "octoapp",
        "node_id": "MDExOkludGVncmF0aW9uMQ==",
        "owner": {
          "login": "github",
          "id": 1,
          "node_id": "MDEyOk9yZ2FuaXphdGlvbjE=",
          "url": "https://api.github.com/orgs/github",
          "repos_url": "https://api.github.com/orgs/github/repos",
          "events_url": "https://api.github.com/orgs/github/events",
          "hooks_url": "https://api.github.com/orgs/github/hooks",
          "issues_url": "https://api.github.com/orgs/github/issues",
          "members_url": "https://api.github.com/orgs/github/members{/member}",
          "public_members_url": "https://api.github.com/orgs/github/public_members{/member}",
          "avatar_url": "https://github.com/images/error/octocat_happy.gif",
          "description": "A great organization"
        },
        "name": "Octocat App",
        "description": "",
        "external_url": "https://example.com",
        "html_url": "https://github.com/apps/octoapp",
        "created_at": "2017-07-08T16:18:44-04:00",
        "updated_at": "2017-07-08T16:18:44-04:00",
        "permissions": {
          "metadata": "read",
          "contents": "read",
          "issues": "write",
          "single_file": "write"
        },
        "events": [
          "push",
          "pull_request"
        ]
      }
    ]
  },
  "required_linear_history": {
    "enabled": true
  },
  "allow_force_pushes": {
    "enabled": true
  },
  "allow_deletions": {
    "enabled": true
  },
  "required_conversation_resolution": {
    "enabled": true
  }
}
#>
Function Get-BranchProtection
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$branch
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/branches/$branch/protection?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/branches/$branch/protection"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
