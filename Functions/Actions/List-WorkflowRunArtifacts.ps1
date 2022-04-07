<#
.SYNOPSIS
Lists artifacts for a workflow run. Anyone with read access to the repository can use this endpoint. If the repository is private you must use an access token with the repo scope. GitHub Apps must have the actions:read permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER run_id
The id of the workflow run.
         
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
  "artifacts": [
    {
      "id": 11,
      "node_id": "MDg6QXJ0aWZhY3QxMQ==",
      "name": "Rails",
      "size_in_bytes": 556,
      "url": "https://api.github.com/repos/octo-org/octo-docs/actions/artifacts/11",
      "archive_download_url": "https://api.github.com/repos/octo-org/octo-docs/actions/artifacts/11/zip",
      "expired": false,
      "created_at": "2020-01-10T14:59:22Z",
      "expires_at": "2020-03-21T14:59:22Z",
      "updated_at": "2020-02-21T14:59:22Z"
    },
    {
      "id": 13,
      "node_id": "MDg6QXJ0aWZhY3QxMw==",
      "name": "",
      "size_in_bytes": 453,
      "url": "https://api.github.com/repos/octo-org/octo-docs/actions/artifacts/13",
      "archive_download_url": "https://api.github.com/repos/octo-org/octo-docs/actions/artifacts/13/zip",
      "expired": false,
      "created_at": "2020-01-10T14:59:22Z",
      "expires_at": "2020-03-21T14:59:22Z",
      "updated_at": "2020-02-21T14:59:22Z"
    }
  ]
}
#>
Function List-WorkflowRunArtifacts
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$run_id,
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
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runs/$run_id/artifacts?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runs/$run_id/artifacts"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
