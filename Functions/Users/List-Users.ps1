
<#
.SYNOPSIS
Lists all users, in the order that they signed up on GitHub. This list includes personal user accounts and organization accounts.
Note: Pagination is powered exclusively by the since parameter. Use the Link header to get the URL for the next page of users.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER since
A user ID. Only return users with an ID greater than this ID.
         
.PARAMETER per_page
Results per page (max 100)
Default: 30


.LINK
https://docs.github.com/en/rest/reference/users
#>
Function List-Users
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$since,
		[Parameter(Mandatory=$FALSE)][string]$per_page
    )
    $QueryStrings = @("since=$since","per_page=$per_page") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/users?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/users"
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

