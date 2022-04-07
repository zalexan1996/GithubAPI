<#
.SYNOPSIS
List any syntax errors that are detected in the CODEOWNERS file.
For more information about the correct CODEOWNERS syntax, see "About code owners."

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER ref
A branch, tag or commit name used to determine which version of the CODEOWNERS file to use. Default: the repository's default branch (e.g. main)


.LINK
https://docs.github.com/en/rest/reference/repos

.OUTPUTS
 {
  "errors": [
    {
      "line": 3,
      "column": 1,
      "kind": "Invalid pattern",
      "source": "***/*.rb @monalisa",
      "suggestion": "Did you mean `**/*.rb`?",
      "message": "Invalid pattern on line 3: Did you mean `**/*.rb`?\n\n  ***/*.rb @monalisa\n  ^",
      "path": ".github/CODEOWNERS"
    },
    {
      "line": 7,
      "column": 7,
      "kind": "Invalid owner",
      "source": "*.txt docs@",
      "suggestion": null,
      "message": "Invalid owner on line 7:\n\n  *.txt docs@\n        ^",
      "path": ".github/CODEOWNERS"
    }
  ]
}
#>
Function List-CODEOWNERSErrors
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$ref
    )
    $Querys = @()
    $QueryStrings = @(
        "ref"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/codeowners/errors?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/codeowners/errors"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
