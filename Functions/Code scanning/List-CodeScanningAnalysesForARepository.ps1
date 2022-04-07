<#
.SYNOPSIS
Lists the details of all code scanning analyses for a repository, starting with the most recent. The response is paginated and you can use the page and per_page parameters to list the analyses you're interested in. By default 30 analyses are listed per page.
The rules_count field in the response give the number of rules that were run in the analysis. For very old analyses this data is not available, and 0 is returned in this field.
You must use an access token with the security_events scope to use this endpoint with private repos, the public_repo scope also grants permission to read security events on public repos only. GitHub Apps must have the security_events read permission to use this endpoint.
Deprecation notice: The tool_name field is deprecated and will, in future, not be included in the response for this endpoint. The example response reflects this change. The tool name can now be found inside the tool field.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER tool_name
The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either tool_name or tool_guid, but not both.
         
.PARAMETER tool_guid
The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either tool_guid or tool_name, but not both.
         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER ref
The Git reference for the analyses you want to list. The ref for a branch can be formatted either as refs/heads/<branch name> or simply <branch name>. To reference a pull request use refs/pull/<number>/merge.
         
.PARAMETER sarif_id
Filter analyses belonging to the same SARIF upload.


.LINK
https://docs.github.com/en/rest/reference/code-scanning

.OUTPUTS
 [
  {
    "ref": "refs/heads/main",
    "commit_sha": "d99612c3e1f2970085cfbaeadf8f010ef69bad83",
    "analysis_key": ".github/workflows/codeql-analysis.yml:analyze",
    "environment": "{\"language\":\"python\"}",
    "error": "",
    "category": ".github/workflows/codeql-analysis.yml:analyze/language:python",
    "created_at": "2020-08-27T15:05:21Z",
    "results_count": 17,
    "rules_count": 49,
    "id": 201,
    "url": "https://api.github.com/repos/octocat/hello-world/code-scanning/analyses/201",
    "sarif_id": "6c81cd8e-b078-4ac3-a3be-1dad7dbd0b53",
    "tool": {
      "name": "CodeQL",
      "guid": null,
      "version": "2.4.0"
    },
    "deletable": true,
    "warning": ""
  },
  {
    "ref": "refs/heads/my-branch",
    "commit_sha": "c8cff6510d4d084fb1b4aa13b64b97ca12b07321",
    "analysis_key": ".github/workflows/shiftleft.yml:build",
    "environment": "{}",
    "error": "",
    "category": ".github/workflows/shiftleft.yml:build/",
    "created_at": "2020-08-31T22:46:44Z",
    "results_count": 17,
    "rules_count": 32,
    "id": 200,
    "url": "https://api.github.com/repos/octocat/hello-world/code-scanning/analyses/200",
    "sarif_id": "8981cd8e-b078-4ac3-a3be-1dad7dbd0b582",
    "tool": {
      "name": "Python Security Analysis",
      "guid": null,
      "version": "1.2.0"
    },
    "deletable": true,
    "warning": ""
  }
]
#>
Function List-CodeScanningAnalysesForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$tool_name,
		[Parameter(Mandatory=$FALSE)][stringnull]$tool_guid,
		[Parameter(Mandatory=$FALSE)][int]$page,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$ref,
		[Parameter(Mandatory=$FALSE)][string]$sarif_id
    )
    $Querys = @()
    $QueryStrings = @(
        "tool_name",
		"tool_guid",
		"page",
		"per_page",
		"ref",
		"sarif_id"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/analyses?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/analyses"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
