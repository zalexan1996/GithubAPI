
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
#>
Function Create-ADeploymentStatus
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$deployment_id,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$target_url,
		[Parameter(Mandatory=$FALSE)][string]$log_url,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][string]$environment,
		[Parameter(Mandatory=$FALSE)][string]$environment_url,
		[Parameter(Mandatory=$FALSE)][string]$auto_inactive
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/deployments/$deployment_id/statuses?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/deployments/$deployment_id/statuses"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"state" = "$state"
	"target_url" = "$target_url"
	"log_url" = "$log_url"
	"description" = "$description"
	"environment" = "$environment"
	"environment_url" = "$environment_url"
	"auto_inactive" = "$auto_inactive"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

