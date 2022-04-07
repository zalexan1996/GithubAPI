<#
.SYNOPSIS
Lists all organizations, in the order that they were created on GitHub.
Note: Pagination is powered exclusively by the since parameter. Use the Link header to get the URL for the next page of organizations.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER since
An organization ID. Only return organizations with an ID greater than this ID.
         
.PARAMETER per_page
Results per page (max 100)
Default: 30


.LINK
https://docs.github.com/en/rest/reference/orgs

.OUTPUTS
 [
  {
    "login": "github",
    "id": 1,
    "node_id": "MDEyOk9yZ2FuaXphdGlvbjE=",
    "url": "https://api.github.com/orgs/github",
    "repos_url": "https://api.github.com/orgs/github/repos",
    "events_url": "https://api.github.com/orgs/github/events",
    "hooks_url": "https://api.github.com/orgs/github/hooks",
    "issues_url": "https://api.github.com/orgs/github/issues",
    "members_url": "https://api.github.com/orgs/github/members{/member}",
    "public_members_url": "https://api.github.com/orgs/github/public_members{/member}",
    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
    "description": "A great organization"
  }
]
#>
Function List-Organizations
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$since,
		[Parameter(Mandatory=$FALSE)][int]$per_page
    )
    $Querys = @()
    $QueryStrings = @(
        "since",
		"per_page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/organizations?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/organizations"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
