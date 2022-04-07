<#
.SYNOPSIS
Creates a connection between a team and an external group. Only one external group can be linked to a team.
You can manage team membership with your identity provider using Enterprise Managed Users for GitHub Enterprise Cloud. For more information, see "GitHub's products" in the GitHub Help documentation.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER team_slug
team_slug parameter
         
.PARAMETER group_id
Required. External Group Id


.LINK
https://docs.github.com/en/rest/reference/teams

.OUTPUTS
 {
  "group_id": "123",
  "group_name": "Octocat admins",
  "updated_at": "2021-01-24T11:31:04-06:00",
  "teams": [
    {
      "team_id": 1,
      "team_name": "team-test"
    },
    {
      "team_id": 2,
      "team_name": "team-test2"
    }
  ],
  "members": [
    {
      "member_id": 1,
      "member_login": "mona-lisa_eocsaxrs",
      "member_name": "Mona Lisa",
      "member_email": "mona_lisa@github.com"
    },
    {
      "member_id": 2,
      "member_login": "octo-lisa_eocsaxrs",
      "member_name": "Octo Lisa",
      "member_email": "octo_lisa@github.com"
    }
  ]
}
#>
Function Update-TheConnectionBetweenAnExternalGroupAndATeam
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$team_slug,
		[Parameter(Mandatory=$FALSE)][int]$group_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "group_id" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/external-groups?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/external-groups"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
