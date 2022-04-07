<#
.SYNOPSIS
Gets a specific package for a package owned by the authenticated user.
To use this endpoint, you must authenticate using an access token with the packages:read scope. If package_type is not container, your token must also include the repo scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER package_type
The type of supported package. Can be one of npm, maven, rubygems, nuget, docker, or container. Packages in GitHub's Gradle registry have the type maven. Docker images pushed to GitHub's Container registry (ghcr.io) have the type container. You can use the type docker to find images that were pushed to GitHub's Docker registry (docker.pkg.github.com), even if these have now been migrated to the Container registry.
         
.PARAMETER package_name
The name of the package.


.LINK
https://docs.github.com/en/rest/reference/packages

.OUTPUTS
 {
  "id": 40201,
  "name": "octo-name",
  "package_type": "rubygems",
  "owner": {
    "login": "octocat",
    "id": 209477,
    "node_id": "MDQ6VXNlcjIwOTQ3Nw==",
    "avatar_url": "https://avatars.githubusercontent.com/u/209477?v=4",
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
    "site_admin": true
  },
  "version_count": 3,
  "visibility": "public",
  "url": "https://api.github.com/users/octocat/packages/rubygems/octo-name",
  "created_at": "2019-10-20T14:17:14Z",
  "updated_at": "2019-10-20T14:17:14Z",
  "repository": {
    "id": 216219492,
    "node_id": "MDEwOlJlcG9zaXRvcnkyMTYyMTk0OTI=",
    "name": "octo-name-repo",
    "full_name": "octocat/octo-name-repo",
    "private": false,
    "owner": {
      "login": "octocat",
      "id": 209477,
      "node_id": "MDQ6VXNlcjIwOTQ3Nw==",
      "avatar_url": "https://avatars.githubusercontent.com/u/209477?v=4",
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
      "site_admin": true
    },
    "html_url": "https://github.com/octocat/octo-name-repo",
    "description": "Project for octocats",
    "fork": false,
    "url": "https://api.github.com/repos/octocat/octo-name-repo",
    "forks_url": "https://api.github.com/repos/octocat/octo-name-repo/forks",
    "keys_url": "https://api.github.com/repos/octocat/octo-name-repo/keys{/key_id}",
    "collaborators_url": "https://api.github.com/repos/octocat/octo-name-repo/collaborators{/collaborator}",
    "teams_url": "https://api.github.com/repos/octocat/octo-name-repo/teams",
    "hooks_url": "https://api.github.com/repos/octocat/octo-name-repo/hooks",
    "issue_events_url": "https://api.github.com/repos/octocat/octo-name-repo/issues/events{/number}",
    "events_url": "https://api.github.com/repos/octocat/octo-name-repo/events",
    "assignees_url": "https://api.github.com/repos/octocat/octo-name-repo/assignees{/user}",
    "branches_url": "https://api.github.com/repos/octocat/octo-name-repo/branches{/branch}",
    "tags_url": "https://api.github.com/repos/octocat/octo-name-repo/tags",
    "blobs_url": "https://api.github.com/repos/octocat/octo-name-repo/git/blobs{/sha}",
    "git_tags_url": "https://api.github.com/repos/octocat/octo-name-repo/git/tags{/sha}",
    "git_refs_url": "https://api.github.com/repos/octocat/octo-name-repo/git/refs{/sha}",
    "trees_url": "https://api.github.com/repos/octocat/octo-name-repo/git/trees{/sha}",
    "statuses_url": "https://api.github.com/repos/octocat/octo-name-repo/statuses/{sha}",
    "languages_url": "https://api.github.com/repos/octocat/octo-name-repo/languages",
    "stargazers_url": "https://api.github.com/repos/octocat/octo-name-repo/stargazers",
    "contributors_url": "https://api.github.com/repos/octocat/octo-name-repo/contributors",
    "subscribers_url": "https://api.github.com/repos/octocat/octo-name-repo/subscribers",
    "subscription_url": "https://api.github.com/repos/octocat/octo-name-repo/subscription",
    "commits_url": "https://api.github.com/repos/octocat/octo-name-repo/commits{/sha}",
    "git_commits_url": "https://api.github.com/repos/octocat/octo-name-repo/git/commits{/sha}",
    "comments_url": "https://api.github.com/repos/octocat/octo-name-repo/comments{/number}",
    "issue_comment_url": "https://api.github.com/repos/octocat/octo-name-repo/issues/comments{/number}",
    "contents_url": "https://api.github.com/repos/octocat/octo-name-repo/contents/{+path}",
    "compare_url": "https://api.github.com/repos/octocat/octo-name-repo/compare/{base}...{head}",
    "merges_url": "https://api.github.com/repos/octocat/octo-name-repo/merges",
    "archive_url": "https://api.github.com/repos/octocat/octo-name-repo/{archive_format}{/ref}",
    "downloads_url": "https://api.github.com/repos/octocat/octo-name-repo/downloads",
    "issues_url": "https://api.github.com/repos/octocat/octo-name-repo/issues{/number}",
    "pulls_url": "https://api.github.com/repos/octocat/octo-name-repo/pulls{/number}",
    "milestones_url": "https://api.github.com/repos/octocat/octo-name-repo/milestones{/number}",
    "notifications_url": "https://api.github.com/repos/octocat/octo-name-repo/notifications{?since,all,participating}",
    "labels_url": "https://api.github.com/repos/octocat/octo-name-repo/labels{/name}",
    "releases_url": "https://api.github.com/repos/octocat/octo-name-repo/releases{/id}",
    "deployments_url": "https://api.github.com/repos/octocat/octo-name-repo/deployments"
  },
  "html_url": "https://github.com/octocat/octo-name-repo/packages/40201"
}
#>
Function Get-APackageForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$package_type,
		[Parameter(Mandatory=$FALSE)][string]$package_name
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/user/packages/$package_type/$package_name?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/packages/$package_type/$package_name"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
