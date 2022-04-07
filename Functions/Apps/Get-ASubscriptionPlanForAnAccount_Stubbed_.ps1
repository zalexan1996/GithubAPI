<#
.SYNOPSIS
Shows whether the user or organization account actively subscribes to a plan listed by the authenticated GitHub App. When someone submits a plan change that won't be processed until the end of their billing cycle, you will also see the upcoming pending change.
GitHub Apps must use a JWT to access this endpoint. OAuth Apps must use basic authentication with their client ID and client secret to access this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER account_id
account_id parameter


.LINK
https://docs.github.com/en/rest/reference/apps

.OUTPUTS
 {
  "url": "https://api.github.com/orgs/github",
  "type": "Organization",
  "id": 4,
  "login": "github",
  "organization_billing_email": "billing@github.com",
  "email": "billing@github.com",
  "marketplace_pending_change": {
    "effective_date": "2017-11-11T00:00:00Z",
    "unit_count": null,
    "id": 77,
    "plan": {
      "url": "https://api.github.com/marketplace_listing/plans/1111",
      "accounts_url": "https://api.github.com/marketplace_listing/plans/1111/accounts",
      "id": 1111,
      "number": 2,
      "name": "Startup",
      "description": "A professional-grade CI solution",
      "monthly_price_in_cents": 699,
      "yearly_price_in_cents": 7870,
      "price_model": "flat-rate",
      "has_free_trial": true,
      "state": "published",
      "unit_name": null,
      "bullets": [
        "Up to 10 private repositories",
        "3 concurrent builds"
      ]
    }
  },
  "marketplace_purchase": {
    "billing_cycle": "monthly",
    "next_billing_date": "2017-11-11T00:00:00Z",
    "unit_count": null,
    "on_free_trial": true,
    "free_trial_ends_on": "2017-11-11T00:00:00Z",
    "updated_at": "2017-11-02T01:12:12Z",
    "plan": {
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
  }
}
#>
Function Get-ASubscriptionPlanForAnAccount_Stubbed_
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$account_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/marketplace_listing/stubbed/accounts/$account_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/marketplace_listing/stubbed/accounts/$account_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
