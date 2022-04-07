<#
.SYNOPSIS
Creates a new repository for the authenticated user.
OAuth scope requirements
When using OAuth, authorizations must include:
public_repo scope or repo scope to create a public repository. Note: For GitHub AE, use repo scope to create an internal repository.
repo scope to create a private repository.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER name
Required. The name of the repository.
         
.PARAMETER description
A short description of the repository.
         
.PARAMETER homepage
A URL with more information about the repository.
         
.PARAMETER private
Whether the repository is private.
         
.PARAMETER has_issues
Whether issues are enabled.
Default:
         
.PARAMETER has_projects
Whether projects are enabled.
Default:
         
.PARAMETER has_wiki
Whether the wiki is enabled.
Default:
         
.PARAMETER team_id
The id of the team that will be granted access to this repository. This is only valid when creating a repository in an organization.
         
.PARAMETER auto_init
Whether the repository is initialized with a minimal README.
         
.PARAMETER gitignore_template
The desired language or platform to apply to the .gitignore.
         
.PARAMETER license_template
The license keyword of the open source license for this repository.
         
.PARAMETER allow_squash_merge
Whether to allow squash merges for pull requests.
Default:
         
.PARAMETER allow_merge_commit
Whether to allow merge commits for pull requests.
Default:
         
.PARAMETER allow_rebase_merge
Whether to allow rebase merges for pull requests.
Default:
         
.PARAMETER allow_auto_merge
Whether to allow Auto-merge to be used on pull requests.
         
.PARAMETER delete_branch_on_merge
Whether to delete head branches when pull requests are merged
         
.PARAMETER has_downloads
Whether downloads are enabled.
Default:
         
.PARAMETER is_template
Whether this repository acts as a template that can be used to generate new repositories.


.LINK
https://docs.github.com/en/rest/reference/repos

.OUTPUTS
 {
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
  "clone_url": "https://github.com/octocat/Hello-World.git",
  "mirror_url": "git:git.example.com/octocat/Hello-World",
  "hooks_url": "https://api.github.com/repos/octocat/Hello-World/hooks",
  "svn_url": "https://svn.github.com/octocat/Hello-World",
  "homepage": "https://github.com",
  "organization": null,
  "language": null,
  "forks": 9,
  "forks_count": 9,
  "stargazers_count": 80,
  "watchers_count": 80,
  "watchers": 80,
  "size": 108,
  "default_branch": "master",
  "open_issues": 0,
  "open_issues_count": 0,
  "is_template": true,
  "license": {
    "key": "mit",
    "name": "MIT License",
    "url": "https://api.github.com/licenses/mit",
    "spdx_id": "MIT",
    "node_id": "MDc6TGljZW5zZW1pdA==",
    "html_url": "https://api.github.com/licenses/mit"
  },
  "topics": [
    "octocat",
    "atom",
    "electron",
    "api"
  ],
  "has_issues": true,
  "has_projects": true,
  "has_wiki": true,
  "has_pages": false,
  "has_downloads": true,
  "archived": false,
  "disabled": false,
  "visibility": "public",
  "pushed_at": "2011-01-26T19:06:43Z",
  "created_at": "2011-01-26T19:01:12Z",
  "updated_at": "2011-01-26T19:14:43Z",
  "permissions": {
    "admin": false,
    "push": false,
    "pull": true
  },
  "allow_rebase_merge": true,
  "template_repository": null,
  "temp_clone_token": "ABTLWHOULUVAXGTRYU7OC2876QJ2O",
  "allow_squash_merge": true,
  "allow_auto_merge": false,
  "delete_branch_on_merge": true,
  "allow_merge_commit": true,
  "subscribers_count": 42,
  "network_count": 0
}
#>
Function Create-ARepositoryForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][string]$homepage,
		[Parameter(Mandatory=$FALSE)][bool]$private,
		[Parameter(Mandatory=$FALSE)][bool]$has_issues,
		[Parameter(Mandatory=$FALSE)][bool]$has_projects,
		[Parameter(Mandatory=$FALSE)][bool]$has_wiki,
		[Parameter(Mandatory=$FALSE)][int]$team_id,
		[Parameter(Mandatory=$FALSE)][bool]$auto_init,
		[Parameter(Mandatory=$FALSE)][string]$gitignore_template,
		[Parameter(Mandatory=$FALSE)][string]$license_template,
		[Parameter(Mandatory=$FALSE)][bool]$allow_squash_merge,
		[Parameter(Mandatory=$FALSE)][bool]$allow_merge_commit,
		[Parameter(Mandatory=$FALSE)][bool]$allow_rebase_merge,
		[Parameter(Mandatory=$FALSE)][bool]$allow_auto_merge,
		[Parameter(Mandatory=$FALSE)][bool]$delete_branch_on_merge,
		[Parameter(Mandatory=$FALSE)][bool]$has_downloads,
		[Parameter(Mandatory=$FALSE)][bool]$is_template
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "name",
		"description",
		"homepage",
		"private",
		"has_issues",
		"has_projects",
		"has_wiki",
		"team_id",
		"auto_init",
		"gitignore_template",
		"license_template",
		"allow_squash_merge",
		"allow_merge_commit",
		"allow_rebase_merge",
		"allow_auto_merge",
		"delete_branch_on_merge",
		"has_downloads",
		"is_template" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/user/repos?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/repos"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
