<#
.SYNOPSIS
Team synchronization is available for organizations using GitHub Enterprise Cloud. For more information, see GitHub's products in the GitHub Help documentation.
List IdP groups connected to a team on GitHub.
Note: You can also specify a team by org_id and team_id using the route GET /organizations/{org_id}/team/{team_id}/team-sync/group-mappings.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER team_slug
team_slug parameter


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
Function List-IdpGroupsForATeam
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$team_slug
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
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
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
