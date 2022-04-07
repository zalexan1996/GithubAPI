<#
.SYNOPSIS
Use a non-scoped user-to-server OAuth access token to create a repository scoped and/or permission scoped user-to-server OAuth access token. You can specify which repositories the token can access and which permissions are granted to the token. You must use Basic Authentication when accessing this endpoint, using the OAuth application's client_id and client_secret as the username and password. Invalid tokens will return 404 NOT FOUND.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER client_id
The client ID of your GitHub app.
         
.PARAMETER access_token
Required. The OAuth access token used to authenticate to the GitHub API.
         
.PARAMETER target
The name of the user or organization to scope the user-to-server access token to. Required unless target_id is specified.
         
.PARAMETER target_id
The ID of the user or organization to scope the user-to-server access token to. Required unless target is specified.
         
.PARAMETER repositories
The list of repository names to scope the user-to-server access token to. repositories may not be specified if repository_ids is specified.
         
.PARAMETER repository_ids
The list of repository IDs to scope the user-to-server access token to. repository_ids may not be specified if repositories is specified.
         
.PARAMETER permissions
The permissions granted to the user-to-server access token.


.LINK
https://docs.github.com/en/rest/reference/apps

.OUTPUTS
 {
  "id": 1,
  "url": "https://api.github.com/authorizations/1",
  "scopes": [],
  "token": "ghu_16C7e42F292c6912E7710c838347Ae178B4a",
  "token_last_eight": "Ae178B4a",
  "hashed_token": "25f94a2a5c7fbaf499c665bc73d67c1c87e496da8985131633ee0a95819db2e8",
  "app": {
    "url": "http://my-github-app.com",
    "name": "my github app",
    "client_id": "Iv1.8a61f9b3a7aba766"
  },
  "note": "optional note",
  "note_url": "http://optional/note/url",
  "updated_at": "2011-09-06T20:39:23Z",
  "created_at": "2011-09-06T17:26:27Z",
  "fingerprint": "jklmnop12345678",
  "expires_at": "2011-09-08T17:26:27Z",
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
  "installation": {
    "permissions": {
      "metadata": "read",
      "issues": "write",
      "contents": "read"
    },
    "repository_selection": "selected",
    "single_file_name": ".github/workflow.yml",
    "repositories_url": "https://api.github.com/user/repos",
    "account": {
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
    "has_multiple_single_files": false,
    "single_file_paths": []
  }
}
#>
Function Create-AScopedAccessToken
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$client_id,
		[Parameter(Mandatory=$FALSE)][string]$access_token,
		[Parameter(Mandatory=$FALSE)][string]$target,
		[Parameter(Mandatory=$FALSE)][int]$target_id,
		[Parameter(Mandatory=$FALSE)][string[]]$repositories,
		[Parameter(Mandatory=$FALSE)][int[]]$repository_ids,
		[Parameter(Mandatory=$FALSE)][object]$permissions
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "access_token",
		"target",
		"target_id",
		"repositories",
		"repository_ids",
		"permissions" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/applications/$client_id/token/scoped?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/applications/$client_id/token/scoped"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
