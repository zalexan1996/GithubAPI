<#
.SYNOPSIS
Note: The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty pull_requests array.
Lists check runs for a check suite using its id. GitHub Apps must have the checks:read permission on a private repository or pull access to a public repository to get check runs. OAuth Apps and authenticated users must have the repo scope to get check runs in a private repository.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER check_suite_id
check_suite_id parameter
         
.PARAMETER check_name
Returns check runs with the specified name.
         
.PARAMETER status
Returns check runs with the specified status. Can be one of queued, in_progress, or completed.
         
.PARAMETER filter
Filters check runs by their completed_at timestamp. Can be one of latest (returning the most recent check runs) or all.
Default: latest
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/checks

.OUTPUTS
 {
  "total_count": 1,
  "check_runs": [
    {
      "id": 4,
      "head_sha": "ce587453ced02b1526dfb4cb910479d431683101",
      "node_id": "MDg6Q2hlY2tSdW40",
      "external_id": "",
      "url": "https://api.github.com/repos/github/hello-world/check-runs/4",
      "html_url": "https://github.com/github/hello-world/runs/4",
      "details_url": "https://example.com",
      "status": "completed",
      "conclusion": "neutral",
      "started_at": "2018-05-04T01:14:52Z",
      "completed_at": "2018-05-04T01:14:52Z",
      "output": {
        "title": "Mighty Readme report",
        "summary": "There are 0 failures, 2 warnings, and 1 notice.",
        "text": "You may have some misspelled words on lines 2 and 4. You also may want to add a section in your README about how to install your app.",
        "annotations_count": 2,
        "annotations_url": "https://api.github.com/repos/github/hello-world/check-runs/4/annotations"
      },
      "name": "mighty_readme",
      "check_suite": {
        "id": 5
      },
      "app": {
        "id": 1,
        "slug": "octoapp",
        "node_id": "MDExOkludGVncmF0aW9uMQ==",
        "owner": {
          "login": "github",
          "id": 1,
          "node_id": "MDEyOk9yZ2FuaXphdGlvbjE=",
          "url": "https://api.github.com/orgs/github",
          "repos_url": "https://api.github.com/orgs/github/repos",
          "events_url": "https://api.github.com/orgs/github/events",
          "avatar_url": "https://github.com/images/error/octocat_happy.gif",
          "gravatar_id": "",
          "html_url": "https://github.com/octocat",
          "followers_url": "https://api.github.com/users/octocat/followers",
          "following_url": "https://api.github.com/users/octocat/following{/other_user}",
          "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
          "organizations_url": "https://api.github.com/users/octocat/orgs",
          "received_events_url": "https://api.github.com/users/octocat/received_events",
          "type": "User",
          "site_admin": true
        },
        "name": "Octocat App",
        "description": "",
        "external_url": "https://example.com",
        "html_url": "https://github.com/apps/octoapp",
        "created_at": "2017-07-08T16:18:44-04:00",
        "updated_at": "2017-07-08T16:18:44-04:00",
        "permissions": {
          "metadata": "read",
          "contents": "read",
          "issues": "write",
          "single_file": "write"
        },
        "events": [
          "push",
          "pull_request"
        ]
      },
      "pull_requests": [
        {
          "url": "https://api.github.com/repos/github/hello-world/pulls/1",
          "id": 1934,
          "number": 3956,
          "head": {
            "ref": "say-hello",
            "sha": "3dca65fa3e8d4b3da3f3d056c59aee1c50f41390",
            "repo": {
              "id": 526,
              "url": "https://api.github.com/repos/github/hello-world",
              "name": "hello-world"
            }
          },
          "base": {
            "ref": "master",
            "sha": "e7fdf7640066d71ad16a86fbcbb9c6a10a18af4f",
            "repo": {
              "id": 526,
              "url": "https://api.github.com/repos/github/hello-world",
              "name": "hello-world"
            }
          }
        }
      ]
    }
  ]
}
#>
Function List-CheckRunsInACheckSuite
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$check_suite_id,
		[Parameter(Mandatory=$FALSE)][string]$check_name,
		[Parameter(Mandatory=$FALSE)][string]$status,
		[Parameter(Mandatory=$FALSE)][string]$filter,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $Querys = @()
    $QueryStrings = @(
        "check_name",
		"status",
		"filter",
		"per_page",
		"page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/check-suites/$check_suite_id/check-runs?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/check-suites/$check_suite_id/check-runs"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
