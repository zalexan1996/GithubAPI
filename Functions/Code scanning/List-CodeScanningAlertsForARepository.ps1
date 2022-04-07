<#
.SYNOPSIS
Lists all open code scanning alerts for the default branch (usually main or master). You must use an access token with the security_events scope to use this endpoint with private repos, the public_repo scope also grants permission to read security events on public repos only. GitHub Apps must have the security_events read permission to use this endpoint.
The response includes a most_recent_instance object. This provides details of the most recent instance of this alert for the default branch or for the specified Git reference (if you used ref in the request).

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER tool_name
The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either tool_name or tool_guid, but not both.
         
.PARAMETER tool_guid
The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either tool_guid or tool_name, but not both.
         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER ref
The Git reference for the results you want to list. The ref for a branch can be formatted either as refs/heads/<branch name> or simply <branch name>. To reference a pull request use refs/pull/<number>/merge.
         
.PARAMETER direction
One of asc (ascending) or desc (descending).
Default: desc
         
.PARAMETER sort
Can be one of created, updated, number.
Default: number
         
.PARAMETER state
Set to open, closed, fixed, or dismissed` to list code scanning alerts in a specific state.


.LINK
https://docs.github.com/en/rest/reference/code-scanning

.OUTPUTS
 [
  {
    "number": 4,
    "created_at": "2020-02-13T12:29:18Z",
    "url": "https://api.github.com/repos/octocat/hello-world/code-scanning/alerts/4",
    "html_url": "https://github.com/octocat/hello-world/code-scanning/4",
    "state": "open",
    "fixed_at": null,
    "dismissed_by": null,
    "dismissed_at": null,
    "dismissed_reason": null,
    "rule": {
      "id": "js/zipslip",
      "severity": "error",
      "tags": [
        "security",
        "external/cwe/cwe-022"
      ],
      "description": "Arbitrary file write during zip extraction",
      "name": "js/zipslip"
    },
    "tool": {
      "name": "CodeQL",
      "guid": null,
      "version": "2.4.0"
    },
    "most_recent_instance": {
      "ref": "refs/heads/main",
      "analysis_key": ".github/workflows/codeql-analysis.yml:CodeQL-Build",
      "environment": "{}",
      "state": "open",
      "commit_sha": "39406e42cb832f683daa691dd652a8dc36ee8930",
      "message": {
        "text": "This path depends on a user-provided value."
      },
      "location": {
        "path": "spec-main/api-session-spec.ts",
        "start_line": 917,
        "end_line": 917,
        "start_column": 7,
        "end_column": 18
      },
      "classifications": [
        "test"
      ]
    },
    "instances_url": "https://api.github.com/repos/octocat/hello-world/code-scanning/alerts/4/instances"
  },
  {
    "number": 3,
    "created_at": "2020-02-13T12:29:18Z",
    "url": "https://api.github.com/repos/octocat/hello-world/code-scanning/alerts/3",
    "html_url": "https://github.com/octocat/hello-world/code-scanning/3",
    "state": "dismissed",
    "fixed_at": null,
    "dismissed_by": {
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
    "dismissed_at": "2020-02-14T12:29:18Z",
    "dismissed_reason": "false positive",
    "rule": {
      "id": "js/zipslip",
      "severity": "error",
      "tags": [
        "security",
        "external/cwe/cwe-022"
      ],
      "description": "Arbitrary file write during zip extraction",
      "name": "js/zipslip"
    },
    "tool": {
      "name": "CodeQL",
      "guid": null,
      "version": "2.4.0"
    },
    "most_recent_instance": {
      "ref": "refs/heads/main",
      "analysis_key": ".github/workflows/codeql-analysis.yml:CodeQL-Build",
      "environment": "{}",
      "state": "open",
      "commit_sha": "39406e42cb832f683daa691dd652a8dc36ee8930",
      "message": {
        "text": "This path depends on a user-provided value."
      },
      "location": {
        "path": "lib/ab12-gen.js",
        "start_line": 917,
        "end_line": 917,
        "start_column": 7,
        "end_column": 18
      },
      "classifications": []
    },
    "instances_url": "https://api.github.com/repos/octocat/hello-world/code-scanning/alerts/3/instances"
  }
]
#>
Function List-CodeScanningAlertsForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$tool_name,
		[Parameter(Mandatory=$FALSE)][stringnull]$tool_guid,
		[Parameter(Mandatory=$FALSE)][int]$page,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$ref,
		[Parameter(Mandatory=$FALSE)][string]$direction,
		[Parameter(Mandatory=$FALSE)][string]$sort,
		[Parameter(Mandatory=$FALSE)][string]$state
    )
    $Querys = @()
    $QueryStrings = @(
        "tool_name",
		"tool_guid",
		"page",
		"per_page",
		"ref",
		"direction",
		"sort",
		"state"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/alerts?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/alerts"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
