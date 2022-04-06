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
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


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



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/repos?$($QueryStrings -join '&')"
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
