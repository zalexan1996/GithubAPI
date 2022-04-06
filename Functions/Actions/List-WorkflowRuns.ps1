<#
.SYNOPSIS
List all workflow runs for a workflow. You can replace workflow_id with the workflow file name. For example, you could use main.yaml. You can use parameters to narrow the list of results. For more information about using parameters, see Parameters.
Anyone with read access to the repository can use this endpoint. If the repository is private you must use an access token with the repo scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER workflow_id
The ID of the workflow. You can also pass the workflow file name as a string.
         
.PARAMETER actor
Returns someone's workflow runs. Use the login for the user who created the push associated with the check suite or workflow run.
         
.PARAMETER branch
Returns workflow runs associated with a branch. Use the name of the branch of the push.
         
.PARAMETER event
Returns workflow run triggered by the event you specify. For example, push, pull_request or issue. For more information, see "Events that trigger workflows."
         
.PARAMETER status
Returns workflow runs with the check run status or conclusion that you specify. For example, a conclusion can be success or a status can be in_progress. Only GitHub can set a status of waiting or requested. For a list of the possible status and conclusion options, see "Create a check run."
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER created
Returns workflow runs created within the given date-time range. For more information on the syntax, see "Understanding the search syntax."
         
.PARAMETER exclude_pull_requests
If true pull requests are omitted from the response (empty array).
         
.PARAMETER check_suite_id
Returns workflow runs with the check_suite_id that you specify.


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function List-WorkflowRuns
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$workflow_id,
		[Parameter(Mandatory=$FALSE)][string]$actor,
		[Parameter(Mandatory=$FALSE)][string]$branch,
		[Parameter(Mandatory=$FALSE)][string]$event,
		[Parameter(Mandatory=$FALSE)][string]$status,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page,
		[Parameter(Mandatory=$FALSE)][string]$created,
		[Parameter(Mandatory=$FALSE)][bool]$exclude_pull_requests,
		[Parameter(Mandatory=$FALSE)][int]$check_suite_id
    )
    $QueryStrings = @(
        "actor=$actor",
		"branch=$branch",
		"event=$event",
		"status=$status",
		"per_page=$per_page",
		"page=$page",
		"created=$created",
		"exclude_pull_requests=$exclude_pull_requests",
		"check_suite_id=$check_suite_id"
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_id/runs?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_id/runs"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
