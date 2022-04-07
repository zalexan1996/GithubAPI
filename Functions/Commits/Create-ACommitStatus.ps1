<#
.SYNOPSIS
Users with push access in a repository can create commit statuses for a given SHA.
Note: there is a limit of 1000 statuses per sha and context within a repository. Attempts to create more than 1000 statuses will result in a validation error.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER sha

         
.PARAMETER state
Required. The state of the status. Can be one of error, failure, pending, or success.
         
.PARAMETER target_url
The target URL to associate with this status. This URL will be linked from the GitHub UI to allow users to easily see the source of the status.
For example, if your continuous integration system is posting build status, you would want to provide the deep link for the build output for this specific SHA:
http://ci.example.com/user/repo/build/sha
         
.PARAMETER description
A short description of the status.
         
.PARAMETER context
A string label to differentiate this status from the status of other systems. This field is case-insensitive.
Default: default


.LINK
https://docs.github.com/en/rest/reference/commits

.OUTPUTS
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
  "updated_at": "2012-07-20T01:19:13Z",
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
  }
}
#>
Function Create-ACommitStatus
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$sha,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$target_url,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][string]$context
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "state",
		"target_url",
		"description",
		"context" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/statuses/$sha?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/statuses/$sha"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
