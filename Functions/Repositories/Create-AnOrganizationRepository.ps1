<#
.SYNOPSIS
Creates a new repository in the specified organization. The authenticated user must be a member of the organization.
OAuth scope requirements
When using OAuth, authorizations must include:
public_repo scope or repo scope to create a public repository. Note: For GitHub AE, use repo scope to create an internal repository.
repo scope to create a private repository

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER name
Required. The name of the repository.
         
.PARAMETER description
A short description of the repository.
         
.PARAMETER homepage
A URL with more information about the repository.
         
.PARAMETER private
Whether the repository is private.
         
.PARAMETER visibility
Can be public or private. If your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+, visibility can also be internal. Note: For GitHub Enterprise Server and GitHub AE, this endpoint will only list repositories available to all users on the enterprise. For more information, see "Creating an internal repository" in the GitHub Help documentation.
         
.PARAMETER has_issues
Either true to enable issues for this repository or false to disable them.
Default:
         
.PARAMETER has_projects
Either true to enable projects for this repository or false to disable them. Note: If you're creating a repository in an organization that has disabled repository projects, the default is false, and if you pass true, the API returns an error.
Default:
         
.PARAMETER has_wiki
Either true to enable the wiki for this repository or false to disable it.
Default:
         
.PARAMETER is_template
Either true to make this repo available as a template repository or false to prevent it.
         
.PARAMETER team_id
The id of the team that will be granted access to this repository. This is only valid when creating a repository in an organization.
         
.PARAMETER auto_init
Pass true to create an initial commit with empty README.
         
.PARAMETER gitignore_template
Desired language or platform .gitignore template to apply. Use the name of the template without the extension. For example, "Haskell".
         
.PARAMETER license_template
Choose an open source license template that best suits your needs, and then use the license keyword as the license_template string. For example, "mit" or "mpl-2.0".
         
.PARAMETER allow_squash_merge
Either true to allow squash-merging pull requests, or false to prevent squash-merging.
Default:
         
.PARAMETER allow_merge_commit
Either true to allow merging pull requests with a merge commit, or false to prevent merging pull requests with merge commits.
Default:
         
.PARAMETER allow_rebase_merge
Either true to allow rebase-merging pull requests, or false to prevent rebase-merging.
Default:
         
.PARAMETER allow_auto_merge
Either true to allow auto-merge on pull requests, or false to disallow auto-merge.
         
.PARAMETER delete_branch_on_merge
Either true to allow automatically deleting head branches when pull requests are merged, or false to prevent automatic deletion.


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
Function Create-AnOrganizationRepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][string]$homepage,
		[Parameter(Mandatory=$FALSE)][bool]$private,
		[Parameter(Mandatory=$FALSE)][string]$visibility,
		[Parameter(Mandatory=$FALSE)][bool]$has_issues,
		[Parameter(Mandatory=$FALSE)][bool]$has_projects,
		[Parameter(Mandatory=$FALSE)][bool]$has_wiki,
		[Parameter(Mandatory=$FALSE)][bool]$is_template,
		[Parameter(Mandatory=$FALSE)][int]$team_id,
		[Parameter(Mandatory=$FALSE)][bool]$auto_init,
		[Parameter(Mandatory=$FALSE)][string]$gitignore_template,
		[Parameter(Mandatory=$FALSE)][string]$license_template,
		[Parameter(Mandatory=$FALSE)][bool]$allow_squash_merge,
		[Parameter(Mandatory=$FALSE)][bool]$allow_merge_commit,
		[Parameter(Mandatory=$FALSE)][bool]$allow_rebase_merge,
		[Parameter(Mandatory=$FALSE)][bool]$allow_auto_merge,
		[Parameter(Mandatory=$FALSE)][bool]$delete_branch_on_merge
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
		"visibility",
		"has_issues",
		"has_projects",
		"has_wiki",
		"is_template",
		"team_id",
		"auto_init",
		"gitignore_template",
		"license_template",
		"allow_squash_merge",
		"allow_merge_commit",
		"allow_rebase_merge",
		"allow_auto_merge",
		"delete_branch_on_merge" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/repos?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/repos"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
