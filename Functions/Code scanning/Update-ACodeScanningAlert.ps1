<#
.SYNOPSIS
Updates the status of a single code scanning alert. You must use an access token with the security_events scope to use this endpoint with private repositories. You can also use tokens with the public_repo scope for public repositories only. GitHub Apps must have the security_events write permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER alert_number
The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the number field in the response from the GET /repos/{owner}/{repo}/code-scanning/alerts operation.
         
.PARAMETER state
Required. Sets the state of the code scanning alert. Can be one of open or dismissed. You must provide dismissed_reason when you set the state to dismissed.
         
.PARAMETER dismissed_reason
Required when the state is dismissed. The reason for dismissing or closing the alert. Can be one of: false positive, won't fix, and used in tests.


.LINK
https://docs.github.com/en/rest/reference/code-scanning

.OUTPUTS
 {
  "number": 42,
  "created_at": "2020-08-25T21:28:36Z",
  "url": "https://api.github.com/repos/octocat/hello-world/code-scanning/alerts/42",
  "html_url": "https://github.com/octocat/hello-world/code-scanning/42",
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
  "dismissed_at": "2020-09-02T22:34:56Z",
  "dismissed_reason": "false positive",
  "rule": {
    "id": "js/zipslip",
    "severity": "error",
    "security_severity_level": "high",
    "description": "Arbitrary file write during zip extraction (\"Zip Slip\")",
    "name": "js/zipslip",
    "full_description": "Extracting files from a malicious zip archive without validating that the destination file path is within the destination directory can cause files outside the destination directory to be overwritten.",
    "tags": [
      "security",
      "external/cwe/cwe-022"
    ],
    "help": "# Arbitrary file write during zip extraction (\"Zip Slip\")\\nExtracting files from a malicious zip archive without validating that the destination file path is within the destination directory can cause files outside the destination directory to be overwritten ..."
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
    "state": "dismissed",
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
  "instances_url": "https://api.github.com/repos/octocat/hello-world/code-scanning/alerts/42/instances"
}
#>
Function Update-ACodeScanningAlert
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$alert_number,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$dismissed_reason
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "state",
		"dismissed_reason" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/alerts/$alert_number?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/alerts/$alert_number"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
