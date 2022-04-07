<#
.SYNOPSIS
Lists all instances of the specified code scanning alert. You must use an access token with the security_events scope to use this endpoint with private repos, the public_repo scope also grants permission to read security events on public repos only. GitHub Apps must have the security_events read permission to use this endpoint.

        
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
         
.PARAMETER ref
The Git reference for the results you want to list. The ref for a branch can be formatted either as refs/heads/<branch name> or simply <branch name>. To reference a pull request use refs/pull/<number>/merge.


.LINK
https://docs.github.com/en/rest/reference/code-scanning

.OUTPUTS
 [
  {
    "ref": "refs/heads/main",
    "analysis_key": ".github/workflows/codeql-analysis.yml:CodeQL-Build",
    "environment": "",
    "state": "open",
    "fixed_at": null,
    "commit_sha": "39406e42cb832f683daa691dd652a8dc36ee8930",
    "message": {
      "text": "This path depends on a user-provided value."
    },
    "location": {
      "path": "lib/ab12-gen.js",
      "start_line": 917,
      "end_line": 917,
      "start_column": 7,
      "end_column": 18
    },
    "classifications": [
      "library"
    ]
  },
  {
    "ref": "refs/pull/3740/merge",
    "analysis_key": ".github/workflows/codeql-analysis.yml:CodeQL-Build",
    "environment": "",
    "category": ".github/workflows/codeql-analysis.yml:CodeQL-Build",
    "state": "fixed",
    "fixed_at": "2020-02-14T12:29:18Z",
    "commit_sha": "b09da05606e27f463a2b49287684b4ae777092f2",
    "message": {
      "text": "This suffix check is missing a length comparison to correctly handle lastIndexOf returning -1."
    },
    "location": {
      "path": "app/script.js",
      "start_line": 2,
      "end_line": 2,
      "start_column": 10,
      "end_column": 50
    },
    "classifications": [
      "source"
    ]
  }
]
#>
Function List-InstancesOfACodeScanningAlert
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$alert_number,
		[Parameter(Mandatory=$FALSE)][int]$page,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$ref
    )
    $Querys = @()
    $QueryStrings = @(
        "page",
		"per_page",
		"ref"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/alerts/$alert_number/instances?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/alerts/$alert_number/instances"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
