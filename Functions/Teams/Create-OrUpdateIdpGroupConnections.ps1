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


.LINK
https://docs.github.com/en/rest/reference/teams

.OUTPUTS
 {
  "groups": [
    {
      "group_id": "123",
      "group_name": "Octocat admins",
      "group_description": "The people who configure your octoworld."
    },
    {
      "group_id": "456",
      "group_name": "Octocat docs members",
      "group_description": "The people who make your octoworld come to life."
    }
  ]
}
#>
Function Create-OrUpdateIdpGroupConnections
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$team_slug,
		[Parameter(Mandatory=$FALSE)][object[]]$groups
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "groups" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/team-sync/group-mappings?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/team-sync/group-mappings"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
