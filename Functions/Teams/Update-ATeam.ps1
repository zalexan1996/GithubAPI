<#
.SYNOPSIS
To edit a team, the authenticated user must either be an organization owner or a team maintainer.
Note: You can also specify a team by org_id and team_id using the route PATCH /organizations/{org_id}/team/{team_id}.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER team_slug
team_slug parameter
         
.PARAMETER name
The name of the team.
         
.PARAMETER description
The description of the team.
         
.PARAMETER privacy
The level of privacy this team should have. Editing teams without specifying this parameter leaves privacy intact. When a team is nested, the privacy for parent teams cannot be secret. The options are:
For a non-nested team:
* secret - only visible to organization owners and members of this team.
* closed - visible to all members of this organization.
For a parent or child team:
* closed - visible to all members of this organization.
         
.PARAMETER permission
Deprecated. The permission that new repositories will be added to the team with when none is specified. Can be one of:
* pull - team members can pull, but not push to or administer newly-added repositories.
* push - team members can pull and push, but not administer newly-added repositories.
* admin - team members can pull, push and administer newly-added repositories.
Default: pull
         
.PARAMETER parent_team_id
The ID of a team to set as the parent team.


.LINK
https://docs.github.com/en/rest/reference/teams
#>
Function Update-ATeam
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$team_slug,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][string]$privacy,
		[Parameter(Mandatory=$FALSE)][string]$permission,
		[Parameter(Mandatory=$FALSE)][string]$parent_team_id
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "name",
		"description",
		"privacy",
		"permission",
		"parent_team_id" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
