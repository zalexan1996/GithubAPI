<#
.SYNOPSIS
Lists all public repositories in the order that they were created.
Note:
For GitHub Enterprise Server, this endpoint will only list repositories available to all users on the enterprise.
Pagination is powered exclusively by the since parameter. Use the Link header to get the URL for the next page of repositories.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER since
A repository ID. Only return repositories with an ID greater than this ID.


.LINK
https://docs.github.com/en/rest/reference/repos
#>
Function List-PublicRepositories
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$since
    )
    $QueryStrings = @(
        "since=$since"
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repositories?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repositories"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
