<#
.SYNOPSIS
Note: The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty pull_requests array.
Lists check runs for a commit ref. The ref can be a SHA, branch name, or a tag name. GitHub Apps must have the checks:read permission on a private repository or pull access to a public repository to get check runs. OAuth Apps and authenticated users must have the repo scope to get check runs in a private repository.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER ref
ref parameter
         
.PARAMETER check_name
Returns check runs with the specified name.
         
.PARAMETER status
Returns check runs with the specified status. Can be one of queued, in_progress, or completed.
         
.PARAMETER filter
Filters check runs by their completed_at timestamp. Can be one of latest (returning the most recent check runs) or all.
Default: latest
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER app_id



.LINK
https://docs.github.com/en/rest/reference/checks
#>
Function List-CheckRunsForAGitReference
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$ref,
		[Parameter(Mandatory=$FALSE)][string]$check_name,
		[Parameter(Mandatory=$FALSE)][string]$status,
		[Parameter(Mandatory=$FALSE)][string]$filter,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page,
		[Parameter(Mandatory=$FALSE)][int]$app_id
    )
    $QueryStrings = @(
        "check_name=$check_name",
		"status=$status",
		"filter=$filter",
		"per_page=$per_page",
		"page=$page",
		"app_id=$app_id"
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/commits/$ref/check-runs?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/commits/$ref/check-runs"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
