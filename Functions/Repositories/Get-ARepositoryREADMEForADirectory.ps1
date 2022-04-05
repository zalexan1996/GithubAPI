
<#
.SYNOPSIS
Gets the README from a repository directory.
READMEs support custom media types for retrieving the raw content or rendered HTML.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER dir
The alternate path to look for a README file
         
.PARAMETER ref
The name of the commit/branch/tag. Default: the repository’s default branch (usually master)


.LINK
https://docs.github.com/en/rest/reference/repos
#>
Function Get-ARepositoryREADMEForADirectory
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$dir,
		[Parameter(Mandatory=$FALSE)][string]$ref
    )
    $QueryStrings = @("ref=$ref") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/readme/$dir?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/readme/$dir"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

