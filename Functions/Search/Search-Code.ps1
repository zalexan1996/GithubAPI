<#
.SYNOPSIS
Searches for query terms inside of a file. This method returns up to 100 results per page.
When searching for code, you can get text match metadata for the file content and file path fields when you pass the text-match media type. For more details about how to receive highlighted search results, see Text match metadata.
For example, if you want to find the definition of the addClass function inside jQuery repository, your query would look something like this:
q=addClass+in:file+language:js+repo:jquery/jquery
This query searches for the keyword addClass within a file's contents. The query limits the search to files where the language is JavaScript in the jquery/jquery repository.
Considerations for code search
Due to the complexity of searching code, there are a few restrictions on how searches are performed:
Only the default branch is considered. In most cases, this will be the master branch.
Only files smaller than 384 KB are searchable.
You must always include at least one search term when searching source code. For example, searching for language:go is not valid, while amazing language:go is.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER q
The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see Constructing a search query. See "Searching code" for a detailed list of qualifiers.
         
.PARAMETER sort
Sorts the results of your query. Can only be indexed, which indicates how recently a file has been indexed by the GitHub search infrastructure. Default: best match
         
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
  "total_count": 7,
  "incomplete_results": false,
  "items": [
    {
      "name": "classes.js",
      "path": "src/attributes/classes.js",
      "sha": "d7212f9dee2dcc18f084d7df8f417b80846ded5a",
      "url": "https://api.github.com/repositories/167174/contents/src/attributes/classes.js?ref=825ac3773694e0cd23ee74895fd5aeb535b27da4",
      "git_url": "https://api.github.com/repositories/167174/git/blobs/d7212f9dee2dcc18f084d7df8f417b80846ded5a",
      "html_url": "https://github.com/jquery/jquery/blob/825ac3773694e0cd23ee74895fd5aeb535b27da4/src/attributes/classes.js",
      "repository": {
        "id": 167174,
        "node_id": "MDEwOlJlcG9zaXRvcnkxNjcxNzQ=",
        "name": "jquery",
        "full_name": "jquery/jquery",
        "owner": {
          "login": "jquery",
          "id": 70142,
          "node_id": "MDQ6VXNlcjcwMTQy",
          "avatar_url": "https://0.gravatar.com/avatar/6906f317a4733f4379b06c32229ef02f?d=https%3A%2F%2Fidenticons.github.com%2Ff426f04f2f9813718fb806b30e0093de.png",
          "gravatar_id": "",
          "url": "https://api.github.com/users/jquery",
          "html_url": "https://github.com/jquery",
          "followers_url": "https://api.github.com/users/jquery/followers",
          "following_url": "https://api.github.com/users/jquery/following{/other_user}",
          "gists_url": "https://api.github.com/users/jquery/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/jquery/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/jquery/subscriptions",
          "organizations_url": "https://api.github.com/users/jquery/orgs",
          "repos_url": "https://api.github.com/users/jquery/repos",
          "events_url": "https://api.github.com/users/jquery/events{/privacy}",
          "received_events_url": "https://api.github.com/users/jquery/received_events",
          "type": "Organization",
          "site_admin": false
        },
        "private": false,
        "html_url": "https://github.com/jquery/jquery",
        "description": "jQuery JavaScript Library",
        "fork": false,
        "url": "https://api.github.com/repos/jquery/jquery",
        "forks_url": "https://api.github.com/repos/jquery/jquery/forks",
        "keys_url": "https://api.github.com/repos/jquery/jquery/keys{/key_id}",
        "collaborators_url": "https://api.github.com/repos/jquery/jquery/collaborators{/collaborator}",
        "teams_url": "https://api.github.com/repos/jquery/jquery/teams",
        "hooks_url": "https://api.github.com/repos/jquery/jquery/hooks",
        "issue_events_url": "https://api.github.com/repos/jquery/jquery/issues/events{/number}",
        "events_url": "https://api.github.com/repos/jquery/jquery/events",
        "assignees_url": "https://api.github.com/repos/jquery/jquery/assignees{/user}",
        "branches_url": "https://api.github.com/repos/jquery/jquery/branches{/branch}",
        "tags_url": "https://api.github.com/repos/jquery/jquery/tags",
        "blobs_url": "https://api.github.com/repos/jquery/jquery/git/blobs{/sha}",
        "git_tags_url": "https://api.github.com/repos/jquery/jquery/git/tags{/sha}",
        "git_refs_url": "https://api.github.com/repos/jquery/jquery/git/refs{/sha}",
        "trees_url": "https://api.github.com/repos/jquery/jquery/git/trees{/sha}",
        "statuses_url": "https://api.github.com/repos/jquery/jquery/statuses/{sha}",
        "languages_url": "https://api.github.com/repos/jquery/jquery/languages",
        "stargazers_url": "https://api.github.com/repos/jquery/jquery/stargazers",
        "contributors_url": "https://api.github.com/repos/jquery/jquery/contributors",
        "subscribers_url": "https://api.github.com/repos/jquery/jquery/subscribers",
        "subscription_url": "https://api.github.com/repos/jquery/jquery/subscription",
        "commits_url": "https://api.github.com/repos/jquery/jquery/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/jquery/jquery/git/commits{/sha}",
        "comments_url": "https://api.github.com/repos/jquery/jquery/comments{/number}",
        "issue_comment_url": "https://api.github.com/repos/jquery/jquery/issues/comments/{number}",
        "contents_url": "https://api.github.com/repos/jquery/jquery/contents/{+path}",
        "compare_url": "https://api.github.com/repos/jquery/jquery/compare/{base}...{head}",
        "merges_url": "https://api.github.com/repos/jquery/jquery/merges",
        "archive_url": "https://api.github.com/repos/jquery/jquery/{archive_format}{/ref}",
        "downloads_url": "https://api.github.com/repos/jquery/jquery/downloads",
        "issues_url": "https://api.github.com/repos/jquery/jquery/issues{/number}",
        "pulls_url": "https://api.github.com/repos/jquery/jquery/pulls{/number}",
        "milestones_url": "https://api.github.com/repos/jquery/jquery/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/jquery/jquery/notifications{?since,all,participating}",
        "labels_url": "https://api.github.com/repos/jquery/jquery/labels{/name}",
        "deployments_url": "http://api.github.com/repos/octocat/Hello-World/deployments",
        "releases_url": "http://api.github.com/repos/octocat/Hello-World/releases{/id}"
      },
      "score": 1
    }
  ]
}
#>
Function Search-Code
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
        $FinalURL = "https://api.github.com/search/code?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/search/code"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
