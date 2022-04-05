
<#
.SYNOPSIS
Removes a GitHub App installation suspension.
You must use a JWT to access this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER installation_id
installation_id parameter


.LINK
https://docs.github.com/en/rest/reference/apps
#>
Function Unsuspend-AnAppInstallation
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$installation_id
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/app/installations/$installation_id/suspended?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/app/installations/$installation_id/suspended"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method DELETE -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
