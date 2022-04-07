<#
.SYNOPSIS
Gets the diff of the dependency changes between two commits of a repository, based on the changes to the dependency manifests made in those commits.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER basehead
The base and head Git revisions to compare. The Git revisions will be resolved to commit SHAs. Named revisions will be resolved to their corresponding HEAD commits, and an appropriate merge base will be determined. This parameter expects the format {base}...{head}.
         
.PARAMETER name
The full path, relative to the repository root, of the dependency manifest file.


.LINK
https://docs.github.com/en/rest/reference/dependency-graph

.OUTPUTS
 [
  {
    "change_type": "removed",
    "manifest": "package.json",
    "ecosystem": "npm",
    "name": "helmet",
    "version": "4.6.0",
    "package_url": "pkg:npm/helmet@4.6.0",
    "license": "MIT",
    "source_repository_url": "https://github.com/helmetjs/helmet",
    "vulnerabilities": []
  },
  {
    "change_type": "added",
    "manifest": "package.json",
    "ecosystem": "npm",
    "name": "helmet",
    "version": "5.0.0",
    "package_url": "pkg:npm/helmet@5.0.0",
    "license": "MIT",
    "source_repository_url": "https://github.com/helmetjs/helmet",
    "vulnerabilities": []
  },
  {
    "change_type": "added",
    "manifest": "Gemfile",
    "ecosystem": "rubygems",
    "name": "ruby-openid",
    "version": "2.7.0",
    "package_url": "pkg:gem/ruby-openid@2.7.0",
    "license": null,
    "source_repository_url": "https://github.com/openid/ruby-openid",
    "vulnerabilities": [
      {
        "severity": "critical",
        "advisory_ghsa_id": "GHSA-fqfj-cmh6-hj49",
        "advisory_summary": "Ruby OpenID",
        "advisory_url": "https://github.com/advisories/GHSA-fqfj-cmh6-hj49"
      }
    ]
  }
]
#>
Function Get-ADiffOfTheDependenciesBetweenCommits
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$basehead,
		[Parameter(Mandatory=$FALSE)][string]$name
    )
    $Querys = @()
    $QueryStrings = @(
        "name"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/dependency-graph/compare/$basehead?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/dependency-graph/compare/$basehead"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
