<#
.SYNOPSIS
Gets the number of billable minutes and total run time for a specific workflow run. Billable minutes only apply to workflows in private repositories that use GitHub-hosted runners. Usage is listed for each GitHub-hosted runner operating system in milliseconds. Any job re-runs are also included in the usage. The usage does not include the multiplier for macOS and Windows runners and is not rounded up to the nearest whole minute. For more information, see "Managing billing for GitHub Actions".
Anyone with read access to the repository can use this endpoint. If the repository is private you must use an access token with the repo scope. GitHub Apps must have the actions:read permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER run_id
The id of the workflow run.


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "billable": {
    "UBUNTU": {
      "total_ms": 180000,
      "jobs": 1,
      "job_runs": [
        {
          "job_id": 1,
          "duration_ms": 180000
        }
      ]
    },
    "MACOS": {
      "total_ms": 240000,
      "jobs": 4,
      "job_runs": [
        {
          "job_id": 2,
          "duration_ms": 60000
        },
        {
          "job_id": 3,
          "duration_ms": 60000
        },
        {
          "job_id": 4,
          "duration_ms": 60000
        },
        {
          "job_id": 5,
          "duration_ms": 60000
        }
      ]
    },
    "WINDOWS": {
      "total_ms": 300000,
      "jobs": 2,
      "job_runs": [
        {
          "job_id": 6,
          "duration_ms": 150000
        },
        {
          "job_id": 7,
          "duration_ms": 150000
        }
      ]
    }
  },
  "run_duration_ms": 500000
}
#>
Function Get-WorkflowRunUsage
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$run_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runs/$run_id/timing?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runs/$run_id/timing"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
