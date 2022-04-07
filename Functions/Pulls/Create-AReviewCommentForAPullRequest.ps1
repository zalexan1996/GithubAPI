<#
.SYNOPSIS
Creates a review comment in the pull request diff. To add a regular comment to a pull request timeline, see "Create an issue comment." We recommend creating a review comment using line, side, and optionally start_line and start_side if your comment applies to more than one line in the pull request diff.
You can still create a review comment using the position parameter. When you use position, the line, side, start_line, and start_side parameters are not required.
Note: The position value equals the number of lines down from the first "@@" hunk header in the file you want to add a comment. The line just below the "@@" line is position 1, the next line is position 2, and so on. The position in the diff continues to increase through lines of whitespace and additional hunks until the beginning of a new file.
This endpoint triggers notifications. Creating content too quickly using this endpoint may result in secondary rate limiting. See "Secondary rate limits" and "Dealing with secondary rate limits" for details.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER pull_number

         
.PARAMETER body
Required. The text of the review comment.
         
.PARAMETER commit_id
The SHA of the commit needing a comment. Not using the latest commit SHA may render your comment outdated if a subsequent commit modifies the line you specify as the position.
         
.PARAMETER path
The relative path to the file that necessitates a comment.
         
.PARAMETER position
The position in the diff where you want to add a review comment. Note this value is not the same as the line number in the file. For help finding the position value, read the note above.
         
.PARAMETER side
In a split diff view, the side of the diff that the pull request's changes appear on. Can be LEFT or RIGHT. Use LEFT for deletions that appear in red. Use RIGHT for additions that appear in green or unchanged lines that appear in white and are shown for context. For a multi-line comment, side represents whether the last line of the comment range is a deletion or addition. For more information, see "Diff view options" in the GitHub Help documentation.
         
.PARAMETER line
The line of the blob in the pull request diff that the comment applies to. For a multi-line comment, the last line of the range that your comment applies to.
         
.PARAMETER start_line
Required when using multi-line comments unless using in_reply_to. The start_line is the first line in the pull request diff that your multi-line comment applies to. To learn more about multi-line comments, see "Commenting on a pull request" in the GitHub Help documentation.
         
.PARAMETER start_side
Required when using multi-line comments unless using in_reply_to. The start_side is the starting side of the diff that the comment applies to. Can be LEFT or RIGHT. To learn more about multi-line comments, see "Commenting on a pull request" in the GitHub Help documentation. See side in this table for additional context.
         
.PARAMETER in_reply_to
The ID of the review comment to reply to. To find the ID of a review comment with "List review comments on a pull request". When specified, all parameters other than body in the request body are ignored.


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
Function Create-AReviewCommentForAPullRequest
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$pull_number,
		[Parameter(Mandatory=$FALSE)][string]$body,
		[Parameter(Mandatory=$FALSE)][string]$commit_id,
		[Parameter(Mandatory=$FALSE)][string]$path,
		[Parameter(Mandatory=$FALSE)][int]$position,
		[Parameter(Mandatory=$FALSE)][string]$side,
		[Parameter(Mandatory=$FALSE)][int]$line,
		[Parameter(Mandatory=$FALSE)][int]$start_line,
		[Parameter(Mandatory=$FALSE)][string]$start_side,
		[Parameter(Mandatory=$FALSE)][int]$in_reply_to
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "body",
		"commit_id",
		"path",
		"position",
		"side",
		"line",
		"start_line",
		"start_side",
		"in_reply_to" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/$pull_number/comments?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/$pull_number/comments"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
