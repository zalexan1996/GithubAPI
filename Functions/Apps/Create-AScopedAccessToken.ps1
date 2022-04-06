<#
.SYNOPSIS
Use a non-scoped user-to-server OAuth access token to create a repository scoped and/or permission scoped user-to-server OAuth access token. You can specify which repositories the token can access and which permissions are granted to the token. You must use Basic Authentication when accessing this endpoint, using the OAuth application's client_id and client_secret as the username and password. Invalid tokens will return 404 NOT FOUND.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER client_id
The client ID of your GitHub app.
         
.PARAMETER access_token
Required. The OAuth access token used to authenticate to the GitHub API.
         
.PARAMETER target
The name of the user or organization to scope the user-to-server access token to. Required unless target_id is specified.
         
.PARAMETER target_id
The ID of the user or organization to scope the user-to-server access token to. Required unless target is specified.
         
.PARAMETER repositories
The list of repository names to scope the user-to-server access token to. repositories may not be specified if repository_ids is specified.
         
.PARAMETER repository_ids
The list of repository IDs to scope the user-to-server access token to. repository_ids may not be specified if repositories is specified.
         
.PARAMETER permissions
The permissions granted to the user-to-server access token.


.LINK
https://docs.github.com/en/rest/reference/apps
#>
Function Create-AScopedAccessToken
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$client_id,
		[Parameter(Mandatory=$FALSE)][string]$access_token,
		[Parameter(Mandatory=$FALSE)][string]$target,
		[Parameter(Mandatory=$FALSE)][int]$target_id,
		[Parameter(Mandatory=$FALSE)][string[]]$repositories,
		[Parameter(Mandatory=$FALSE)][int[]]$repository_ids,
		[Parameter(Mandatory=$FALSE)][object]$permissions
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "access_token",
		"target",
		"target_id",
		"repositories",
		"repository_ids",
		"permissions" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/applications/$client_id/token/scoped?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/applications/$client_id/token/scoped"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
