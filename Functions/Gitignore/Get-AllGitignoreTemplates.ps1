<#
.SYNOPSIS
List all templates available to pass as an option when creating a repository.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.


.LINK
https://docs.github.com/en/rest/reference/gitignore

.OUTPUTS
 [
  "Actionscript",
  "Android",
  "AppceleratorTitanium",
  "Autotools",
  "Bancha",
  "C",
  "C++"
]
#>
Function Get-AllGitignoreTemplates
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/gitignore/templates?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/gitignore/templates"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
