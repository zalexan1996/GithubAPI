<#
.SYNOPSIS
Creates an installation access token that enables a GitHub App to make authenticated API requests for the app's installation on an organization or individual account. Installation tokens expire one hour from the time you create them. Using an expired token produces a status code of 401 - Unauthorized, and requires creating a new installation token. By default the installation token has access to all repositories that the installation can access. To restrict the access to specific repositories, you can provide the repository_ids when creating the token. When you omit repository_ids, the response does not contain the repositories key.
You must use a JWT to access this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER installation_id
installation_id parameter
         
.PARAMETER repositories
List of repository names that the token should have access to
         
.PARAMETER repository_ids
List of repository IDs that the token should have access to
         
.PARAMETER permissions
The permissions granted to the user-to-server access token.


.LINK
https://docs.github.com/en/rest/reference/apps
#>
Function Create-AnInstallationAccessTokenForAnApp
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$installation_id,
		[Parameter(Mandatory=$FALSE)][string[]]$repositories,
		[Parameter(Mandatory=$FALSE)][int[]]$repository_ids,
		[Parameter(Mandatory=$FALSE)][object]$permissions
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "repositories",
		"repository_ids",
		"permissions" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/app/installations/$installation_id/access_tokens?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/app/installations/$installation_id/access_tokens"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
