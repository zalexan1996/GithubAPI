
<#
.SYNOPSIS
List issues assigned to the authenticated user across all visible repositories including owned repositories, member repositories, and organization repositories. You can use the filter query parameter to fetch issues that are not necessarily assigned to you.
Note: GitHub's REST API v3 considers every pull request an issue, but not every issue is a pull request. For this reason, "Issues" endpoints may return both issues and pull requests in the response. You can identify pull requests by the pull_request key. Be aware that the id of a pull request returned from "Issues" endpoints will be an issue id. To find out the pull request id, use the "List pull requests" endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER filter
Indicates which sorts of issues to return. Can be one of:
* assigned: Issues assigned to you
* created: Issues created by you
* mentioned: Issues mentioning you
* subscribed: Issues you're subscribed to updates for
* all or repos: All issues the authenticated user can see, regardless of participation or creation
Default: assigned
         
.PARAMETER state
Indicates the state of the issues to return. Can be either open, closed, or all.
Default: open
         
.PARAMETER labels
A list of comma separated label names. Example: bug,ui,@high
         
.PARAMETER sort
What to sort results by. Can be either created, updated, comments.
Default: created
         
.PARAMETER direction
One of asc (ascending) or desc (descending).
Default: desc
         
.PARAMETER since
Only show notifications updated after the given time. This is a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ.
         
.PARAMETER collab

         
.PARAMETER orgs

         
.PARAMETER owned

         
.PARAMETER pulls

         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/issues
#>
Function List-IssuesAssignedToTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$filter,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$labels,
		[Parameter(Mandatory=$FALSE)][string]$sort,
		[Parameter(Mandatory=$FALSE)][string]$direction,
		[Parameter(Mandatory=$FALSE)][string]$since,
		[Parameter(Mandatory=$FALSE)][string]$collab,
		[Parameter(Mandatory=$FALSE)][string]$orgs,
		[Parameter(Mandatory=$FALSE)][string]$owned,
		[Parameter(Mandatory=$FALSE)][string]$pulls,
		[Parameter(Mandatory=$FALSE)][string]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$page
    )
    $QueryStrings = @("filter=$filter","state=$state","labels=$labels","sort=$sort","direction=$direction","since=$since","collab=$collab","orgs=$orgs","owned=$owned","pulls=$pulls","per_page=$per_page","page=$page") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/issues?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/issues"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

