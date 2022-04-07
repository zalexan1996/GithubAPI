<#
.SYNOPSIS
Enables you to edit a review comment.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER comment_id
comment_id parameter
         
.PARAMETER body
Required. The text of the reply to the review comment.


.LINK
https://docs.github.com/en/rest/reference/pulls

.OUTPUTS
 {
  "url": "https://api.github.com/repos/octocat/Hello-World/pulls/comments/1",
  "pull_request_review_id": 42,
  "id": 10,
  "node_id": "MDI0OlB1bGxSZXF1ZXN0UmV2aWV3Q29tbWVudDEw",
  "diff_hunk": "@@ -16,33 +16,40 @@ public class Connection : IConnection...",
  "path": "file1.txt",
  "position": 1,
  "original_position": 4,
  "commit_id": "6dcb09b5b57875f334f61aebed695e2e4193db5e",
  "original_commit_id": "9c48853fa3dc5c1c3d6f1f1cd1f2743e72652840",
  "in_reply_to_id": 8,
  "user": {
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
  "body": "Great stuff!",
  "created_at": "2011-04-14T16:00:49Z",
  "updated_at": "2011-04-14T16:00:49Z",
  "html_url": "https://github.com/octocat/Hello-World/pull/1#discussion-diff-1",
  "pull_request_url": "https://api.github.com/repos/octocat/Hello-World/pulls/1",
  "author_association": "NONE",
  "_links": {
    "self": {
      "href": "https://api.github.com/repos/octocat/Hello-World/pulls/comments/1"
    },
    "html": {
      "href": "https://github.com/octocat/Hello-World/pull/1#discussion-diff-1"
    },
    "pull_request": {
      "href": "https://api.github.com/repos/octocat/Hello-World/pulls/1"
    }
  },
  "start_line": 1,
  "original_start_line": 1,
  "start_side": "RIGHT",
  "line": 2,
  "original_line": 2,
  "side": "RIGHT"
}
#>
Function Update-AReviewCommentForAPullRequest
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$comment_id,
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
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/comments/$comment_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/comments/$comment_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
