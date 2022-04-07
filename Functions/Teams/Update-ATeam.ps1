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

.OUTPUTS
 {
  "id": 1,
  "node_id": "MDQ6VGVhbTE=",
  "url": "https://api.github.com/teams/1",
  "html_url": "https://github.com/orgs/github/teams/justice-league",
  "name": "Justice League",
  "slug": "justice-league",
  "description": "A great team.",
  "privacy": "closed",
  "permission": "admin",
  "members_url": "https://api.github.com/teams/1/members{/member}",
  "repositories_url": "https://api.github.com/teams/1/repos",
  "parent": null,
  "members_count": 3,
  "repos_count": 10,
  "created_at": "2017-07-14T16:53:42Z",
  "updated_at": "2017-08-17T12:37:15Z",
  "organization": {
    "login": "github",
    "id": 1,
    "node_id": "MDEyOk9yZ2FuaXphdGlvbjE=",
    "url": "https://api.github.com/orgs/github",
    "repos_url": "https://api.github.com/orgs/github/repos",
    "events_url": "https://api.github.com/orgs/github/events",
    "hooks_url": "https://api.github.com/orgs/github/hooks",
    "issues_url": "https://api.github.com/orgs/github/issues",
    "members_url": "https://api.github.com/orgs/github/members{/member}",
    "public_members_url": "https://api.github.com/orgs/github/public_members{/member}",
    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
    "description": "A great organization",
    "name": "github",
    "company": "GitHub",
    "blog": "https://github.com/blog",
    "location": "San Francisco",
    "email": "octocat@github.com",
    "is_verified": true,
    "has_organization_projects": true,
    "has_repository_projects": true,
    "public_repos": 2,
    "public_gists": 1,
    "followers": 20,
    "following": 0,
    "html_url": "https://github.com/octocat",
    "created_at": "2008-01-14T04:33:35Z",
    "updated_at": "2017-08-17T12:37:15Z",
    "type": "Organization"
  }
}
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
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "name",
		"description",
		"privacy",
		"permission",
		"parent_team_id" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug?$($Querys -join '&')"
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
