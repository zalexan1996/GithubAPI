<#
.SYNOPSIS
Deployments offer a few configurable parameters with certain defaults.
The ref parameter can be any named branch, tag, or SHA. At GitHub we often deploy branches and verify them before we merge a pull request.
The environment parameter allows deployments to be issued to different runtime environments. Teams often have multiple environments for verifying their applications, such as production, staging, and qa. This parameter makes it easier to track which environments have requested deployments. The default environment is production.
The auto_merge parameter is used to ensure that the requested ref is not behind the repository's default branch. If the ref is behind the default branch for the repository, we will attempt to merge it for you. If the merge succeeds, the API will return a successful merge commit. If merge conflicts prevent the merge from succeeding, the API will return a failure response.
By default, commit statuses for every submitted context must be in a success state. The required_contexts parameter allows you to specify a subset of contexts that must be success, or to specify contexts that have not yet been submitted. You are not required to use commit statuses to deploy. If you do not require any contexts or create any commit statuses, the deployment will always succeed.
The payload parameter is available for any extra information that a deployment system might need. It is a JSON text field that will be passed on when a deployment event is dispatched.
The task parameter is used by the deployment system to allow different execution paths. In the web world this might be deploy:migrations to run schema changes on the system. In the compiled world this could be a flag to compile an application with debugging enabled.
Users with repo or repo_deployment scopes can create a deployment for a given ref.
Merged branch response
You will see this response when GitHub automatically merges the base branch into the topic branch instead of creating a deployment. This auto-merge happens when:
Auto-merge option is enabled in the repository
Topic branch does not include the latest changes on the base branch, which is master in the response example
There are no merge conflicts
If there are no new commits in the base branch, a new request to create a deployment should give a successful response.
Merge conflict response
This error happens when the auto_merge option is enabled and when the default branch (in this case master), can't be merged into the branch that's being deployed (in this case topic-branch), due to merge conflicts.
Failed commit status checks
This error happens when the required_contexts parameter indicates that one or more contexts need to have a success status for the commit to be deployed, but one or more of the required contexts do not have a state of success.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER ref
Required. The ref to deploy. This can be a branch, tag, or SHA.
         
.PARAMETER task
Specifies a task to execute (e.g., deploy or deploy:migrations).
Default: deploy
         
.PARAMETER auto_merge
Attempts to automatically merge the default branch into the requested ref, if it's behind the default branch.
Default:
         
.PARAMETER required_contexts
The status contexts to verify against commit status checks. If you omit this parameter, GitHub verifies all unique contexts before creating a deployment. To bypass checking entirely, pass an empty array. Defaults to all unique contexts.
         
.PARAMETER payload
JSON payload with extra information about the deployment.
         
.PARAMETER environment
Name for the target deployment environment (e.g., production, staging, qa).
Default: production
         
.PARAMETER description
Short description of the deployment.
         
.PARAMETER transient_environment
Specifies if the given environment is specific to the deployment and will no longer exist at some point in the future. Default: false
         
.PARAMETER production_environment
Specifies if the given environment is one that end-users directly interact with. Default: true when environment is production and false otherwise.


.LINK
https://docs.github.com/en/rest/reference/deployments

.OUTPUTS
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
}  {
  "message": "Auto-merged master into topic-branch on deployment."
}
#>
Function Create-ADeployment
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$ref,
		[Parameter(Mandatory=$FALSE)][string]$task,
		[Parameter(Mandatory=$FALSE)][bool]$auto_merge,
		[Parameter(Mandatory=$FALSE)][string[]]$required_contexts,
		[Parameter(Mandatory=$FALSE)][string]$payload,
		[Parameter(Mandatory=$FALSE)][string]$environment,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][bool]$transient_environment,
		[Parameter(Mandatory=$FALSE)][bool]$production_environment
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "ref",
		"task",
		"auto_merge",
		"required_contexts",
		"payload",
		"environment",
		"description",
		"transient_environment",
		"production_environment" 
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
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
