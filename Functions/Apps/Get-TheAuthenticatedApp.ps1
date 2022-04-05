
<#
.SYNOPSIS
Returns the GitHub App associated with the authentication credentials used. To see how many app installations are associated with this GitHub App, see the installations_count in the response. For more details about your app's installations, see the "List installations for the authenticated app" endpoint.
You must use a JWT to access this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.


.LINK
https://docs.github.com/en/rest/reference/apps
#>
Function Get-TheAuthenticatedApp
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/app?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/app"
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

