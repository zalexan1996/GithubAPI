<#
.SYNOPSIS
Lists all secrets available in an organization without revealing their encrypted values. You must authenticate using an access token with the admin:org scope to use this endpoint. GitHub Apps must have the dependabot_secrets organization permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/dependabot

.OUTPUTS
 {
  "total_count": 3,
  "secrets": [
    {
      "name": "MY_ARTIFACTORY_PASSWORD",
      "created_at": "2021-08-10T14:59:22Z",
      "updated_at": "2021-12-10T14:59:22Z",
      "visibility": "private"
    },
    {
      "name": "NPM_TOKEN",
      "created_at": "2021-08-10T14:59:22Z",
      "updated_at": "2021-12-10T14:59:22Z",
      "visibility": "all"
    },
    {
      "name": "GH_TOKEN",
      "created_at": "2021-08-10T14:59:22Z",
      "updated_at": "2021-12-10T14:59:22Z",
      "visibility": "selected",
      "selected_repositories_url": "https://api.github.com/orgs/octo-org/dependabot/secrets/SUPER_SECRET/repositories"
    }
  ]
}
#>
Function List-OrganizationSecrets
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
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
        $FinalURL = "https://api.github.com/orgs/$org/dependabot/secrets?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/dependabot/secrets"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
