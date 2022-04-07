<#
.SYNOPSIS
Edits the body text of a discussion comment. OAuth access tokens require the write:discussion scope.
Note: You can also specify a team by org_id and team_id using the route PATCH /organizations/{org_id}/team/{team_id}/discussions/{discussion_number}/comments/{comment_number}.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER team_slug
team_slug parameter
         
.PARAMETER discussion_number

         
.PARAMETER comment_number

         
.PARAMETER body
Required. The discussion comment's body text.


.LINK
https://docs.github.com/en/rest/reference/teams

.OUTPUTS
 {
  "author": {
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
  "body": "Do you like pineapples?",
  "body_html": "<p>Do you like pineapples?</p>",
  "body_version": "e6907b24d9c93cc0c5024a7af5888116",
  "created_at": "2018-01-15T23:53:58Z",
  "last_edited_at": "2018-01-26T18:22:20Z",
  "discussion_url": "https://api.github.com/teams/2403582/discussions/1",
  "html_url": "https://github.com/orgs/github/teams/justice-league/discussions/1/comments/1",
  "node_id": "MDIxOlRlYW1EaXNjdXNzaW9uQ29tbWVudDE=",
  "number": 1,
  "updated_at": "2018-01-26T18:22:20Z",
  "url": "https://api.github.com/teams/2403582/discussions/1/comments/1",
  "reactions": {
    "url": "https://api.github.com/teams/2403582/discussions/1/reactions",
    "total_count": 5,
    "+1": 3,
    "-1": 1,
    "laugh": 0,
    "confused": 0,
    "heart": 1,
    "hooray": 0,
    "eyes": 1,
    "rocket": 1
  }
}
#>
Function Update-ADiscussionComment
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$team_slug,
		[Parameter(Mandatory=$FALSE)][int]$discussion_number,
		[Parameter(Mandatory=$FALSE)][int]$comment_number,
		[Parameter(Mandatory=$FALSE)][string]$body
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "body" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/discussions/$discussion_number/comments/$comment_number?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/discussions/$discussion_number/comments/$comment_number"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
