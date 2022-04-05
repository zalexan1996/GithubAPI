
<#
.SYNOPSIS
Lists packages owned by the authenticated user within the user's namespace.
To use this endpoint, you must authenticate using an access token with the packages:read scope. If package_type is not container, your token must also include the repo scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER package_type
The type of supported package. Can be one of npm, maven, rubygems, nuget, docker, or container. Packages in GitHub's Gradle registry have the type maven. Docker images pushed to GitHub's Container registry (ghcr.io) have the type container. You can use the type docker to find images that were pushed to GitHub's Docker registry (docker.pkg.github.com), even if these have now been migrated to the Container registry.
         
.PARAMETER visibility
The selected visibility of the packages. Can be one of public, private, or internal. Only container package_types currently support internal visibility properly. For other ecosystems internal is synonymous with private. This parameter is optional and only filters an existing result set.


.LINK
https://docs.github.com/en/rest/reference/packages
#>
Function List-PackagesForTheAuthenticatedUser'sNamespace
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$package_type,
		[Parameter(Mandatory=$FALSE)][string]$visibility
    )
    $QueryStrings = @("package_type=$package_type","visibility=$visibility") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/packages?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/packages"
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

