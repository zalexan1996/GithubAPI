
<#
.SYNOPSIS
Sets the visibility for your primary email addresses.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER visibility
Required. Denotes whether an email is publicly visible.


.LINK
https://docs.github.com/en/rest/reference/users
#>
Function Set-PrimaryEmailVisibilityForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$visibility
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/email/visibility?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/email/visibility"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"visibility" = "$visibility"
    }

    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

