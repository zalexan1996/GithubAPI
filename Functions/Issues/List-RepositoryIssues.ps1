<#
.SYNOPSIS
List issues in a repository.
Note: GitHub's REST API v3 considers every pull request an issue, but not every issue is a pull request. For this reason, "Issues" endpoints may return both issues and pull requests in the response. You can identify pull requests by the pull_request key. Be aware that the id of a pull request returned from "Issues" endpoints will be an issue id. To find out the pull request id, use the "List pull requests" endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER milestone
If an integer is passed, it should refer to a milestone by its number field. If the string * is passed, issues with any milestone are accepted. If the string none is passed, issues without milestones are returned.
         
.PARAMETER state
Indicates the state of the issues to return. Can be either open, closed, or all.
Default: open
         
.PARAMETER assignee
Can be the name of a user. Pass in none for issues with no assigned user, and * for issues assigned to any user.
         
.PARAMETER creator
The user that created the issue.
         
.PARAMETER mentioned
A user that's mentioned in the issue.
         
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
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/issues
#>
Function List-RepositoryIssues
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$milestone,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$assignee,
		[Parameter(Mandatory=$FALSE)][string]$creator,
		[Parameter(Mandatory=$FALSE)][string]$mentioned,
		[Parameter(Mandatory=$FALSE)][string]$labels,
		[Parameter(Mandatory=$FALSE)][string]$sort,
		[Parameter(Mandatory=$FALSE)][string]$direction,
		[Parameter(Mandatory=$FALSE)][string]$since,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $QueryStrings = @(
        "milestone=$milestone",
		"state=$state",
		"assignee=$assignee",
		"creator=$creator",
		"mentioned=$mentioned",
		"labels=$labels",
		"sort=$sort",
		"direction=$direction",
		"since=$since",
		"per_page=$per_page",
		"page=$page"
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/issues?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/issues"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
