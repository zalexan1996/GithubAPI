<#
.SYNOPSIS
Creates a new discussion post on a team's page. OAuth access tokens require the write:discussion scope.
This endpoint triggers notifications. Creating content too quickly using this endpoint may result in secondary rate limiting. See "Secondary rate limits" and "Dealing with secondary rate limits" for details.
Note: You can also specify a team by org_id and team_id using the route POST /organizations/{org_id}/team/{team_id}/discussions.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER team_slug
team_slug parameter
         
.PARAMETER title
Required. The discussion post's title.
         
.PARAMETER body
Required. The discussion post's body text.
         
.PARAMETER private
Private posts are only visible to team members, organization owners, and team maintainers. Public posts are visible to all members of the organization. Set to true to create a private post.


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
  "body": "Hi! This is an area for us to collaborate as a team.",
  "body_html": "<p>Hi! This is an area for us to collaborate as a team</p>",
  "body_version": "0d495416a700fb06133c612575d92bfb",
  "comments_count": 0,
  "comments_url": "https://api.github.com/teams/2343027/discussions/1/comments",
  "created_at": "2018-01-25T18:56:31Z",
  "last_edited_at": null,
  "html_url": "https://github.com/orgs/github/teams/justice-league/discussions/1",
  "node_id": "MDE0OlRlYW1EaXNjdXNzaW9uMQ==",
  "number": 1,
  "pinned": false,
  "private": false,
  "team_url": "https://api.github.com/teams/2343027",
  "title": "Our first team post",
  "updated_at": "2018-01-25T18:56:31Z",
  "url": "https://api.github.com/teams/2343027/discussions/1",
  "reactions": {
    "url": "https://api.github.com/teams/2343027/discussions/1/reactions",
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
Function Create-ADiscussion
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$team_slug,
		[Parameter(Mandatory=$FALSE)][string]$title,
		[Parameter(Mandatory=$FALSE)][string]$body,
		[Parameter(Mandatory=$FALSE)][bool]$private
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "title",
		"body",
		"private" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/discussions?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/discussions"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
