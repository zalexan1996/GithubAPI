<#
.SYNOPSIS
Returns all package versions for a package owned by an organization.
To use this endpoint, you must authenticate using an access token with the packages:read scope. If package_type is not container, your token must also include the repo scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER package_type
The type of supported package. Can be one of npm, maven, rubygems, nuget, docker, or container. Packages in GitHub's Gradle registry have the type maven. Docker images pushed to GitHub's Container registry (ghcr.io) have the type container. You can use the type docker to find images that were pushed to GitHub's Docker registry (docker.pkg.github.com), even if these have now been migrated to the Container registry.
         
.PARAMETER package_name
The name of the package.
         
.PARAMETER org

         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER state
The state of the package, either active or deleted.
Default: active


.LINK
https://docs.github.com/en/rest/reference/packages

.OUTPUTS
 [
  {
    "id": 245301,
    "name": "1.0.4",
    "url": "https://api.github.com/orgs/octo-org/packages/npm/hello-world-npm/versions/245301",
    "package_html_url": "https://github.com/octo-org/hello-world-npm/packages/43752",
    "created_at": "2019-11-05T22:49:04Z",
    "updated_at": "2019-11-05T22:49:04Z",
    "html_url": "https://github.com/octo-org/hello-world-npm/packages/43752?version=1.0.4",
    "metadata": {
      "package_type": "npm"
    }
  },
  {
    "id": 209672,
    "name": "1.0.3",
    "url": "https://api.github.com/orgs/octo-org/packages/npm/hello-world-npm/versions/209672",
    "package_html_url": "https://github.com/octo-org/hello-world-npm/packages/43752",
    "created_at": "2019-10-29T15:42:11Z",
    "updated_at": "2019-10-29T15:42:12Z",
    "html_url": "https://github.com/octo-org/hello-world-npm/packages/43752?version=1.0.3",
    "metadata": {
      "package_type": "npm"
    }
  }
]
#>
Function Get-AllPackageVersionsForAPackageOwnedByAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$package_type,
		[Parameter(Mandatory=$FALSE)][string]$package_name,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][int]$page,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$state
    )
    $Querys = @()
    $QueryStrings = @(
        "page",
		"per_page",
		"state"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/packages/$package_type/$package_name/versions?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/packages/$package_type/$package_name/versions"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
