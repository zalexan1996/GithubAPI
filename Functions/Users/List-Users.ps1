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
		[Parameter(Mandatory=$FALSE)][int]$since,
		[Parameter(Mandatory=$FALSE)][int]$per_page
    )
    $QueryStrings = @(
        "since=$since",
		"per_page=$per_page"
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/users?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/users"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
