
<#
.SYNOPSIS
Returns repository and organization accounts associated with the specified plan, including free plans. For per-seat pricing, you see the list of accounts that have purchased the plan, including the number of seats purchased. When someone submits a plan change that won't be processed until the end of their billing cycle, you will also see the upcoming pending change.
GitHub Apps must use a JWT to access this endpoint. OAuth Apps must use basic authentication with their client ID and client secret to access this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER plan_id
plan_id parameter
         
.PARAMETER sort
One of created (when the repository was starred) or updated (when it was last pushed to).
Default: created
         
.PARAMETER direction
To return the oldest accounts first, set to asc. Can be one of asc or desc. Ignored without the sort parameter.
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/apps
#>
Function List-AccountsForAPlan_Stubbed_
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$plan_id,
		[Parameter(Mandatory=$FALSE)][string]$sort,
		[Parameter(Mandatory=$FALSE)][string]$direction,
		[Parameter(Mandatory=$FALSE)][string]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$page
    )
    $QueryStrings = @("sort=$sort","direction=$direction","per_page=$per_page","page=$page") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/marketplace_listing/stubbed/plans/$plan_id/accounts?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/marketplace_listing/stubbed/plans/$plan_id/accounts"
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
