<#
.SYNOPSIS
Lists all locations for a given secret scanning alert for an eligible repository. To use this endpoint, you must be an administrator for the repository or for the organization that owns the repository, and you must use a personal access token with the repo scope or security_events scope. For public repositories, you may instead use the public_repo scope.
GitHub Apps must have the secret_scanning_alerts read permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER alert_number
The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the number field in the response from the GET /repos/{owner}/{repo}/code-scanning/alerts operation.
         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER per_page
Results per page (max 100)
Default: 30


.LINK
https://docs.github.com/en/rest/reference/secret-scanning

.OUTPUTS
 [
  {
    "type": "commit",
    "details": {
      "path": "/example/secrets.txt",
      "start_line": 1,
      "end_line": 1,
      "start_column": 1,
      "end_column": 64,
      "blob_sha": "af5626b4a114abcb82d63db7c8082c3c4756e51b",
      "blob_url": "https://api.github.com/repos/octocat/hello-world/git/blobs/af5626b4a114abcb82d63db7c8082c3c4756e51b",
      "commit_sha": "f14d7debf9775f957cf4f1e8176da0786431f72b",
      "commit_url": "https://api.github.com/repos/octocat/hello-world/git/commits/f14d7debf9775f957cf4f1e8176da0786431f72b"
    }
  },
  {
    "type": "commit",
    "details": {
      "path": "/example/secrets.txt",
      "start_line": 5,
      "end_line": 5,
      "start_column": 1,
      "end_column": 64,
      "blob_sha": "9def38117ab2d8355b982429aa924e268b4b0065",
      "blob_url": "https://api.github.com/repos/octocat/hello-world/git/blobs/9def38117ab2d8355b982429aa924e268b4b0065",
      "commit_sha": "588483b99a46342501d99e3f10630cfc1219ea32",
      "commit_url": "https://api.github.com/repos/octocat/hello-world/git/commits/588483b99a46342501d99e3f10630cfc1219ea32"
    }
  },
  {
    "type": "commit",
    "details": {
      "path": "/example/secrets.txt",
      "start_line": 12,
      "end_line": 12,
      "start_column": 1,
      "end_column": 64,
      "blob_sha": "0b33e9c66e19f7fb15137a82ff1c04c10cba6caf",
      "blob_url": "https://api.github.com/repos/octocat/hello-world/git/blobs/0b33e9c66e19f7fb15137a82ff1c04c10cba6caf",
      "commit_sha": "9def38117ab2d8355b982429aa924e268b4b0065",
      "commit_url": "https://api.github.com/repos/octocat/hello-world/git/commits/9def38117ab2d8355b982429aa924e268b4b0065"
    }
  }
]
#>
Function List-LocationsForASecretScanningAlert
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$alert_number,
		[Parameter(Mandatory=$FALSE)][int]$page,
		[Parameter(Mandatory=$FALSE)][int]$per_page
    )
    $Querys = @()
    $QueryStrings = @(
        "page",
		"per_page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/secret-scanning/alerts/$alert_number/locations?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/secret-scanning/alerts/$alert_number/locations"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
