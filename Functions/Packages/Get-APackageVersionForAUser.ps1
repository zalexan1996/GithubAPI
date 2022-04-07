<#
.SYNOPSIS
Gets a specific package version for a public package owned by a specified user.
At this time, to use this endpoint, you must authenticate using an access token with the packages:read scope. If package_type is not container, your token must also include the repo scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER package_type
The type of supported package. Can be one of npm, maven, rubygems, nuget, docker, or container. Packages in GitHub's Gradle registry have the type maven. Docker images pushed to GitHub's Container registry (ghcr.io) have the type container. You can use the type docker to find images that were pushed to GitHub's Docker registry (docker.pkg.github.com), even if these have now been migrated to the Container registry.
         
.PARAMETER package_name
The name of the package.
         
.PARAMETER package_version_id
Unique identifier of the package version.
         
.PARAMETER username



.LINK
https://docs.github.com/en/rest/reference/packages

.OUTPUTS
 {
  "id": 387039,
  "name": "0.2.0",
  "url": "https://api.github.com/users/octocat/packages/rubygems/octo-name/versions/387039",
  "package_html_url": "https://github.com/octocat/octo-name-repo/packages/40201",
  "license": "MIT",
  "created_at": "2019-12-01T20:49:29Z",
  "updated_at": "2019-12-01T20:49:30Z",
  "description": "Octo-name client for Ruby",
  "html_url": "https://github.com/octocat/octo-name-repo/packages/40201?version=0.2.0",
  "metadata": {
    "package_type": "rubygems"
  }
}
#>
Function Get-APackageVersionForAUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$package_type,
		[Parameter(Mandatory=$FALSE)][string]$package_name,
		[Parameter(Mandatory=$FALSE)][int]$package_version_id,
		[Parameter(Mandatory=$FALSE)][string]$username
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/users/$username/packages/$package_type/$package_name/versions/$package_version_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/users/$username/packages/$package_type/$package_name/versions/$package_version_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
