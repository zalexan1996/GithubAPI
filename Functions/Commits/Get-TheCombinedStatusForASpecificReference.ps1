<#
.SYNOPSIS
Users with pull access in a repository can access a combined view of commit statuses for a given ref. The ref can be a SHA, a branch name, or a tag name.
Additionally, a combined state is returned. The state is one of:
failure if any of the contexts report as error or failure
pending if there are no statuses or a context is pending
success if the latest status for all contexts is success

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER ref
ref parameter
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/commits

.OUTPUTS
 {
  "state": "success",
  "statuses": [
    {
      "url": "https://api.github.com/repos/octocat/Hello-World/statuses/6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "avatar_url": "https://github.com/images/error/hubot_happy.gif",
      "id": 1,
      "node_id": "MDY6U3RhdHVzMQ==",
      "state": "success",
      "description": "Build has completed successfully",
      "target_url": "https://ci.example.com/1000/output",
      "context": "continuous-integration/jenkins",
      "created_at": "2012-07-20T01:19:13Z",
      "updated_at": "2012-07-20T01:19:13Z"
    },
    {
      "url": "https://api.github.com/repos/octocat/Hello-World/statuses/6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "avatar_url": "https://github.com/images/error/other_user_happy.gif",
      "id": 2,
      "node_id": "MDY6U3RhdHVzMg==",
      "state": "success",
      "description": "Testing has completed successfully",
      "target_url": "https://ci.example.com/2000/output",
      "context": "security/brakeman",
      "created_at": "2012-08-20T01:19:13Z",
      "updated_at": "2012-08-20T01:19:13Z"
    }
  ],
  "sha": "6dcb09b5b57875f334f61aebed695e2e4193db5e",
  "total_count": 2,
  "repository": {
    "id": 1296269,
    "node_id": "MDEwOlJlcG9zaXRvcnkxMjk2MjY5",
    "name": "Hello-World",
    "full_name": "octocat/Hello-World",
    "owner": {
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
    "private": false,
    "html_url": "https://github.com/octocat/Hello-World",
    "description": "This your first repo!",
    "fork": false,
    "url": "https://api.github.com/repos/octocat/Hello-World",
    "archive_url": "https://api.github.com/repos/octocat/Hello-World/{archive_format}{/ref}",
    "assignees_url": "https://api.github.com/repos/octocat/Hello-World/assignees{/user}",
    "blobs_url": "https://api.github.com/repos/octocat/Hello-World/git/blobs{/sha}",
    "branches_url": "https://api.github.com/repos/octocat/Hello-World/branches{/branch}",
    "collaborators_url": "https://api.github.com/repos/octocat/Hello-World/collaborators{/collaborator}",
    "comments_url": "https://api.github.com/repos/octocat/Hello-World/comments{/number}",
    "commits_url": "https://api.github.com/repos/octocat/Hello-World/commits{/sha}",
    "compare_url": "https://api.github.com/repos/octocat/Hello-World/compare/{base}...{head}",
    "contents_url": "https://api.github.com/repos/octocat/Hello-World/contents/{+path}",
    "contributors_url": "https://api.github.com/repos/octocat/Hello-World/contributors",
    "deployments_url": "https://api.github.com/repos/octocat/Hello-World/deployments",
    "downloads_url": "https://api.github.com/repos/octocat/Hello-World/downloads",
    "events_url": "https://api.github.com/repos/octocat/Hello-World/events",
    "forks_url": "https://api.github.com/repos/octocat/Hello-World/forks",
    "git_commits_url": "https://api.github.com/repos/octocat/Hello-World/git/commits{/sha}",
    "git_refs_url": "https://api.github.com/repos/octocat/Hello-World/git/refs{/sha}",
    "git_tags_url": "https://api.github.com/repos/octocat/Hello-World/git/tags{/sha}",
    "git_url": "git:github.com/octocat/Hello-World.git",
    "issue_comment_url": "https://api.github.com/repos/octocat/Hello-World/issues/comments{/number}",
    "issue_events_url": "https://api.github.com/repos/octocat/Hello-World/issues/events{/number}",
    "issues_url": "https://api.github.com/repos/octocat/Hello-World/issues{/number}",
    "keys_url": "https://api.github.com/repos/octocat/Hello-World/keys{/key_id}",
    "labels_url": "https://api.github.com/repos/octocat/Hello-World/labels{/name}",
    "languages_url": "https://api.github.com/repos/octocat/Hello-World/languages",
    "merges_url": "https://api.github.com/repos/octocat/Hello-World/merges",
    "milestones_url": "https://api.github.com/repos/octocat/Hello-World/milestones{/number}",
    "notifications_url": "https://api.github.com/repos/octocat/Hello-World/notifications{?since,all,participating}",
    "pulls_url": "https://api.github.com/repos/octocat/Hello-World/pulls{/number}",
    "releases_url": "https://api.github.com/repos/octocat/Hello-World/releases{/id}",
    "ssh_url": "git@github.com:octocat/Hello-World.git",
    "stargazers_url": "https://api.github.com/repos/octocat/Hello-World/stargazers",
    "statuses_url": "https://api.github.com/repos/octocat/Hello-World/statuses/{sha}",
    "subscribers_url": "https://api.github.com/repos/octocat/Hello-World/subscribers",
    "subscription_url": "https://api.github.com/repos/octocat/Hello-World/subscription",
    "tags_url": "https://api.github.com/repos/octocat/Hello-World/tags",
    "teams_url": "https://api.github.com/repos/octocat/Hello-World/teams",
    "trees_url": "https://api.github.com/repos/octocat/Hello-World/git/trees{/sha}",
    "hooks_url": "http://api.github.com/repos/octocat/Hello-World/hooks"
  },
  "commit_url": "https://api.github.com/repos/octocat/Hello-World/6dcb09b5b57875f334f61aebed695e2e4193db5e",
  "url": "https://api.github.com/repos/octocat/Hello-World/6dcb09b5b57875f334f61aebed695e2e4193db5e/status"
}
#>
Function Get-TheCombinedStatusForASpecificReference
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$ref,
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
        $FinalURL = "https://api.github.com/repos/$owner/$repo/commits/$ref/status?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/commits/$ref/status"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
