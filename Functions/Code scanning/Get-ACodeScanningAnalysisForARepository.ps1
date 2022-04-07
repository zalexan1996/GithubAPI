<#
.SYNOPSIS
Gets a specified code scanning analysis for a repository. You must use an access token with the security_events scope to use this endpoint with private repos, the public_repo scope also grants permission to read security events on public repos only. GitHub Apps must have the security_events read permission to use this endpoint.
The default JSON response contains fields that describe the analysis. This includes the Git reference and commit SHA to which the analysis relates, the datetime of the analysis, the name of the code scanning tool, and the number of alerts.
The rules_count field in the default response give the number of rules that were run in the analysis. For very old analyses this data is not available, and 0 is returned in this field.
If you use the Accept header application/sarif+json, the response contains the analysis data that was uploaded. This is formatted as SARIF version 2.1.0.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER analysis_id
The ID of the analysis, as returned from the GET /repos/{owner}/{repo}/code-scanning/analyses operation.


.LINK
https://docs.github.com/en/rest/reference/code-scanning

.OUTPUTS
 {
  "ref": "refs/heads/main",
  "commit_sha": "c18c69115654ff0166991962832dc2bd7756e655",
  "analysis_key": ".github/workflows/codeql-analysis.yml:analyze",
  "environment": "{\"language\":\"javascript\"}",
  "error": "",
  "category": ".github/workflows/codeql-analysis.yml:analyze/language:javascript",
  "created_at": "2021-01-13T11:55:49Z",
  "results_count": 3,
  "rules_count": 67,
  "id": 3602840,
  "url": "https://api.github.com/repos/octocat/hello-world/code-scanning/analyses/201",
  "sarif_id": "47177e22-5596-11eb-80a1-c1e54ef945c6",
  "tool": {
    "name": "CodeQL",
    "guid": null,
    "version": "2.4.0"
  },
  "deletable": true,
  "warning": ""
}
#>
Function Get-ACodeScanningAnalysisForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$analysis_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/analyses/$analysis_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/analyses/$analysis_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
