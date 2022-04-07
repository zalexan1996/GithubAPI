<#
.SYNOPSIS
Note: The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty pull_requests array.
Creates a new check run for a specific commit in a repository. Your GitHub App must have the checks:write permission to create check runs.
In a check suite, GitHub limits the number of check runs with the same name to 1000. Once these check runs exceed 1000, GitHub will start to automatically delete older check runs.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER name
Required. The name of the check. For example, "code-coverage".
         
.PARAMETER head_sha
Required. The SHA of the commit.
         
.PARAMETER details_url
The URL of the integrator's site that has the full details of the check. If the integrator does not provide this, then the homepage of the GitHub app is used.
         
.PARAMETER external_id
A reference for the run on the integrator's system.
         
.PARAMETER status
The current status. Can be one of queued, in_progress, or completed.
Default: queued
         
.PARAMETER started_at
The time that the check run began. This is a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ.
         
.PARAMETER conclusion
Required if you provide completed_at or a status of completed. The final conclusion of the check. Can be one of action_required, cancelled, failure, neutral, success, skipped, stale, or timed_out. When the conclusion is action_required, additional details should be provided on the site specified by details_url.
Note: Providing conclusion will automatically set the status parameter to completed. You cannot change a check run conclusion to stale, only GitHub can set this.
         
.PARAMETER completed_at
The time the check completed. This is a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ.
         
.PARAMETER output
Check runs can accept a variety of data in the output object, including a title and summary and can optionally provide descriptive details about the run. See the output object description.
         
.PARAMETER actions
Displays a button on GitHub that can be clicked to alert your app to do additional tasks. For example, a code linting app can display a button that automatically fixes detected errors. The button created in this object is displayed after the check run completes. When a user clicks the button, GitHub sends the check_run.requested_action webhook to your app. Each action includes a label, identifier and description. A maximum of three actions are accepted. See the actions object description. To learn more about check runs and requested actions, see "Check runs and requested actions."


.LINK
https://docs.github.com/en/rest/reference/checks

.OUTPUTS
 {
  "id": 4,
  "head_sha": "ce587453ced02b1526dfb4cb910479d431683101",
  "node_id": "MDg6Q2hlY2tSdW40",
  "external_id": "42",
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
}  {
  "id": 4,
  "head_sha": "ce587453ced02b1526dfb4cb910479d431683101",
  "node_id": "MDg6Q2hlY2tSdW40",
  "external_id": "42",
  "url": "https://api.github.com/repos/github/hello-world/check-runs/4",
  "html_url": "https://github.com/github/hello-world/runs/4",
  "details_url": "https://example.com",
  "status": "in_progress",
  "conclusion": null,
  "started_at": "2018-05-04T01:14:52Z",
  "completed_at": null,
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
#>
Function Create-ACheckRun
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$head_sha,
		[Parameter(Mandatory=$FALSE)][string]$details_url,
		[Parameter(Mandatory=$FALSE)][string]$external_id,
		[Parameter(Mandatory=$FALSE)][string]$status,
		[Parameter(Mandatory=$FALSE)][string]$started_at,
		[Parameter(Mandatory=$FALSE)][string]$conclusion,
		[Parameter(Mandatory=$FALSE)][string]$completed_at,
		[Parameter(Mandatory=$FALSE)][object]$output,
		[Parameter(Mandatory=$FALSE)][object[]]$actions
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "name",
		"head_sha",
		"details_url",
		"external_id",
		"status",
		"started_at",
		"conclusion",
		"completed_at",
		"output",
		"actions" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/check-runs?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/check-runs"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
