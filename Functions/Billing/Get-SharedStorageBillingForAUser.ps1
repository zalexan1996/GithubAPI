<#
.SYNOPSIS
Gets the estimated paid and estimated total storage used for GitHub Actions and GitHub Packages.
Paid minutes only apply to packages stored for private repositories. For more information, see "Managing billing for GitHub Packages."
Access tokens must have the user scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER username



.LINK
https://docs.github.com/en/rest/reference/billing

.OUTPUTS
 {
  "days_left_in_billing_cycle": 20,
  "estimated_paid_storage_for_month": 15,
  "estimated_storage_for_month": 40
}
#>
Function Get-SharedStorageBillingForAUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$username
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/users/$username/settings/billing/shared-storage?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/users/$username/settings/billing/shared-storage"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
