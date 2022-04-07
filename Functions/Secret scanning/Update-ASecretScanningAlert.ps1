<#
.SYNOPSIS
Updates the status of a secret scanning alert in an eligible repository. To use this endpoint, you must be an administrator for the repository or for the organization that owns the repository, and you must use a personal access token with the repo scope or security_events scope. For public repositories, you may instead use the public_repo scope.
GitHub Apps must have the secret_scanning_alerts write permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER alert_number
The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the number field in the response from the GET /repos/{owner}/{repo}/code-scanning/alerts operation.
         
.PARAMETER state
Required. Sets the state of the secret scanning alert. Can be either open or resolved. You must provide resolution when you set the state to resolved.
         
.PARAMETER resolution
Required when the state is resolved. The reason for resolving the alert. Can be one of false_positive, wont_fix, revoked, or used_in_tests.


.LINK
https://docs.github.com/en/rest/reference/secret-scanning

.OUTPUTS
 {
  "number": 42,
  "created_at": "2020-11-06T18:18:30Z",
  "url": "https://api.github.com/repos/owner/private-repo/secret-scanning/alerts/42",
  "html_url": "https://github.com/owner/private-repo/security/secret-scanning/42",
  "locations_url": "https://api.github.com/repos/owner/private-repo/secret-scanning/alerts/42/locations",
  "state": "resolved",
  "resolution": "used_in_tests",
  "resolved_at": "2020-11-16T22:42:07Z",
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
  "secret_type": "mailchimp_api_key",
  "secret_type_display_name": "Mailchimp API Key",
  "secret": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-us2"
}
#>
Function Update-ASecretScanningAlert
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$alert_number,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$resolution
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "state",
		"resolution" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/secret-scanning/alerts/$alert_number?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/secret-scanning/alerts/$alert_number"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
