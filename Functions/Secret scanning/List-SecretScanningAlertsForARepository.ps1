<#
.SYNOPSIS
Lists secret scanning alerts for an eligible repository, from newest to oldest. To use this endpoint, you must be an administrator for the repository or for the organization that owns the repository, and you must use a personal access token with the repo scope or security_events scope. For public repositories, you may instead use the public_repo scope.
GitHub Apps must have the secret_scanning_alerts read permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER state
Set to open or resolved to only list secret scanning alerts in a specific state.
         
.PARAMETER secret_type
A comma-separated list of secret types to return. By default all secret types are returned. See "Secret scanning patterns" for a complete list of secret types (API slug).
         
.PARAMETER resolution
A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are false_positive, wont_fix, revoked, pattern_edited, pattern_deleted or used_in_tests.
         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER per_page
Results per page (max 100)
Default: 30


.LINK
https://docs.github.com/en/rest/reference/secret-scanning

.OUTPUTS
 [
  {
    "number": 2,
    "created_at": "2020-11-06T18:48:51Z",
    "url": "https://api.github.com/repos/owner/private-repo/secret-scanning/alerts/2",
    "html_url": "https://github.com/owner/private-repo/security/secret-scanning/2",
    "locations_url": "https://api.github.com/repos/owner/private-repo/secret-scanning/alerts/2/locations",
    "state": "resolved",
    "resolution": "false_positive",
    "resolved_at": "2020-11-07T02:47:13Z",
    "resolved_by": {
      "login": "monalisa",
      "id": 2,
      "node_id": "MDQ6VXNlcjI=",
      "avatar_url": "https://alambic.github.com/avatars/u/2?",
      "gravatar_id": "",
      "url": "https://api.github.com/users/monalisa",
      "html_url": "https://github.com/monalisa",
      "followers_url": "https://api.github.com/users/monalisa/followers",
      "following_url": "https://api.github.com/users/monalisa/following{/other_user}",
      "gists_url": "https://api.github.com/users/monalisa/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/monalisa/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/monalisa/subscriptions",
      "organizations_url": "https://api.github.com/users/monalisa/orgs",
      "repos_url": "https://api.github.com/users/monalisa/repos",
      "events_url": "https://api.github.com/users/monalisa/events{/privacy}",
      "received_events_url": "https://api.github.com/users/monalisa/received_events",
      "type": "User",
      "site_admin": true
    },
    "secret_type": "adafruit_io_key",
    "secret_type_display_name": "Adafruit IO Key",
    "secret": "aio_XXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  },
  {
    "number": 1,
    "created_at": "2020-11-06T18:18:30Z",
    "url": "https://api.github.com/repos/owner/repo/secret-scanning/alerts/1",
    "html_url": "https://github.com/owner/repo/security/secret-scanning/1",
    "locations_url": "https://api.github.com/repos/owner/private-repo/secret-scanning/alerts/1/locations",
    "state": "open",
    "resolution": null,
    "resolved_at": null,
    "resolved_by": null,
    "secret_type": "mailchimp_api_key",
    "secret_type_display_name": "Mailchimp API Key",
    "secret": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-us2"
  }
]
#>
Function List-SecretScanningAlertsForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$secret_type,
		[Parameter(Mandatory=$FALSE)][string]$resolution,
		[Parameter(Mandatory=$FALSE)][int]$page,
		[Parameter(Mandatory=$FALSE)][int]$per_page
    )
    $Querys = @()
    $QueryStrings = @(
        "state",
		"secret_type",
		"resolution",
		"page",
		"per_page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/secret-scanning/alerts?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/secret-scanning/alerts"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
