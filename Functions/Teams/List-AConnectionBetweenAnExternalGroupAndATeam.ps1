<#
.SYNOPSIS
Lists a connection between a team and an external group.
You can manage team membership with your identity provider using Enterprise Managed Users for GitHub Enterprise Cloud. For more information, see "GitHub's products" in the GitHub Help documentation.

        
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
      "updated_at": "2021-01-24T11:31:04-06:00"
    },
    {
      "group_id": "456",
      "group_name": "Octocat docs members",
      "updated_at": "2021-03-24T11:31:04-06:00"
    }
  ]
}
#>
Function List-AConnectionBetweenAnExternalGroupAndATeam
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
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
