
<#
.SYNOPSIS
Returns meta information about GitHub, including a list of GitHub's IP addresses. For more information, see "About GitHub's IP addresses."
Note: The IP addresses shown in the documentation's response are only example values. You must always query the API directly to get the latest list of IP addresses.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.


.LINK
https://docs.github.com/en/rest/reference/meta
#>
Function Get-GithubMetaInformation
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/meta?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/meta"
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

