
<#
.SYNOPSIS
Team synchronization is available for organizations using GitHub Enterprise Cloud. For more information, see GitHub's products in the GitHub Help documentation.
Creates, updates, or removes a connection between a team and an IdP group. When adding groups to a team, you must include all new and existing groups to avoid replacing existing groups with the new ones. Specifying an empty groups array will remove all connections for a team.
Note: You can also specify a team by org_id and team_id using the route PATCH /organizations/{org_id}/team/{team_id}/team-sync/group-mappings.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER team_slug
team_slug parameter
         
.PARAMETER groups
The IdP groups you want to connect to a GitHub team. When updating, the new groups object will replace the original one. You must include any existing groups that you don't want to remove.
         
.PARAMETER Properties of thegroupsitems



.LINK
https://docs.github.com/en/rest/reference/teams
#>
Function Create-OrUpdateIdpGroupConnections
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$team_slug,
		[Parameter(Mandatory=$FALSE)][string]$groups,
		[Parameter(Mandatory=$FALSE)][string]$Properties of thegroupsitems
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/team-sync/group-mappings?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/team-sync/group-mappings"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"groups" = "$groups"
    }

    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

