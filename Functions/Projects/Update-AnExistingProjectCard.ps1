<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER card_id
card_id parameter
         
.PARAMETER note
The project card's note
         
.PARAMETER archived
Whether or not the card is archived


.LINK
https://docs.github.com/en/rest/reference/projects

.OUTPUTS
 {
  "url": "https://api.github.com/projects/columns/cards/1478",
  "id": 1478,
  "node_id": "MDExOlByb2plY3RDYXJkMTQ3OA==",
  "note": "Add payload for delete Project column",
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
  "created_at": "2016-09-05T14:21:06Z",
  "updated_at": "2016-09-05T14:20:22Z",
  "archived": false,
  "column_url": "https://api.github.com/projects/columns/367",
  "content_url": "https://api.github.com/repos/api-playground/projects-test/issues/3",
  "project_url": "https://api.github.com/projects/120"
}
#>
Function Update-AnExistingProjectCard
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$card_id,
		[Parameter(Mandatory=$FALSE)][string]$note,
		[Parameter(Mandatory=$FALSE)][bool]$archived
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "note",
		"archived" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/projects/columns/cards/$card_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/projects/columns/cards/$card_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
