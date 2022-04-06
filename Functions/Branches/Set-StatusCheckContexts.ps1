<#
.SYNOPSIS
Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see GitHub's products in the GitHub Help documentation.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER branch
The name of the branch.
         
.PARAMETER contexts
Required. contexts parameter


.LINK
https://docs.github.com/en/rest/reference/branches
#>
Function Set-StatusCheckContexts
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$branch,
		[Parameter(Mandatory=$FALSE)][string[]]$contexts
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "contexts" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/branches/$branch/protection/required_status_checks/contexts?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/branches/$branch/protection/required_status_checks/contexts"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
