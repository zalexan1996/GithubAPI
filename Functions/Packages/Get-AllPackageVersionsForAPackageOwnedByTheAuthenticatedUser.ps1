<#
.SYNOPSIS
Returns all package versions for a package owned by the authenticated user.
To use this endpoint, you must authenticate using an access token with the packages:read scope. If package_type is not container, your token must also include the repo scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER package_type
The type of supported package. Can be one of npm, maven, rubygems, nuget, docker, or container. Packages in GitHub's Gradle registry have the type maven. Docker images pushed to GitHub's Container registry (ghcr.io) have the type container. You can use the type docker to find images that were pushed to GitHub's Docker registry (docker.pkg.github.com), even if these have now been migrated to the Container registry.
         
.PARAMETER package_name
The name of the package.
         
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
    "id": 45763,
    "name": "sha256:08a44bab0bddaddd8837a8b381aebc2e4b933768b981685a9e088360af0d3dd9",
    "url": "https://api.github.com/users/octocat/packages/container/hello_docker/versions/45763",
    "package_html_url": "https://github.com/users/octocat/packages/container/package/hello_docker",
    "created_at": "2020-09-11T21:56:40Z",
    "updated_at": "2021-02-05T21:32:32Z",
    "html_url": "https://github.com/users/octocat/packages/container/hello_docker/45763",
    "metadata": {
      "package_type": "container",
      "container": {
        "tags": [
          "latest"
        ]
      }
    }
  },
  {
    "id": 881,
    "name": "sha256:b3d3e366b55f9a54599220198b3db5da8f53592acbbb7dc7e4e9878762fc5344",
    "url": "https://api.github.com/users/octocat/packages/container/hello_docker/versions/881",
    "package_html_url": "https://github.com/users/octocat/packages/container/package/hello_docker",
    "created_at": "2020-05-21T22:22:20Z",
    "updated_at": "2021-02-05T21:32:32Z",
    "html_url": "https://github.com/users/octocat/packages/container/hello_docker/881",
    "metadata": {
      "package_type": "container",
      "container": {
        "tags": []
      }
    }
  }
]
#>
Function Get-AllPackageVersionsForAPackageOwnedByTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$package_type,
		[Parameter(Mandatory=$FALSE)][string]$package_name,
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
        $FinalURL = "https://api.github.com/user/packages/$package_type/$package_name/versions?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/packages/$package_type/$package_name/versions"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
