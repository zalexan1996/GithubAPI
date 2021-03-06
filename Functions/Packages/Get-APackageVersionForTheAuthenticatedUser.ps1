<#
.SYNOPSIS
Gets a specific package version for a package owned by the authenticated user.
To use this endpoint, you must authenticate using an access token with the packages:read scope. If package_type is not container, your token must also include the repo scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER package_type
The type of supported package. Can be one of npm, maven, rubygems, nuget, docker, or container. Packages in GitHub's Gradle registry have the type maven. Docker images pushed to GitHub's Container registry (ghcr.io) have the type container. You can use the type docker to find images that were pushed to GitHub's Docker registry (docker.pkg.github.com), even if these have now been migrated to the Container registry.
         
.PARAMETER package_name
The name of the package.
         
.PARAMETER package_version_id
Unique identifier of the package version.


.LINK
https://docs.github.com/en/rest/reference/packages

.OUTPUTS
 {
  "id": 214,
  "name": "sha256:3561f0cff06caccddb99c93bd26e712fcc56a811de0f8ea7a17bb865f30b176a",
  "url": "https://api.github.com/users/octocat/packages/container/hello_docker/versions/214",
  "package_html_url": "https://github.com/users/octocat/packages/container/package/hello_docker",
  "created_at": "2020-05-15T03:46:45Z",
  "updated_at": "2020-05-15T03:46:45Z",
  "html_url": "https://github.com/users/octocat/packages/container/hello_docker/214",
  "metadata": {
    "package_type": "container",
    "container": {
      "tags": [
        "1.13.6"
      ]
    }
  }
}
#>
Function Get-APackageVersionForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$package_type,
		[Parameter(Mandatory=$FALSE)][string]$package_name,
		[Parameter(Mandatory=$FALSE)][int]$package_version_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/user/packages/$package_type/$package_name/versions/$package_version_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/packages/$package_type/$package_name/versions/$package_version_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
