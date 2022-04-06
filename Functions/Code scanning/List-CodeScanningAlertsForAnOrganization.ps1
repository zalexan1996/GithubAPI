<#
.SYNOPSIS
Lists all code scanning alerts for the default branch (usually main or master) for all eligible repositories in an organization. To use this endpoint, you must be an administrator or security manager for the organization, and you must use an access token with the repo scope or security_events scope.
GitHub Apps must have the security_events read permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER before
A cursor, as given in the Link header. If specified, the query only searches for events before this cursor.
         
.PARAMETER after
A cursor, as given in the Link header. If specified, the query only searches for events after this cursor.
         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER direction
One of asc (ascending) or desc (descending).
Default: desc
         
.PARAMETER state
Set to open, closed, fixed, or dismissed` to list code scanning alerts in a specific state.
         
.PARAMETER sort
Can be one of created, updated.
Default: created


.LINK
https://docs.github.com/en/rest/reference/code-scanning
#>
Function List-CodeScanningAlertsForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$before,
		[Parameter(Mandatory=$FALSE)][string]$after,
		[Parameter(Mandatory=$FALSE)][int]$page,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$direction,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$sort
    )
    $QueryStrings = @(
        "before=$before",
		"after=$after",
		"page=$page",
		"per_page=$per_page",
		"direction=$direction",
		"state=$state",
		"sort=$sort"
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/code-scanning/alerts?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/code-scanning/alerts"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
