<#
.SYNOPSIS
Team members will include the members of child teams.
To get a user's membership with a team, the team must be visible to the authenticated user.
Note: You can also specify a team by org_id and team_id using the route GET /organizations/{org_id}/team/{team_id}/memberships/{username}.
Note: The response contains the state of the membership and the member's role.
The role for organization owners is set to maintainer. For more information about maintainer roles, see see Create a team.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER team_slug
team_slug parameter
         
.PARAMETER username



.LINK
https://docs.github.com/en/rest/reference/teams

.OUTPUTS
 {
  "url": "https://api.github.com/teams/1/memberships/octocat",
  "role": "maintainer",
  "state": "active"
}
#>
Function Get-TeamMembershipForAUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$team_slug,
		[Parameter(Mandatory=$FALSE)][string]$username
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
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
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
