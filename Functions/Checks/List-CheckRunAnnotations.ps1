<#
.SYNOPSIS
Lists annotations for a check run using the annotation id. GitHub Apps must have the checks:read permission on a private repository or pull access to a public repository to get annotations for a check run. OAuth Apps and authenticated users must have the repo scope to get annotations for a check run in a private repository.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER check_run_id
check_run_id parameter
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/checks

.OUTPUTS
 [
  {
    "path": "README.md",
    "start_line": 2,
    "end_line": 2,
    "start_column": 5,
    "end_column": 10,
    "annotation_level": "warning",
    "title": "Spell Checker",
    "message": "Check your spelling for 'banaas'.",
    "raw_details": "Do you mean 'bananas' or 'banana'?",
    "blob_href": "https://api.github.com/repos/github/rest-api-description/git/blobs/abc"
  }
]
#>
Function List-CheckRunAnnotations
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$check_run_id,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $Querys = @()
    $QueryStrings = @(
        "per_page",
		"page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/check-runs/$check_run_id/annotations?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/check-runs/$check_run_id/annotations"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
