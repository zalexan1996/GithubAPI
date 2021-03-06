<#
.SYNOPSIS
Team synchronization is available for organizations using GitHub Enterprise Cloud. For more information, see GitHub's products in the GitHub Help documentation.
List IdP groups available in an organization. You can limit your page results using the per_page parameter. GitHub generates a url-encoded page token using a cursor value for where the next page begins. For more information on cursor pagination, see "Offset and Cursor Pagination explained."

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page token


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
Function List-IdpGroupsForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$page
    )
    $Querys = @()
    $QueryStrings = @(
        "per_page",
		"page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/team-sync/groups?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/team-sync/groups"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
