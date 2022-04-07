<#
.SYNOPSIS
Updates information for a GitHub Pages site. For more information, see "About GitHub Pages.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER cname
Specify a custom domain for the repository. Sending a null value will remove the custom domain. For more about custom domains, see "Using a custom domain with GitHub Pages."
         
.PARAMETER https_enforced
Specify whether HTTPS should be enforced for the repository.
         
.PARAMETER public
Configures access controls for the GitHub Pages site. If public is set to true, the site is accessible to anyone on the internet. If set to false, the site will only be accessible to users who have at least read access to the repository that published the site. This includes anyone in your Enterprise if the repository is set to internal visibility. This feature is only available to repositories in an organization on an Enterprise plan.
         
.PARAMETER source



.LINK
https://docs.github.com/en/rest/reference/pages

.OUTPUTS

#>
Function Update-InformationAboutAGithubPagesSite
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$cname,
		[Parameter(Mandatory=$FALSE)][bool]$https_enforced,
		[Parameter(Mandatory=$FALSE)][bool]$public,
		[Parameter(Mandatory=$FALSE)][string]$source
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "cname",
		"https_enforced",
		"public",
		"source" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pages?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pages"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
