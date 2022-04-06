<#
.SYNOPSIS
To create a team, the authenticated user must be a member or owner of {org}. By default, organization members can create teams. Organization owners can limit team creation to organization owners. For more information, see "Setting team creation permissions."
When you create a new team, you automatically become a team maintainer without explicitly adding yourself to the optional array of maintainers. For more information, see "About teams".

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER name
Required. The name of the team.
         
.PARAMETER description
The description of the team.
         
.PARAMETER maintainers
List GitHub IDs for organization members who will become team maintainers.
         
.PARAMETER repo_names
The full name (e.g., "organization-name/repository-name") of repositories to add the team to.
         
.PARAMETER privacy
The level of privacy this team should have. The options are:
For a non-nested team:
* secret - only visible to organization owners and members of this team.
* closed - visible to all members of this organization.
Default: secret
For a parent or child team:
* closed - visible to all members of this organization.
Default for child team: closed
         
.PARAMETER permission
Deprecated. The permission that new repositories will be added to the team with when none is specified. Can be one of:
* pull - team members can pull, but not push to or administer newly-added repositories.
* push - team members can pull and push, but not administer newly-added repositories.
Default: pull
         
.PARAMETER parent_team_id
The ID of a team to set as the parent team.


.LINK
https://docs.github.com/en/rest/reference/teams
#>
Function Create-ATeam
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][string[]]$maintainers,
		[Parameter(Mandatory=$FALSE)][string[]]$repo_names,
		[Parameter(Mandatory=$FALSE)][string]$privacy,
		[Parameter(Mandatory=$FALSE)][string]$permission,
		[Parameter(Mandatory=$FALSE)][int]$parent_team_id
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "name",
		"description",
		"maintainers",
		"repo_names",
		"privacy",
		"permission",
		"parent_team_id" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
