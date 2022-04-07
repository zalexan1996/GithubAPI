<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER pull_number

         
.PARAMETER review_id
review_id parameter
         
.PARAMETER body
The body text of the pull request review
         
.PARAMETER event
Required. The review action you want to perform. The review actions include: APPROVE, REQUEST_CHANGES, or COMMENT. When you leave this blank, the API returns HTTP 422 (Unrecognizable entity) and sets the review action state to PENDING, which means you will need to re-submit the pull request review using a review action.


.LINK
https://docs.github.com/en/rest/reference/pulls

.OUTPUTS
 {
  "id": 80,
  "node_id": "MDE3OlB1bGxSZXF1ZXN0UmV2aWV3ODA=",
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
  "body": "Here is the body for the review.",
  "state": "APPROVED",
  "html_url": "https://github.com/octocat/Hello-World/pull/12#pullrequestreview-80",
  "pull_request_url": "https://api.github.com/repos/octocat/Hello-World/pulls/12",
  "_links": {
    "html": {
      "href": "https://github.com/octocat/Hello-World/pull/12#pullrequestreview-80"
    },
    "pull_request": {
      "href": "https://api.github.com/repos/octocat/Hello-World/pulls/12"
    }
  },
  "submitted_at": "2019-11-17T17:43:43Z",
  "commit_id": "ecdd80bb57125d7ba9641ffaa4d7d2c19d3f3091",
  "author_association": "COLLABORATOR"
}
#>
Function Submit-AReviewForAPullRequest
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$pull_number,
		[Parameter(Mandatory=$FALSE)][int]$review_id,
		[Parameter(Mandatory=$FALSE)][string]$body,
		[Parameter(Mandatory=$FALSE)][string]$event
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "body",
		"event" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/$pull_number/reviews/$review_id/events?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/$pull_number/reviews/$review_id/events"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
