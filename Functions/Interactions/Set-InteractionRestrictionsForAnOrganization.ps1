<#
.SYNOPSIS
Temporarily restricts interactions to a certain type of GitHub user in any public repository in the given organization. You must be an organization owner to set these restrictions. Setting the interaction limit at the organization level will overwrite any interaction limits that are set for individual repositories owned by the organization.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER limit
Required. The type of GitHub user that can comment, open issues, or create pull requests while the interaction limit is in effect. Can be one of: existing_users, contributors_only, collaborators_only.
         
.PARAMETER expiry
The duration of the interaction restriction. Can be one of: one_day, three_days, one_week, one_month, six_months. Default: one_day.


.LINK
https://docs.github.com/en/rest/reference/interactions

.OUTPUTS
 {
  "limit": "collaborators_only",
  "origin": "organization",
  "expires_at": "2018-08-17T04:18:39Z"
}
#>
Function Set-InteractionRestrictionsForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
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
        $FinalURL = "https://api.github.com/orgs/$org/interaction-limits?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/interaction-limits"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
