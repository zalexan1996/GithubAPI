<#
.SYNOPSIS
Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see GitHub's products in the GitHub Help documentation.
Lists who has access to this protected branch.
Note: Users, apps, and teams restrictions are only available for organization-owned repositories.

        
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
}
#>
Function Get-AccessRestrictions
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
        $FinalURL = "https://api.github.com/repos/$owner/$repo/branches/$branch/protection/restrictions?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/branches/$branch/protection/restrictions"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
