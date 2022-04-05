
<#
.SYNOPSIS
Note: If your email is set to private and you send an email parameter as part of this request to update your profile, your privacy settings are still enforced: the email address will not be displayed on your public profile or via the API.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER name
The new name of the user.
         
.PARAMETER email
The publicly visible email address of the user.
         
.PARAMETER blog
The new blog URL of the user.
         
.PARAMETER twitter_username
The new Twitter username of the user.
         
.PARAMETER company
The new company of the user.
         
.PARAMETER location
The new location of the user.
         
.PARAMETER hireable
The new hiring availability of the user.
         
.PARAMETER bio
The new short biography of the user.


.LINK
https://docs.github.com/en/rest/reference/users
#>
Function Update-TheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$email,
		[Parameter(Mandatory=$FALSE)][string]$blog,
		[Parameter(Mandatory=$FALSE)][string]$twitter_username,
		[Parameter(Mandatory=$FALSE)][string]$company,
		[Parameter(Mandatory=$FALSE)][string]$location,
		[Parameter(Mandatory=$FALSE)][string]$hireable,
		[Parameter(Mandatory=$FALSE)][string]$bio
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"name" = "$name"
	"email" = "$email"
	"blog" = "$blog"
	"twitter_username" = "$twitter_username"
	"company" = "$company"
	"location" = "$location"
	"hireable" = "$hireable"
	"bio" = "$bio"
    }

    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

