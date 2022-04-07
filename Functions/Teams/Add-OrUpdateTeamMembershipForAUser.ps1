<#
.SYNOPSIS
Team synchronization is available for organizations using GitHub Enterprise Cloud. For more information, see GitHub's products in the GitHub Help documentation.
Adds an organization member to a team. An authenticated organization owner or team maintainer can add organization members to a team.
Note: When you have team synchronization set up for a team with your organization's identity provider (IdP), you will see an error if you attempt to use the API for making changes to the team's membership. If you have access to manage group membership in your IdP, you can manage GitHub team membership through your identity provider, which automatically adds and removes team members in an organization. For more information, see "Synchronizing teams between your identity provider and GitHub."
An organization owner can add someone who is not part of the team's organization to a team. When an organization owner adds someone to a team who is not an organization member, this endpoint will send an invitation to the person via email. This newly-created membership will be in the "pending" state until the person accepts the invitation, at which point the membership will transition to the "active" state and the user will be added as a member of the team.
If the user is already a member of the team, this endpoint will update the role of the team member's role. To update the membership of a team member, the authenticated user must be an organization owner or a team maintainer.
Note: You can also specify a team by org_id and team_id using the route PUT /organizations/{org_id}/team/{team_id}/memberships/{username}.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER team_slug
team_slug parameter
         
.PARAMETER username

         
.PARAMETER role
The role that this user should have in the team. Can be one of:
* member - a normal member of the team.
* maintainer - a team maintainer. Able to add/remove other team members, promote other team members to team maintainer, and edit the team's name and description.
Default: member


.LINK
https://docs.github.com/en/rest/reference/teams

.OUTPUTS
 {
  "url": "https://api.github.com/teams/1/memberships/octocat",
  "role": "member",
  "state": "pending"
}
#>
Function Add-OrUpdateTeamMembershipForAUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$team_slug,
		[Parameter(Mandatory=$FALSE)][string]$username,
		[Parameter(Mandatory=$FALSE)][string]$role
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "role" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/memberships/$username?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/memberships/$username"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
