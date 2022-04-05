
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
#>
Function Create-ARepositoryForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][string]$homepage,
		[Parameter(Mandatory=$FALSE)][string]$private,
		[Parameter(Mandatory=$FALSE)][string]$has_issues,
		[Parameter(Mandatory=$FALSE)][string]$has_projects,
		[Parameter(Mandatory=$FALSE)][string]$has_wiki,
		[Parameter(Mandatory=$FALSE)][string]$team_id,
		[Parameter(Mandatory=$FALSE)][string]$auto_init,
		[Parameter(Mandatory=$FALSE)][string]$gitignore_template,
		[Parameter(Mandatory=$FALSE)][string]$license_template,
		[Parameter(Mandatory=$FALSE)][string]$allow_squash_merge,
		[Parameter(Mandatory=$FALSE)][string]$allow_merge_commit,
		[Parameter(Mandatory=$FALSE)][string]$allow_rebase_merge,
		[Parameter(Mandatory=$FALSE)][string]$allow_auto_merge,
		[Parameter(Mandatory=$FALSE)][string]$delete_branch_on_merge,
		[Parameter(Mandatory=$FALSE)][string]$has_downloads,
		[Parameter(Mandatory=$FALSE)][string]$is_template
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/repos?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/repos"
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
	"has_issues" = "$has_issues"
	"has_projects" = "$has_projects"
	"has_wiki" = "$has_wiki"
	"team_id" = "$team_id"
	"auto_init" = "$auto_init"
	"gitignore_template" = "$gitignore_template"
	"license_template" = "$license_template"
	"allow_squash_merge" = "$allow_squash_merge"
	"allow_merge_commit" = "$allow_merge_commit"
	"allow_rebase_merge" = "$allow_rebase_merge"
	"allow_auto_merge" = "$allow_auto_merge"
	"delete_branch_on_merge" = "$delete_branch_on_merge"
	"has_downloads" = "$has_downloads"
	"is_template" = "$is_template"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

