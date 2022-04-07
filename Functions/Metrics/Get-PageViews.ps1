<#
.SYNOPSIS
Get the total number of views and breakdown per day or week for the last 14 days. Timestamps are aligned to UTC midnight of the beginning of the day or week. Week begins on Monday.

        
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
  "count": 14850,
  "uniques": 3782,
  "views": [
    {
      "timestamp": "2016-10-10T00:00:00Z",
      "count": 440,
      "uniques": 143
    },
    {
      "timestamp": "2016-10-11T00:00:00Z",
      "count": 1308,
      "uniques": 414
    },
    {
      "timestamp": "2016-10-12T00:00:00Z",
      "count": 1486,
      "uniques": 452
    },
    {
      "timestamp": "2016-10-13T00:00:00Z",
      "count": 1170,
      "uniques": 401
    },
    {
      "timestamp": "2016-10-14T00:00:00Z",
      "count": 868,
      "uniques": 266
    },
    {
      "timestamp": "2016-10-15T00:00:00Z",
      "count": 495,
      "uniques": 157
    },
    {
      "timestamp": "2016-10-16T00:00:00Z",
      "count": 524,
      "uniques": 175
    },
    {
      "timestamp": "2016-10-17T00:00:00Z",
      "count": 1263,
      "uniques": 412
    },
    {
      "timestamp": "2016-10-18T00:00:00Z",
      "count": 1402,
      "uniques": 417
    },
    {
      "timestamp": "2016-10-19T00:00:00Z",
      "count": 1394,
      "uniques": 424
    },
    {
      "timestamp": "2016-10-20T00:00:00Z",
      "count": 1492,
      "uniques": 448
    },
    {
      "timestamp": "2016-10-21T00:00:00Z",
      "count": 1153,
      "uniques": 332
    },
    {
      "timestamp": "2016-10-22T00:00:00Z",
      "count": 566,
      "uniques": 168
    },
    {
      "timestamp": "2016-10-23T00:00:00Z",
      "count": 675,
      "uniques": 184
    },
    {
      "timestamp": "2016-10-24T00:00:00Z",
      "count": 614,
      "uniques": 237
    }
  ]
}
#>
Function Get-PageViews
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
        $FinalURL = "https://api.github.com/repos/$owner/$repo/traffic/views?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/traffic/views"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
