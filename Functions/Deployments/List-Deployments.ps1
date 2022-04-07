<#
.SYNOPSIS
Simple filtering of deployments is available via query parameters:

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER sha
The SHA recorded at creation time.
Default: none
         
.PARAMETER ref
The name of the ref. This can be a branch, tag, or SHA.
Default: none
         
.PARAMETER task
The name of the task for the deployment (e.g., deploy or deploy:migrations).
Default: none
         
.PARAMETER environment
The name of the environment that was deployed to (e.g., staging or production).
Default: none
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/deployments

.OUTPUTS
 [
  {
    "url": "https://api.github.com/repos/octocat/example/deployments/1",
    "id": 1,
    "node_id": "MDEwOkRlcGxveW1lbnQx",
    "sha": "a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
    "ref": "topic-branch",
    "task": "deploy",
    "payload": {},
    "original_environment": "staging",
    "environment": "production",
    "description": "Deploy request from hubot",
    "creator": {
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
    "created_at": "2012-07-20T01:19:13Z",
    "updated_at": "2012-07-20T01:19:13Z",
    "statuses_url": "https://api.github.com/repos/octocat/example/deployments/1/statuses",
    "repository_url": "https://api.github.com/repos/octocat/example",
    "transient_environment": false,
    "production_environment": true
  }
]
#>
Function List-Deployments
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$sha,
		[Parameter(Mandatory=$FALSE)][string]$ref,
		[Parameter(Mandatory=$FALSE)][string]$task,
		[Parameter(Mandatory=$FALSE)][stringnull]$environment,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $Querys = @()
    $QueryStrings = @(
        "sha",
		"ref",
		"task",
		"environment",
		"per_page",
		"page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/deployments?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/deployments"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
