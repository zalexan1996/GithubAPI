<#
.SYNOPSIS
Get the total number of clones and breakdown per day or week for the last 14 days. Timestamps are aligned to UTC midnight of the beginning of the day or week. Week begins on Monday.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER per
Must be one of: day, week.
Default: day


.LINK
https://docs.github.com/en/rest/reference/metrics

.OUTPUTS
 {
  "count": 173,
  "uniques": 128,
  "clones": [
    {
      "timestamp": "2016-10-10T00:00:00Z",
      "count": 2,
      "uniques": 1
    },
    {
      "timestamp": "2016-10-11T00:00:00Z",
      "count": 17,
      "uniques": 16
    },
    {
      "timestamp": "2016-10-12T00:00:00Z",
      "count": 21,
      "uniques": 15
    },
    {
      "timestamp": "2016-10-13T00:00:00Z",
      "count": 8,
      "uniques": 7
    },
    {
      "timestamp": "2016-10-14T00:00:00Z",
      "count": 5,
      "uniques": 5
    },
    {
      "timestamp": "2016-10-15T00:00:00Z",
      "count": 2,
      "uniques": 2
    },
    {
      "timestamp": "2016-10-16T00:00:00Z",
      "count": 8,
      "uniques": 7
    },
    {
      "timestamp": "2016-10-17T00:00:00Z",
      "count": 26,
      "uniques": 15
    },
    {
      "timestamp": "2016-10-18T00:00:00Z",
      "count": 19,
      "uniques": 17
    },
    {
      "timestamp": "2016-10-19T00:00:00Z",
      "count": 19,
      "uniques": 14
    },
    {
      "timestamp": "2016-10-20T00:00:00Z",
      "count": 19,
      "uniques": 15
    },
    {
      "timestamp": "2016-10-21T00:00:00Z",
      "count": 9,
      "uniques": 7
    },
    {
      "timestamp": "2016-10-22T00:00:00Z",
      "count": 5,
      "uniques": 5
    },
    {
      "timestamp": "2016-10-23T00:00:00Z",
      "count": 6,
      "uniques": 5
    },
    {
      "timestamp": "2016-10-24T00:00:00Z",
      "count": 7,
      "uniques": 5
    }
  ]
}
#>
Function Get-RepositoryClones
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$per
    )
    $Querys = @()
    $QueryStrings = @(
        "per"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/traffic/clones?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/traffic/clones"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
