<#
.SYNOPSIS
This endpoint is accessible with the user scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER emails
Required. Adds one or more email addresses to your GitHub account. Must contain at least one email address. Note: Alternatively, you can pass a single email address or an array of emails addresses directly, but we recommend that you pass an object using the emails key.


.LINK
https://docs.github.com/en/rest/reference/users

.OUTPUTS
 [
  {
    "email": "octocat@octocat.org",
    "primary": false,
    "verified": false,
    "visibility": "public"
  },
  {
    "email": "octocat@github.com",
    "primary": false,
    "verified": false,
    "visibility": null
  },
  {
    "email": "mona@github.com",
    "primary": false,
    "verified": false,
    "visibility": null
  }
]
#>
Function Add-AnEmailAddressForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string[]]$emails
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "emails" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/user/emails?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/emails"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
