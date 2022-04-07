<#
.SYNOPSIS
Approve or reject pending deployments that are waiting on approval by a required reviewer.
Anyone with read access to the repository contents and deployments can use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER run_id
The id of the workflow run.
         
.PARAMETER environment_ids
Required. The list of environment ids to approve or reject
         
.PARAMETER state
Required. Whether to approve or reject deployment to the specified environments. Must be one of: approved or rejected
         
.PARAMETER comment
Required. A comment to accompany the deployment review


.LINK
https://docs.github.com/en/rest/reference/actions

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
Function Review-PendingDeploymentsForAWorkflowRun
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$run_id,
		[Parameter(Mandatory=$FALSE)][int[]]$environment_ids,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$comment
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "environment_ids",
		"state",
		"comment" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runs/$run_id/pending_deployments?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runs/$run_id/pending_deployments"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
