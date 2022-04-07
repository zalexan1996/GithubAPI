<#
.SYNOPSIS
Find commits via various criteria on the default branch (usually master). This method returns up to 100 results per page.
When searching for commits, you can get text match metadata for the message field when you provide the text-match media type. For more details about how to receive highlighted search results, see Text match metadata.
For example, if you want to find commits related to CSS in the octocat/Spoon-Knife repository. Your query would look something like this:
q=repo:octocat/Spoon-Knife+css

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER q
The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see Constructing a search query. See "Searching commits" for a detailed list of qualifiers.
         
.PARAMETER sort
Sorts the results of your query by author-date or committer-date. Default: best match
         
.PARAMETER order
Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc). This parameter is ignored unless you provide sort.
Default: desc
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/search

.OUTPUTS
 {
  "total_count": 1,
  "incomplete_results": false,
  "items": [
    {
      "url": "https://api.github.com/repos/octocat/Spoon-Knife/commits/bb4cc8d3b2e14b3af5df699876dd4ff3acd00b7f",
      "sha": "bb4cc8d3b2e14b3af5df699876dd4ff3acd00b7f",
      "html_url": "https://github.com/octocat/Spoon-Knife/commit/bb4cc8d3b2e14b3af5df699876dd4ff3acd00b7f",
      "comments_url": "https://api.github.com/repos/octocat/Spoon-Knife/commits/bb4cc8d3b2e14b3af5df699876dd4ff3acd00b7f/comments",
      "commit": {
        "url": "https://api.github.com/repos/octocat/Spoon-Knife/git/commits/bb4cc8d3b2e14b3af5df699876dd4ff3acd00b7f",
        "author": {
          "date": "2014-02-04T14:38:36-08:00",
          "name": "The Octocat",
          "email": "octocat@nowhere.com"
        },
        "committer": {
          "date": "2014-02-12T15:18:55-08:00",
          "name": "The Octocat",
          "email": "octocat@nowhere.com"
        },
        "message": "Create styles.css and updated README",
        "tree": {
          "url": "https://api.github.com/repos/octocat/Spoon-Knife/git/trees/a639e96f9038797fba6e0469f94a4b0cc459fa68",
          "sha": "a639e96f9038797fba6e0469f94a4b0cc459fa68"
        },
        "comment_count": 8
      },
      "author": {
        "login": "octocat",
        "id": 583231,
        "node_id": "MDQ6VXNlcjU4MzIzMQ==",
        "avatar_url": "https://avatars.githubusercontent.com/u/583231?v=3",
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
      "committer": {},
      "parents": [
        {
          "url": "https://api.github.com/repos/octocat/Spoon-Knife/commits/a30c19e3f13765a3b48829788bc1cb8b4e95cee4",
          "html_url": "https://github.com/octocat/Spoon-Knife/commit/a30c19e3f13765a3b48829788bc1cb8b4e95cee4",
          "sha": "a30c19e3f13765a3b48829788bc1cb8b4e95cee4"
        }
      ],
      "repository": {
        "id": 1300192,
        "node_id": "MDEwOlJlcG9zaXRvcnkxMzAwMTky",
        "name": "Spoon-Knife",
        "full_name": "octocat/Spoon-Knife",
        "owner": {
          "login": "octocat",
          "id": 583231,
          "node_id": "MDQ6VXNlcjU4MzIzMQ==",
          "avatar_url": "https://avatars.githubusercontent.com/u/583231?v=3",
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
        "html_url": "https://github.com/octocat/Spoon-Knife",
        "description": "This repo is for demonstration purposes only.",
        "fork": false,
        "url": "https://api.github.com/repos/octocat/Spoon-Knife",
        "forks_url": "https://api.github.com/repos/octocat/Spoon-Knife/forks",
        "keys_url": "https://api.github.com/repos/octocat/Spoon-Knife/keys{/key_id}",
        "collaborators_url": "https://api.github.com/repos/octocat/Spoon-Knife/collaborators{/collaborator}",
        "teams_url": "https://api.github.com/repos/octocat/Spoon-Knife/teams",
        "hooks_url": "https://api.github.com/repos/octocat/Spoon-Knife/hooks",
        "issue_events_url": "https://api.github.com/repos/octocat/Spoon-Knife/issues/events{/number}",
        "events_url": "https://api.github.com/repos/octocat/Spoon-Knife/events",
        "assignees_url": "https://api.github.com/repos/octocat/Spoon-Knife/assignees{/user}",
        "branches_url": "https://api.github.com/repos/octocat/Spoon-Knife/branches{/branch}",
        "tags_url": "https://api.github.com/repos/octocat/Spoon-Knife/tags",
        "blobs_url": "https://api.github.com/repos/octocat/Spoon-Knife/git/blobs{/sha}",
        "git_tags_url": "https://api.github.com/repos/octocat/Spoon-Knife/git/tags{/sha}",
        "git_refs_url": "https://api.github.com/repos/octocat/Spoon-Knife/git/refs{/sha}",
        "trees_url": "https://api.github.com/repos/octocat/Spoon-Knife/git/trees{/sha}",
        "statuses_url": "https://api.github.com/repos/octocat/Spoon-Knife/statuses/{sha}",
        "languages_url": "https://api.github.com/repos/octocat/Spoon-Knife/languages",
        "stargazers_url": "https://api.github.com/repos/octocat/Spoon-Knife/stargazers",
        "contributors_url": "https://api.github.com/repos/octocat/Spoon-Knife/contributors",
        "subscribers_url": "https://api.github.com/repos/octocat/Spoon-Knife/subscribers",
        "subscription_url": "https://api.github.com/repos/octocat/Spoon-Knife/subscription",
        "commits_url": "https://api.github.com/repos/octocat/Spoon-Knife/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/octocat/Spoon-Knife/git/commits{/sha}",
        "comments_url": "https://api.github.com/repos/octocat/Spoon-Knife/comments{/number}",
        "issue_comment_url": "https://api.github.com/repos/octocat/Spoon-Knife/issues/comments{/number}",
        "contents_url": "https://api.github.com/repos/octocat/Spoon-Knife/contents/{+path}",
        "compare_url": "https://api.github.com/repos/octocat/Spoon-Knife/compare/{base}...{head}",
        "merges_url": "https://api.github.com/repos/octocat/Spoon-Knife/merges",
        "archive_url": "https://api.github.com/repos/octocat/Spoon-Knife/{archive_format}{/ref}",
        "downloads_url": "https://api.github.com/repos/octocat/Spoon-Knife/downloads",
        "issues_url": "https://api.github.com/repos/octocat/Spoon-Knife/issues{/number}",
        "pulls_url": "https://api.github.com/repos/octocat/Spoon-Knife/pulls{/number}",
        "milestones_url": "https://api.github.com/repos/octocat/Spoon-Knife/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/octocat/Spoon-Knife/notifications{?since,all,participating}",
        "labels_url": "https://api.github.com/repos/octocat/Spoon-Knife/labels{/name}",
        "releases_url": "https://api.github.com/repos/octocat/Spoon-Knife/releases{/id}",
        "deployments_url": "https://api.github.com/repos/octocat/Spoon-Knife/deployments"
      },
      "score": 1,
      "node_id": "MDQ6VXNlcjU4MzIzMQ=="
    }
  ]
}
#>
Function Search-Commits
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$q,
		[Parameter(Mandatory=$FALSE)][string]$sort,
		[Parameter(Mandatory=$FALSE)][string]$order,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $Querys = @()
    $QueryStrings = @(
        "q",
		"sort",
		"order",
		"per_page",
		"page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/search/commits?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/search/commits"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
