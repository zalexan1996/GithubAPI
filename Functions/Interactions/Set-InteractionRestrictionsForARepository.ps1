
<#
.SYNOPSIS
Temporarily restricts interactions to a certain type of GitHub user within the given repository. You must have owner or admin access to set these restrictions. If an interaction limit is set for the user or organization that owns this repository, you will receive a 409 Conflict response and will not be able to use this endpoint to change the interaction limit for a single repository.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER limit
Required. The type of GitHub user that can comment, open issues, or create pull requests while the interaction limit is in effect. Can be one of: existing_users, contributors_only, collaborators_only.
         
.PARAMETER expiry
The duration of the interaction restriction. Can be one of: one_day, three_days, one_week, one_month, six_months. Default: one_day.


.LINK
https://docs.github.com/en/rest/reference/interactions
#>
Function Set-InteractionRestrictionsForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$limit,
		[Parameter(Mandatory=$FALSE)][string]$expiry
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/interaction-limits?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/interaction-limits"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"limit" = "$limit"
	"expiry" = "$expiry"
    }

    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

