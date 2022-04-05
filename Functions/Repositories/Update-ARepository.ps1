
<#
.SYNOPSIS
Note: To edit a repository's topics, use the Replace all repository topics endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER name
The name of the repository.
         
.PARAMETER description
A short description of the repository.
         
.PARAMETER homepage
A URL with more information about the repository.
         
.PARAMETER private
Either true to make the repository private or false to make it public. Default: false.
Note: You will get a 422 error if the organization restricts changing repository visibility to organization owners and a non-owner tries to change the value of private. Note: You will get a 422 error if the organization restricts changing repository visibility to organization owners and a non-owner tries to change the value of private.
         
.PARAMETER visibility
Can be public or private. If your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+, visibility can also be internal."
         
.PARAMETER security_and_analysis
Specify which security and analysis features to enable or disable. For example, to enable GitHub Advanced Security, use this data in the body of the PATCH request: {"security_and_analysis": {"advanced_security": {"status": "enabled"}}}. If you have admin permissions for a private repository covered by an Advanced Security license, you can check which security and analysis features are currently enabled by using a GET /repos/{owner}/{repo} request.
         
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
         
.PARAMETER default_branch
Updates the default branch for this repository.
         
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
         
.PARAMETER archived
true to archive this repository. Note: You cannot unarchive repositories through the API.
         
.PARAMETER allow_forking
Either true to allow private forks, or false to prevent private forks.


.LINK
https://docs.github.com/en/rest/reference/repos
#>
Function Update-ARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][string]$homepage,
		[Parameter(Mandatory=$FALSE)][string]$private,
		[Parameter(Mandatory=$FALSE)][string]$visibility,
		[Parameter(Mandatory=$FALSE)][string]$security_and_analysis,
		[Parameter(Mandatory=$FALSE)][string]$has_issues,
		[Parameter(Mandatory=$FALSE)][string]$has_projects,
		[Parameter(Mandatory=$FALSE)][string]$has_wiki,
		[Parameter(Mandatory=$FALSE)][string]$is_template,
		[Parameter(Mandatory=$FALSE)][string]$default_branch,
		[Parameter(Mandatory=$FALSE)][string]$allow_squash_merge,
		[Parameter(Mandatory=$FALSE)][string]$allow_merge_commit,
		[Parameter(Mandatory=$FALSE)][string]$allow_rebase_merge,
		[Parameter(Mandatory=$FALSE)][string]$allow_auto_merge,
		[Parameter(Mandatory=$FALSE)][string]$delete_branch_on_merge,
		[Parameter(Mandatory=$FALSE)][string]$archived,
		[Parameter(Mandatory=$FALSE)][string]$allow_forking
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"name" = "$name"
	"description" = "$description"
	"homepage" = "$homepage"
	"private" = "$private"
	"visibility" = "$visibility"
	"security_and_analysis" = "$security_and_analysis"
	"has_issues" = "$has_issues"
	"has_projects" = "$has_projects"
	"has_wiki" = "$has_wiki"
	"is_template" = "$is_template"
	"default_branch" = "$default_branch"
	"allow_squash_merge" = "$allow_squash_merge"
	"allow_merge_commit" = "$allow_merge_commit"
	"allow_rebase_merge" = "$allow_rebase_merge"
	"allow_auto_merge" = "$allow_auto_merge"
	"delete_branch_on_merge" = "$delete_branch_on_merge"
	"archived" = "$archived"
	"allow_forking" = "$allow_forking"
    }

    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

