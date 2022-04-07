<#
.SYNOPSIS
List all workflow runs for a workflow. You can replace workflow_id with the workflow file name. For example, you could use main.yaml. You can use parameters to narrow the list of results. For more information about using parameters, see Parameters.
Anyone with read access to the repository can use this endpoint. If the repository is private you must use an access token with the repo scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER workflow_id
The ID of the workflow. You can also pass the workflow file name as a string.
         
.PARAMETER actor
Returns someone's workflow runs. Use the login for the user who created the push associated with the check suite or workflow run.
         
.PARAMETER branch
Returns workflow runs associated with a branch. Use the name of the branch of the push.
         
.PARAMETER event
Returns workflow run triggered by the event you specify. For example, push, pull_request or issue. For more information, see "Events that trigger workflows."
         
.PARAMETER status
Returns workflow runs with the check run status or conclusion that you specify. For example, a conclusion can be success or a status can be in_progress. Only GitHub can set a status of waiting or requested. For a list of the possible status and conclusion options, see "Create a check run."
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER created
Returns workflow runs created within the given date-time range. For more information on the syntax, see "Understanding the search syntax."
         
.PARAMETER exclude_pull_requests
If true pull requests are omitted from the response (empty array).
         
.PARAMETER check_suite_id
Returns workflow runs with the check_suite_id that you specify.


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "total_count": 1,
  "workflow_runs": [
    {
      "id": 30433642,
      "name": "Build",
      "node_id": "MDEyOldvcmtmbG93IFJ1bjI2OTI4OQ==",
      "check_suite_id": 42,
      "check_suite_node_id": "MDEwOkNoZWNrU3VpdGU0Mg==",
      "head_branch": "master",
      "head_sha": "acb5820ced9479c074f688cc328bf03f341a511d",
      "run_number": 562,
      "event": "push",
      "status": "queued",
      "conclusion": null,
      "workflow_id": 159038,
      "url": "https://api.github.com/repos/octo-org/octo-repo/actions/runs/30433642",
      "html_url": "https://github.com/octo-org/octo-repo/actions/runs/30433642",
      "pull_requests": [],
      "created_at": "2020-01-22T19:33:08Z",
      "updated_at": "2020-01-22T19:33:08Z",
      "actor": {
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
      "run_attempt": 1,
      "run_started_at": "2020-01-22T19:33:08Z",
      "triggering_actor": {
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
      "jobs_url": "https://api.github.com/repos/octo-org/octo-repo/actions/runs/30433642/jobs",
      "logs_url": "https://api.github.com/repos/octo-org/octo-repo/actions/runs/30433642/logs",
      "check_suite_url": "https://api.github.com/repos/octo-org/octo-repo/check-suites/414944374",
      "artifacts_url": "https://api.github.com/repos/octo-org/octo-repo/actions/runs/30433642/artifacts",
      "cancel_url": "https://api.github.com/repos/octo-org/octo-repo/actions/runs/30433642/cancel",
      "rerun_url": "https://api.github.com/repos/octo-org/octo-repo/actions/runs/30433642/rerun",
      "workflow_url": "https://api.github.com/repos/octo-org/octo-repo/actions/workflows/159038",
      "head_commit": {
        "id": "acb5820ced9479c074f688cc328bf03f341a511d",
        "tree_id": "d23f6eedb1e1b9610bbc754ddb5197bfe7271223",
        "message": "Create linter.yaml",
        "timestamp": "2020-01-22T19:33:05Z",
        "author": {
          "name": "Octo Cat",
          "email": "octocat@github.com"
        },
        "committer": {
          "name": "GitHub",
          "email": "noreply@github.com"
        }
      },
      "repository": {
        "id": 1296269,
        "node_id": "MDEwOlJlcG9zaXRvcnkxMjk2MjY5",
        "name": "Hello-World",
        "full_name": "octocat/Hello-World",
        "owner": {
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
        "private": false,
        "html_url": "https://github.com/octocat/Hello-World",
        "description": "This your first repo!",
        "fork": false,
        "url": "https://api.github.com/repos/octocat/Hello-World",
        "archive_url": "https://api.github.com/repos/octocat/Hello-World/{archive_format}{/ref}",
        "assignees_url": "https://api.github.com/repos/octocat/Hello-World/assignees{/user}",
        "blobs_url": "https://api.github.com/repos/octocat/Hello-World/git/blobs{/sha}",
        "branches_url": "https://api.github.com/repos/octocat/Hello-World/branches{/branch}",
        "collaborators_url": "https://api.github.com/repos/octocat/Hello-World/collaborators{/collaborator}",
        "comments_url": "https://api.github.com/repos/octocat/Hello-World/comments{/number}",
        "commits_url": "https://api.github.com/repos/octocat/Hello-World/commits{/sha}",
        "compare_url": "https://api.github.com/repos/octocat/Hello-World/compare/{base}...{head}",
        "contents_url": "https://api.github.com/repos/octocat/Hello-World/contents/{+path}",
        "contributors_url": "https://api.github.com/repos/octocat/Hello-World/contributors",
        "deployments_url": "https://api.github.com/repos/octocat/Hello-World/deployments",
        "downloads_url": "https://api.github.com/repos/octocat/Hello-World/downloads",
        "events_url": "https://api.github.com/repos/octocat/Hello-World/events",
        "forks_url": "https://api.github.com/repos/octocat/Hello-World/forks",
        "git_commits_url": "https://api.github.com/repos/octocat/Hello-World/git/commits{/sha}",
        "git_refs_url": "https://api.github.com/repos/octocat/Hello-World/git/refs{/sha}",
        "git_tags_url": "https://api.github.com/repos/octocat/Hello-World/git/tags{/sha}",
        "git_url": "git:github.com/octocat/Hello-World.git",
        "issue_comment_url": "https://api.github.com/repos/octocat/Hello-World/issues/comments{/number}",
        "issue_events_url": "https://api.github.com/repos/octocat/Hello-World/issues/events{/number}",
        "issues_url": "https://api.github.com/repos/octocat/Hello-World/issues{/number}",
        "keys_url": "https://api.github.com/repos/octocat/Hello-World/keys{/key_id}",
        "labels_url": "https://api.github.com/repos/octocat/Hello-World/labels{/name}",
        "languages_url": "https://api.github.com/repos/octocat/Hello-World/languages",
        "merges_url": "https://api.github.com/repos/octocat/Hello-World/merges",
        "milestones_url": "https://api.github.com/repos/octocat/Hello-World/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/octocat/Hello-World/notifications{?since,all,participating}",
        "pulls_url": "https://api.github.com/repos/octocat/Hello-World/pulls{/number}",
        "releases_url": "https://api.github.com/repos/octocat/Hello-World/releases{/id}",
        "ssh_url": "git@github.com:octocat/Hello-World.git",
        "stargazers_url": "https://api.github.com/repos/octocat/Hello-World/stargazers",
        "statuses_url": "https://api.github.com/repos/octocat/Hello-World/statuses/{sha}",
        "subscribers_url": "https://api.github.com/repos/octocat/Hello-World/subscribers",
        "subscription_url": "https://api.github.com/repos/octocat/Hello-World/subscription",
        "tags_url": "https://api.github.com/repos/octocat/Hello-World/tags",
        "teams_url": "https://api.github.com/repos/octocat/Hello-World/teams",
        "trees_url": "https://api.github.com/repos/octocat/Hello-World/git/trees{/sha}",
        "hooks_url": "http://api.github.com/repos/octocat/Hello-World/hooks"
      },
      "head_repository": {
        "id": 217723378,
        "node_id": "MDEwOlJlcG9zaXRvcnkyMTc3MjMzNzg=",
        "name": "octo-repo",
        "full_name": "octo-org/octo-repo",
        "private": true,
        "owner": {
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
        "html_url": "https://github.com/octo-org/octo-repo",
        "description": null,
        "fork": false,
        "url": "https://api.github.com/repos/octo-org/octo-repo",
        "forks_url": "https://api.github.com/repos/octo-org/octo-repo/forks",
        "keys_url": "https://api.github.com/repos/octo-org/octo-repo/keys{/key_id}",
        "collaborators_url": "https://api.github.com/repos/octo-org/octo-repo/collaborators{/collaborator}",
        "teams_url": "https://api.github.com/repos/octo-org/octo-repo/teams",
        "hooks_url": "https://api.github.com/repos/octo-org/octo-repo/hooks",
        "issue_events_url": "https://api.github.com/repos/octo-org/octo-repo/issues/events{/number}",
        "events_url": "https://api.github.com/repos/octo-org/octo-repo/events",
        "assignees_url": "https://api.github.com/repos/octo-org/octo-repo/assignees{/user}",
        "branches_url": "https://api.github.com/repos/octo-org/octo-repo/branches{/branch}",
        "tags_url": "https://api.github.com/repos/octo-org/octo-repo/tags",
        "blobs_url": "https://api.github.com/repos/octo-org/octo-repo/git/blobs{/sha}",
        "git_tags_url": "https://api.github.com/repos/octo-org/octo-repo/git/tags{/sha}",
        "git_refs_url": "https://api.github.com/repos/octo-org/octo-repo/git/refs{/sha}",
        "trees_url": "https://api.github.com/repos/octo-org/octo-repo/git/trees{/sha}",
        "statuses_url": "https://api.github.com/repos/octo-org/octo-repo/statuses/{sha}",
        "languages_url": "https://api.github.com/repos/octo-org/octo-repo/languages",
        "stargazers_url": "https://api.github.com/repos/octo-org/octo-repo/stargazers",
        "contributors_url": "https://api.github.com/repos/octo-org/octo-repo/contributors",
        "subscribers_url": "https://api.github.com/repos/octo-org/octo-repo/subscribers",
        "subscription_url": "https://api.github.com/repos/octo-org/octo-repo/subscription",
        "commits_url": "https://api.github.com/repos/octo-org/octo-repo/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/octo-org/octo-repo/git/commits{/sha}",
        "comments_url": "https://api.github.com/repos/octo-org/octo-repo/comments{/number}",
        "issue_comment_url": "https://api.github.com/repos/octo-org/octo-repo/issues/comments{/number}",
        "contents_url": "https://api.github.com/repos/octo-org/octo-repo/contents/{+path}",
        "compare_url": "https://api.github.com/repos/octo-org/octo-repo/compare/{base}...{head}",
        "merges_url": "https://api.github.com/repos/octo-org/octo-repo/merges",
        "archive_url": "https://api.github.com/repos/octo-org/octo-repo/{archive_format}{/ref}",
        "downloads_url": "https://api.github.com/repos/octo-org/octo-repo/downloads",
        "issues_url": "https://api.github.com/repos/octo-org/octo-repo/issues{/number}",
        "pulls_url": "https://api.github.com/repos/octo-org/octo-repo/pulls{/number}",
        "milestones_url": "https://api.github.com/repos/octo-org/octo-repo/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/octo-org/octo-repo/notifications{?since,all,participating}",
        "labels_url": "https://api.github.com/repos/octo-org/octo-repo/labels{/name}",
        "releases_url": "https://api.github.com/repos/octo-org/octo-repo/releases{/id}",
        "deployments_url": "https://api.github.com/repos/octo-org/octo-repo/deployments"
      }
    }
  ]
}
#>
Function List-WorkflowRuns
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$workflow_id,
		[Parameter(Mandatory=$FALSE)][string]$actor,
		[Parameter(Mandatory=$FALSE)][string]$branch,
		[Parameter(Mandatory=$FALSE)][string]$event,
		[Parameter(Mandatory=$FALSE)][string]$status,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page,
		[Parameter(Mandatory=$FALSE)][string]$created,
		[Parameter(Mandatory=$FALSE)][bool]$exclude_pull_requests,
		[Parameter(Mandatory=$FALSE)][int]$check_suite_id
    )
    $Querys = @()
    $QueryStrings = @(
        "actor",
		"branch",
		"event",
		"status",
		"per_page",
		"page",
		"created",
		"exclude_pull_requests",
		"check_suite_id"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_id/runs?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_id/runs"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
