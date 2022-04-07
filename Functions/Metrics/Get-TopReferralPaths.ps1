<#
.SYNOPSIS
Get the top 10 popular contents over the last 14 days.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo



.LINK
https://docs.github.com/en/rest/reference/metrics

.OUTPUTS
 [
  {
    "path": "/github/hubot",
    "title": "github/hubot: A customizable life embetterment robot.",
    "count": 3542,
    "uniques": 2225
  },
  {
    "path": "/github/hubot/blob/master/docs/scripting.md",
    "title": "hubot/scripting.md at master · github/hubot · GitHub",
    "count": 1707,
    "uniques": 804
  },
  {
    "path": "/github/hubot/tree/master/docs",
    "title": "hubot/docs at master · github/hubot · GitHub",
    "count": 685,
    "uniques": 435
  },
  {
    "path": "/github/hubot/tree/master/src",
    "title": "hubot/src at master · github/hubot · GitHub",
    "count": 577,
    "uniques": 347
  },
  {
    "path": "/github/hubot/blob/master/docs/index.md",
    "title": "hubot/index.md at master · github/hubot · GitHub",
    "count": 379,
    "uniques": 259
  },
  {
    "path": "/github/hubot/blob/master/docs/adapters.md",
    "title": "hubot/adapters.md at master · github/hubot · GitHub",
    "count": 354,
    "uniques": 201
  },
  {
    "path": "/github/hubot/tree/master/examples",
    "title": "hubot/examples at master · github/hubot · GitHub",
    "count": 340,
    "uniques": 260
  },
  {
    "path": "/github/hubot/blob/master/docs/deploying/heroku.md",
    "title": "hubot/heroku.md at master · github/hubot · GitHub",
    "count": 324,
    "uniques": 217
  },
  {
    "path": "/github/hubot/blob/master/src/robot.coffee",
    "title": "hubot/robot.coffee at master · github/hubot · GitHub",
    "count": 293,
    "uniques": 191
  },
  {
    "path": "/github/hubot/blob/master/LICENSE.md",
    "title": "hubot/LICENSE.md at master · github/hubot · GitHub",
    "count": 281,
    "uniques": 222
  }
]
#>
Function Get-TopReferralPaths
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
        $FinalURL = "https://api.github.com/repos/$owner/$repo/traffic/popular/paths?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/traffic/popular/paths"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
