
<#
.SYNOPSIS
Gets the free and paid storage used for GitHub Packages in gigabytes.
Paid minutes only apply to packages stored for private repositories. For more information, see "Managing billing for GitHub Packages."
Access tokens must have the user scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER username



.LINK
https://docs.github.com/en/rest/reference/billing
#>
Function Get-GithubPackagesBillingForAUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$username
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/users/$username/settings/billing/packages?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/users/$username/settings/billing/packages"
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
