<#
.SYNOPSIS
Lists the workflows in a repository. Anyone with read access to the repository can use this endpoint. If the repository is private you must use an access token with the repo scope. GitHub Apps must have the actions:read permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "total_count": 2,
  "workflows": [
    {
      "id": 161335,
      "node_id": "MDg6V29ya2Zsb3cxNjEzMzU=",
      "name": "CI",
      "path": ".github/workflows/blank.yaml",
      "state": "active",
      "created_at": "2020-01-08T23:48:37.000-08:00",
      "updated_at": "2020-01-08T23:50:21.000-08:00",
      "url": "https://api.github.com/repos/octo-org/octo-repo/actions/workflows/161335",
      "html_url": "https://github.com/octo-org/octo-repo/blob/master/.github/workflows/161335",
      "badge_url": "https://github.com/octo-org/octo-repo/workflows/CI/badge.svg"
    },
    {
      "id": 269289,
      "node_id": "MDE4OldvcmtmbG93IFNlY29uZGFyeTI2OTI4OQ==",
      "name": "Linter",
      "path": ".github/workflows/linter.yaml",
      "state": "active",
      "created_at": "2020-01-08T23:48:37.000-08:00",
      "updated_at": "2020-01-08T23:50:21.000-08:00",
      "url": "https://api.github.com/repos/octo-org/octo-repo/actions/workflows/269289",
      "html_url": "https://github.com/octo-org/octo-repo/blob/master/.github/workflows/269289",
      "badge_url": "https://github.com/octo-org/octo-repo/workflows/Linter/badge.svg"
    }
  ]
}
#>
Function List-RepositoryWorkflows
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
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
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/workflows?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/workflows"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
