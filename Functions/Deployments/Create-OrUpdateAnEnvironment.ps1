
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
#>
Function Create-OrUpdateAnEnvironment
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$environment_name,
		[Parameter(Mandatory=$FALSE)][string]$wait_timer,
		[Parameter(Mandatory=$FALSE)][string]$reviewers,
		[Parameter(Mandatory=$FALSE)][string]$deployment_branch_policy
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/environments/$environment_name?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/environments/$environment_name"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"wait_timer" = "$wait_timer"
	"reviewers" = "$reviewers"
	"deployment_branch_policy" = "$deployment_branch_policy"
    }

    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

