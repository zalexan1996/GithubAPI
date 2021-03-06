<#
.SYNOPSIS
Temporarily restricts which type of GitHub user can interact with your public repositories. Setting the interaction limit at the user level will overwrite any interaction limits that are set for individual repositories owned by the user.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER limit
Required. The type of GitHub user that can comment, open issues, or create pull requests while the interaction limit is in effect. Can be one of: existing_users, contributors_only, collaborators_only.
         
.PARAMETER expiry
The duration of the interaction restriction. Can be one of: one_day, three_days, one_week, one_month, six_months. Default: one_day.


.LINK
https://docs.github.com/en/rest/reference/interactions

.OUTPUTS
 {
  "limit": "collaborators_only",
  "origin": "user",
  "expires_at": "2018-08-17T04:18:39Z"
}
#>
Function Set-InteractionRestrictionsForYourPublicRepositories
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$limit,
		[Parameter(Mandatory=$FALSE)][string]$expiry
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "limit",
		"expiry" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/user/interaction-limits?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/interaction-limits"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
