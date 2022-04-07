<#
.SYNOPSIS
Returns the total commit counts for the owner and total commit counts in all. all is everyone combined, including the owner in the last 52 weeks. If you'd like to get the commit counts for non-owners, you can subtract owner from all.
The array order is oldest week (index 0) to most recent week.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo



.LINK
https://docs.github.com/en/rest/reference/metrics

.OUTPUTS
 {
  "all": [
    11,
    21,
    15,
    2,
    8,
    1,
    8,
    23,
    17,
    21,
    11,
    10,
    33,
    91,
    38,
    34,
    22,
    23,
    32,
    3,
    43,
    87,
    71,
    18,
    13,
    5,
    13,
    16,
    66,
    27,
    12,
    45,
    110,
    117,
    13,
    8,
    18,
    9,
    19,
    26,
    39,
    12,
    20,
    31,
    46,
    91,
    45,
    10,
    24,
    9,
    29,
    7
  ],
  "owner": [
    3,
    2,
    3,
    0,
    2,
    0,
    5,
    14,
    7,
    9,
    1,
    5,
    0,
    48,
    19,
    2,
    0,
    1,
    10,
    2,
    23,
    40,
    35,
    8,
    8,
    2,
    10,
    6,
    30,
    0,
    2,
    9,
    53,
    104,
    3,
    3,
    10,
    4,
    7,
    11,
    21,
    4,
    4,
    22,
    26,
    63,
    11,
    2,
    14,
    1,
    10,
    3
  ]
}
#>
Function Get-TheWeeklyCommitCount
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/stats/participation?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/stats/participation"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
