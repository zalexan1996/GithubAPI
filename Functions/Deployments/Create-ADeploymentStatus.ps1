<#
.SYNOPSIS
Users with push access can create deployment statuses for a given deployment.
GitHub Apps require read & write access to "Deployments" and read-only access to "Repo contents" (for private repos). OAuth Apps require the repo_deployment scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER deployment_id
deployment_id parameter
         
.PARAMETER state
Required. The state of the status. Can be one of error, failure, inactive, in_progress, queued, pending, or success. When you set a transient deployment to inactive, the deployment will be shown as destroyed in GitHub.
         
.PARAMETER target_url
The target URL to associate with this status. This URL should contain output to keep the user updated while the task is running or serve as historical information for what happened in the deployment. Note: It's recommended to use the log_url parameter, which replaces target_url.
         
.PARAMETER log_url
The full URL of the deployment's output. This parameter replaces target_url. We will continue to accept target_url to support legacy uses, but we recommend replacing target_url with log_url. Setting log_url will automatically set target_url to the same value. Default: ""
         
.PARAMETER description
A short description of the status. The maximum description length is 140 characters.
         
.PARAMETER environment
Name for the target deployment environment, which can be changed when setting a deploy status. For example, production, staging, or qa.
         
.PARAMETER environment_url
Sets the URL for accessing your environment. Default: ""
         
.PARAMETER auto_inactive
Adds a new inactive status to all prior non-transient, non-production environment deployments with the same repository and environment name as the created status's deployment. An inactive status is only added to deployments that had a success state. Default: true


.LINK
https://docs.github.com/en/rest/reference/deployments

.OUTPUTS
 {
  "url": "https://api.github.com/repos/octocat/example/deployments/42/statuses/1",
  "id": 1,
  "node_id": "MDE2OkRlcGxveW1lbnRTdGF0dXMx",
  "state": "success",
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
  "description": "Deployment finished successfully.",
  "environment": "production",
  "target_url": "https://example.com/deployment/42/output",
  "created_at": "2012-07-20T01:19:13Z",
  "updated_at": "2012-07-20T01:19:13Z",
  "deployment_url": "https://api.github.com/repos/octocat/example/deployments/42",
  "repository_url": "https://api.github.com/repos/octocat/example",
  "environment_url": "https://test-branch.lab.acme.com",
  "log_url": "https://example.com/deployment/42/output"
}
#>
Function Create-ADeploymentStatus
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$deployment_id,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$target_url,
		[Parameter(Mandatory=$FALSE)][string]$log_url,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][string]$environment,
		[Parameter(Mandatory=$FALSE)][string]$environment_url,
		[Parameter(Mandatory=$FALSE)][bool]$auto_inactive
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "state",
		"target_url",
		"log_url",
		"description",
		"environment",
		"environment_url",
		"auto_inactive" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/deployments/$deployment_id/statuses?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/deployments/$deployment_id/statuses"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
