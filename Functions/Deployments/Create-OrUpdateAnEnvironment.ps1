<#
.SYNOPSIS
Create or update an environment with protection rules, such as required reviewers. For more information about environment protection rules, see "Environments."
Note: Although you can use this operation to specify that only branches that match specified name patterns can deploy to this environment, you must use the UI to set the name patterns. For more information, see "Environments."
Note: To create or update secrets for an environment, see "Secrets."
You must authenticate using an access token with the repo scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER environment_name
The name of the environment
         
.PARAMETER wait_timer
The amount of time to delay a job after the job is initially triggered. The time (in minutes) must be an integer between 0 and 43,200 (30 days).
         
.PARAMETER reviewers
The people or teams that may review jobs that reference the environment. You can list up to six users or teams as reviewers. The reviewers must have at least read access to the repository. Only one of the required reviewers needs to approve the job for it to proceed.
         
.PARAMETER deployment_branch_policy
The type of deployment branch policy for this environment. To allow all branches to deploy, set to null.


.LINK
https://docs.github.com/en/rest/reference/deployments

.OUTPUTS
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
#>
Function Create-OrUpdateAnEnvironment
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$environment_name,
		[Parameter(Mandatory=$FALSE)][int]$wait_timer,
		[Parameter(Mandatory=$FALSE)][string]$reviewers,
		[Parameter(Mandatory=$FALSE)][string]$deployment_branch_policy
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "wait_timer",
		"reviewers",
		"deployment_branch_policy" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/environments/$environment_name?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/environments/$environment_name"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
