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
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


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



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/repos?$($QueryStrings -join '&')"
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
