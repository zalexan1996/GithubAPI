<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER username

         
.PARAMETER state
Indicates the state of the projects to return. Can be either open, closed, or all.
Default: open
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/projects

.OUTPUTS
 [
  {
    "owner_url": "https://api.github.com/users/octocat",
    "url": "https://api.github.com/projects/1002603",
    "html_url": "https://github.com/users/octocat/projects/1",
    "columns_url": "https://api.github.com/projects/1002603/columns",
    "id": 1002603,
    "node_id": "MDc6UHJvamVjdDEwMDI2MDM=",
    "name": "My Projects",
    "body": "A board to manage my personal projects.",
    "number": 1,
    "state": "open",
    "creator": {
      "login": "octocat",
      "id": 1,
      "node_id": "MDQ6VXNlcjE=",
      "avatar_url": "https://github.com/images/error/octocat_happy.gif",
      "gravatar_id": "",
      "url": "https://api.github.com/users/octocat",
      "html_url": "https://github.com/octocat",
      "followers_url": "https://api.github.com/users/octocat/followers",
      "following_url": "https://api.github.com/users/octocat/following{/other_user}",
      "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
      "organizations_url": "https://api.github.com/users/octocat/orgs",
      "repos_url": "https://api.github.com/users/octocat/repos",
      "events_url": "https://api.github.com/users/octocat/events{/privacy}",
      "received_events_url": "https://api.github.com/users/octocat/received_events",
      "type": "User",
      "site_admin": false
    },
    "created_at": "2011-04-10T20:09:31Z",
    "updated_at": "2014-03-03T18:58:10Z"
  }
]
#>
Function List-UserProjects
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$username,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $Querys = @()
    $QueryStrings = @(
        "state",
		"per_page",
		"page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/users/$username/projects?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/users/$username/projects"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
