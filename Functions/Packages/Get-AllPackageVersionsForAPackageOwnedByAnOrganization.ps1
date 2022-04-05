
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
#>
Function Get-AllPackageVersionsForAPackageOwnedByAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$package_type,
		[Parameter(Mandatory=$FALSE)][string]$package_name,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$page,
		[Parameter(Mandatory=$FALSE)][string]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$state
    )
    $QueryStrings = @("page=$page","per_page=$per_page","state=$state") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/packages/$package_type/$package_name/versions?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/packages/$package_type/$package_name/versions"
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

