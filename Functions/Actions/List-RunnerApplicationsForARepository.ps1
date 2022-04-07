<#
.SYNOPSIS
Lists binaries for the runner application that you can download and run.
You must authenticate using an access token with the repo scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo



.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 [
  {
    "os": "osx",
    "architecture": "x64",
    "download_url": "https://github.com/actions/runner/releases/download/v2.164.0/actions-runner-osx-x64-2.164.0.tar.gz",
    "filename": "actions-runner-osx-x64-2.164.0.tar.gz"
  },
  {
    "os": "linux",
    "architecture": "x64",
    "download_url": "https://github.com/actions/runner/releases/download/v2.164.0/actions-runner-linux-x64-2.164.0.tar.gz",
    "filename": "actions-runner-linux-x64-2.164.0.tar.gz"
  },
  {
    "os": "linux",
    "architecture": "arm",
    "download_url": "https://github.com/actions/runner/releases/download/v2.164.0/actions-runner-linux-arm-2.164.0.tar.gz",
    "filename": "actions-runner-linux-arm-2.164.0.tar.gz"
  },
  {
    "os": "win",
    "architecture": "x64",
    "download_url": "https://github.com/actions/runner/releases/download/v2.164.0/actions-runner-win-x64-2.164.0.zip",
    "filename": "actions-runner-win-x64-2.164.0.zip"
  },
  {
    "os": "linux",
    "architecture": "arm64",
    "download_url": "https://github.com/actions/runner/releases/download/v2.164.0/actions-runner-linux-arm64-2.164.0.tar.gz",
    "filename": "actions-runner-linux-arm64-2.164.0.tar.gz"
  }
]
#>
Function List-RunnerApplicationsForARepository
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
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runners/downloads?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runners/downloads"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
