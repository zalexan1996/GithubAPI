
<#
.SYNOPSIS
This endpoint is accessible with the user scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER emails
Required. Adds one or more email addresses to your GitHub account. Must contain at least one email address. Note: Alternatively, you can pass a single email address or an array of emails addresses directly, but we recommend that you pass an object using the emails key.


.LINK
https://docs.github.com/en/rest/reference/users
#>
Function Add-AnEmailAddressForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$emails
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/emails?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/emails"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"emails" = "$emails"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

