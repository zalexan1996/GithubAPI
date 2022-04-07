<#
.SYNOPSIS
Remove a custom label from a self-hosted runner configured in a repository. Returns the remaining labels from the runner.
This endpoint returns a 404 Not Found status if the custom label is not present on the runner.
You must authenticate using an access token with the repo scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER runner_id
Unique identifier of the self-hosted runner.
         
.PARAMETER name
The name of a self-hosted runner's custom label.


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "total_count": 4,
  "labels": [
    {
      "id": 5,
      "name": "self-hosted",
      "type": "read-only"
    },
    {
      "id": 7,
      "name": "X64",
      "type": "read-only"
    },
    {
      "id": 20,
      "name": "macOS",
      "type": "read-only"
    },
    {
      "id": 21,
      "name": "no-gpu",
      "type": "custom"
    }
  ]
}
#>
Function Remove-ACustomLabelFromASelf-HostedRunnerForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$runner_id,
		[Parameter(Mandatory=$FALSE)][string]$name
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runners/$runner_id/labels/$name?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runners/$runner_id/labels/$name"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method DELETE -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
