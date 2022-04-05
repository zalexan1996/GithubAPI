
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
#>
Function Review-PendingDeploymentsForAWorkflowRun
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$run_id,
		[Parameter(Mandatory=$FALSE)][string]$environment_ids,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$comment
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runs/$run_id/pending_deployments?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runs/$run_id/pending_deployments"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"environment_ids" = "$environment_ids"
	"state" = "$state"
	"comment" = "$comment"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

