
<#
.SYNOPSIS
Note: The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty pull_requests array.
Creates a new check run for a specific commit in a repository. Your GitHub App must have the checks:write permission to create check runs.
In a check suite, GitHub limits the number of check runs with the same name to 1000. Once these check runs exceed 1000, GitHub will start to automatically delete older check runs.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER name
Required. The name of the check. For example, "code-coverage".
         
.PARAMETER head_sha
Required. The SHA of the commit.
         
.PARAMETER details_url
The URL of the integrator's site that has the full details of the check. If the integrator does not provide this, then the homepage of the GitHub app is used.
         
.PARAMETER external_id
A reference for the run on the integrator's system.
         
.PARAMETER status
The current status. Can be one of queued, in_progress, or completed.
Default: queued
         
.PARAMETER started_at
The time that the check run began. This is a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ.
         
.PARAMETER conclusion
Required if you provide completed_at or a status of completed. The final conclusion of the check. Can be one of action_required, cancelled, failure, neutral, success, skipped, stale, or timed_out. When the conclusion is action_required, additional details should be provided on the site specified by details_url.
Note: Providing conclusion will automatically set the status parameter to completed. You cannot change a check run conclusion to stale, only GitHub can set this.
         
.PARAMETER completed_at
The time the check completed. This is a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ.
         
.PARAMETER output
Check runs can accept a variety of data in the output object, including a title and summary and can optionally provide descriptive details about the run. See the output object description.
         
.PARAMETER Properties of theoutputobject
Properties of theannotationsitems
Properties of theimagesitems

         
.PARAMETER actions
Displays a button on GitHub that can be clicked to alert your app to do additional tasks. For example, a code linting app can display a button that automatically fixes detected errors. The button created in this object is displayed after the check run completes. When a user clicks the button, GitHub sends the check_run.requested_action webhook to your app. Each action includes a label, identifier and description. A maximum of three actions are accepted. See the actions object description. To learn more about check runs and requested actions, see "Check runs and requested actions."
         
.PARAMETER Properties of theactionsitems



.LINK
https://docs.github.com/en/rest/reference/checks
#>
Function Create-ACheckRun
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$head_sha,
		[Parameter(Mandatory=$FALSE)][string]$details_url,
		[Parameter(Mandatory=$FALSE)][string]$external_id,
		[Parameter(Mandatory=$FALSE)][string]$status,
		[Parameter(Mandatory=$FALSE)][string]$started_at,
		[Parameter(Mandatory=$FALSE)][string]$conclusion,
		[Parameter(Mandatory=$FALSE)][string]$completed_at,
		[Parameter(Mandatory=$FALSE)][string]$output,
		[Parameter(Mandatory=$FALSE)][string]$Properties of theoutputobject
Properties of theannotationsitems
Properties of theimagesitems,
		[Parameter(Mandatory=$FALSE)][string]$actions,
		[Parameter(Mandatory=$FALSE)][string]$Properties of theactionsitems
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/check-runs?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/check-runs"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"name" = "$name"
	"head_sha" = "$head_sha"
	"details_url" = "$details_url"
	"external_id" = "$external_id"
	"status" = "$status"
	"started_at" = "$started_at"
	"conclusion" = "$conclusion"
	"completed_at" = "$completed_at"
	"output" = "$output"
	"actions" = "$actions"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

