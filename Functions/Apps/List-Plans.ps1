<#
.SYNOPSIS
Lists all plans that are part of your GitHub Marketplace listing.
GitHub Apps must use a JWT to access this endpoint. OAuth Apps must use basic authentication with their client ID and client secret to access this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/apps

.OUTPUTS
 [
  {
    "url": "https://api.github.com/marketplace_listing/plans/1313",
    "accounts_url": "https://api.github.com/marketplace_listing/plans/1313/accounts",
    "id": 1313,
    "number": 3,
    "name": "Pro",
    "description": "A professional-grade CI solution",
    "monthly_price_in_cents": 1099,
    "yearly_price_in_cents": 11870,
    "price_model": "flat-rate",
    "has_free_trial": true,
    "unit_name": null,
    "state": "published",
    "bullets": [
      "Up to 25 private repositories",
      "11 concurrent builds"
    ]
  }
]
#>
Function List-Plans
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
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
        $FinalURL = "https://api.github.com/marketplace_listing/plans?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/marketplace_listing/plans"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
