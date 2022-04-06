<#
.SYNOPSIS
Parameter Deprecation Notice: GitHub will replace and discontinue members_allowed_repository_creation_type in favor of more granular permissions. The new input parameters are members_can_create_public_repositories, members_can_create_private_repositories for all organizations and members_can_create_internal_repositories for organizations associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+. For more information, see the blog post.
Enables an authenticated organization owner with the admin:org scope to update the organization's profile and member privileges.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER billing_email
Billing email address. This address is not publicized.
         
.PARAMETER company
The company name.
         
.PARAMETER email
The publicly visible email address.
         
.PARAMETER twitter_username
The Twitter username of the company.
         
.PARAMETER location
The location.
         
.PARAMETER name
The shorthand name of the company.
         
.PARAMETER description
The description of the company.
         
.PARAMETER has_organization_projects
Toggles whether an organization can use organization projects.
         
.PARAMETER has_repository_projects
Toggles whether repositories that belong to the organization can use repository projects.
         
.PARAMETER default_repository_permission
Default permission level members have for organization repositories:
* read - can pull, but not push to or administer this repository.
* write - can pull and push, but not administer this repository.
* admin - can pull, push, and administer this repository.
* none - no permissions granted by default.
Default: read
         
.PARAMETER members_can_create_repositories
Toggles the ability of non-admin organization members to create repositories. Can be one of:
* true - all organization members can create repositories.
* false - only organization owners can create repositories.
Default: true
Note: A parameter can override this parameter. See members_allowed_repository_creation_type in this table for details. Note: A parameter can override this parameter. See members_allowed_repository_creation_type in this table for details.
Default:
         
.PARAMETER members_can_create_internal_repositories
Toggles whether organization members can create internal repositories, which are visible to all enterprise members. You can only allow members to create internal repositories if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+. Can be one of:
* true - all organization members can create internal repositories.
* false - only organization owners can create internal repositories.
Default: true. For more information, see "Restricting repository creation in your organization" in the GitHub Help documentation.
         
.PARAMETER members_can_create_private_repositories
Toggles whether organization members can create private repositories, which are visible to organization members with permission. Can be one of:
* true - all organization members can create private repositories.
* false - only organization owners can create private repositories.
Default: true. For more information, see "Restricting repository creation in your organization" in the GitHub Help documentation.
         
.PARAMETER members_can_create_public_repositories
Toggles whether organization members can create public repositories, which are visible to anyone. Can be one of:
* true - all organization members can create public repositories.
* false - only organization owners can create public repositories.
Default: true. For more information, see "Restricting repository creation in your organization" in the GitHub Help documentation.
         
.PARAMETER members_allowed_repository_creation_type
Specifies which types of repositories non-admin organization members can create. Can be one of:
* all - all organization members can create public and private repositories.
* private - members can create private repositories. This option is only available to repositories that are part of an organization on GitHub Enterprise Cloud.
* none - only admin members can create repositories.
Note: This parameter is deprecated and will be removed in the future. Its return value ignores internal repositories. Using this parameter overrides values set in members_can_create_repositories. See the parameter deprecation notice in the operation description for details.
         
.PARAMETER members_can_create_pages
Toggles whether organization members can create GitHub Pages sites. Can be one of:
* true - all organization members can create GitHub Pages sites.
* false - no organization members can create GitHub Pages sites. Existing published sites will not be impacted.
Default:
         
.PARAMETER members_can_create_public_pages
Toggles whether organization members can create public GitHub Pages sites. Can be one of:
* true - all organization members can create public GitHub Pages sites.
* false - no organization members can create public GitHub Pages sites. Existing published sites will not be impacted.
Default:
         
.PARAMETER members_can_create_private_pages
Toggles whether organization members can create private GitHub Pages sites. Can be one of:
* true - all organization members can create private GitHub Pages sites.
* false - no organization members can create private GitHub Pages sites. Existing published sites will not be impacted.
Default:
         
.PARAMETER members_can_fork_private_repositories
Toggles whether organization members can fork private organization repositories. Can be one of:
* true - all organization members can fork private repositories within the organization.
* false - no organization members can fork private repositories within the organization.
         
.PARAMETER blog



.LINK
https://docs.github.com/en/rest/reference/orgs
#>
Function Update-AnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$billing_email,
		[Parameter(Mandatory=$FALSE)][string]$company,
		[Parameter(Mandatory=$FALSE)][string]$email,
		[Parameter(Mandatory=$FALSE)][string]$twitter_username,
		[Parameter(Mandatory=$FALSE)][string]$location,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][bool]$has_organization_projects,
		[Parameter(Mandatory=$FALSE)][bool]$has_repository_projects,
		[Parameter(Mandatory=$FALSE)][string]$default_repository_permission,
		[Parameter(Mandatory=$FALSE)][bool]$members_can_create_repositories,
		[Parameter(Mandatory=$FALSE)][bool]$members_can_create_internal_repositories,
		[Parameter(Mandatory=$FALSE)][bool]$members_can_create_private_repositories,
		[Parameter(Mandatory=$FALSE)][bool]$members_can_create_public_repositories,
		[Parameter(Mandatory=$FALSE)][string]$members_allowed_repository_creation_type,
		[Parameter(Mandatory=$FALSE)][bool]$members_can_create_pages,
		[Parameter(Mandatory=$FALSE)][bool]$members_can_create_public_pages,
		[Parameter(Mandatory=$FALSE)][bool]$members_can_create_private_pages,
		[Parameter(Mandatory=$FALSE)][bool]$members_can_fork_private_repositories,
		[Parameter(Mandatory=$FALSE)][string]$blog
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "billing_email",
		"company",
		"email",
		"twitter_username",
		"location",
		"name",
		"description",
		"has_organization_projects",
		"has_repository_projects",
		"default_repository_permission",
		"members_can_create_repositories",
		"members_can_create_internal_repositories",
		"members_can_create_private_repositories",
		"members_can_create_public_repositories",
		"members_allowed_repository_creation_type",
		"members_can_create_pages",
		"members_can_create_public_pages",
		"members_can_create_private_pages",
		"members_can_fork_private_repositories",
		"blog" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
