<#
.SYNOPSIS
Gets the GitHub Advanced Security active committers for an enterprise per repository. Each distinct user login across all repositories is counted as a single Advanced Security seat, so the total_advanced_security_committers is not the sum of active_users for each repository.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/enterprise-admin

.OUTPUTS
 {
  "total_advanced_security_committers": 2,
  "repositories": [
    {
      "name": "octocat-org/Hello-World",
      "advanced_security_committers": 2,
      "advanced_security_committers_breakdown": [
        {
          "user_login": "octocat",
          "last_pushed_date": "2021-11-03"
        },
        {
          "user_login": "octokitten",
          "last_pushed_date": "2021-10-25"
        }
      ]
    },
    {
      "name": "octocat-org/server",
      "advanced_security_committers": 1,
      "advanced_security_committers_breakdown": [
        {
          "user_login": "octokitten",
          "last_pushed_date": "2021-10-26"
        }
      ]
    }
  ]
}
#>
Function Get-GithubAdvancedSecurityActiveCommittersForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $Querys = @()
    $QueryStrings = @(
        "per_page",
		"page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/settings/billing/advanced-security?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/settings/billing/advanced-security"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
