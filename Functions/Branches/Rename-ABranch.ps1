<#
.SYNOPSIS
Renames a branch in a repository.
Note: Although the API responds immediately, the branch rename process might take some extra time to complete in the background. You won't be able to push to the old branch name while the rename process is in progress. For more information, see "Renaming a branch".
The permissions required to use this endpoint depends on whether you are renaming the default branch.
To rename a non-default branch:
Users must have push access.
GitHub Apps must have the contents:write repository permission.
To rename the default branch:
Users must have admin or owner permissions.
GitHub Apps must have the administration:write repository permission.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER branch
The name of the branch.
         
.PARAMETER new_name
Required. The new name of the branch.


.LINK
https://docs.github.com/en/rest/reference/branches

.OUTPUTS
 {
  "name": "master",
  "commit": {
    "sha": "7fd1a60b01f91b314f59955a4e4d4e80d8edf11d",
    "node_id": "MDY6Q29tbWl0N2ZkMWE2MGIwMWY5MWIzMTRmNTk5NTVhNGU0ZDRlODBkOGVkZjExZA==",
    "commit": {
      "author": {
        "name": "The Octocat",
        "date": "2012-03-06T15:06:50-08:00",
        "email": "octocat@nowhere.com"
      },
      "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/7fd1a60b01f91b314f59955a4e4d4e80d8edf11d",
      "message": "Merge pull request #6 from Spaceghost/patch-1\n\nNew line at end of file.",
      "tree": {
        "sha": "b4eecafa9be2f2006ce1b709d6857b07069b4608",
        "url": "https://api.github.com/repos/octocat/Hello-World/git/trees/b4eecafa9be2f2006ce1b709d6857b07069b4608"
      },
      "committer": {
        "name": "The Octocat",
        "date": "2012-03-06T15:06:50-08:00",
        "email": "octocat@nowhere.com"
      },
      "verification": {
        "verified": false,
        "reason": "unsigned",
        "signature": null,
        "payload": null
      },
      "comment_count": 0
    },
    "author": {
      "gravatar_id": "",
      "avatar_url": "https://secure.gravatar.com/avatar/7ad39074b0584bc555d0417ae3e7d974?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
      "url": "https://api.github.com/users/octocat",
      "id": 583231,
      "login": "octocat",
      "node_id": "MDQ6VXNlcjE=",
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
      "site_admin": true
    },
    "parents": [
      {
        "sha": "553c2077f0edc3d5dc5d17262f6aa498e69d6f8e",
        "url": "https://api.github.com/repos/octocat/Hello-World/commits/553c2077f0edc3d5dc5d17262f6aa498e69d6f8e"
      },
      {
        "sha": "762941318ee16e59dabbacb1b4049eec22f0d303",
        "url": "https://api.github.com/repos/octocat/Hello-World/commits/762941318ee16e59dabbacb1b4049eec22f0d303"
      }
    ],
    "url": "https://api.github.com/repos/octocat/Hello-World/commits/7fd1a60b01f91b314f59955a4e4d4e80d8edf11d",
    "committer": {
      "gravatar_id": "",
      "avatar_url": "https://secure.gravatar.com/avatar/7ad39074b0584bc555d0417ae3e7d974?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
      "url": "https://api.github.com/users/octocat",
      "id": 583231,
      "login": "octocat",
      "node_id": "MDQ6VXNlcjE=",
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
      "site_admin": true
    },
    "html_url": "https://github.com/octocat/Hello-World/commit/6dcb09b5b57875f334f61aebed695e2e4193db5e",
    "comments_url": "https://api.github.com/repos/octocat/Hello-World/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e/comments"
  },
  "_links": {
    "html": "https://github.com/octocat/Hello-World/tree/master",
    "self": "https://api.github.com/repos/octocat/Hello-World/branches/master"
  },
  "protected": true,
  "protection": {
    "required_status_checks": {
      "enforcement_level": "non_admins",
      "contexts": [
        "ci-test",
        "linter"
      ]
    }
  },
  "protection_url": "https://api.github.com/repos/octocat/hello-world/branches/master/protection"
}
#>
Function Rename-ABranch
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$branch,
		[Parameter(Mandatory=$FALSE)][string]$new_name
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "new_name" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/branches/$branch/rename?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/branches/$branch/rename"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
