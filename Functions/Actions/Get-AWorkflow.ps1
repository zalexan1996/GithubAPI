<#
.SYNOPSIS
Gets a specific workflow. You can replace workflow_id with the workflow file name. For example, you could use main.yaml. Anyone with read access to the repository can use this endpoint. If the repository is private you must use an access token with the repo scope. GitHub Apps must have the actions:read permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER workflow_id
The ID of the workflow. You can also pass the workflow file name as a string.


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
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
}
#>
Function Get-AWorkflow
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$workflow_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
