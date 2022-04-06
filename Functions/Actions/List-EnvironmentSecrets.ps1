<#
.SYNOPSIS
Lists all secrets available in an environment without revealing their encrypted values. You must authenticate using an access token with the repo scope to use this endpoint. GitHub Apps must have the secrets repository permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER repository_id

         
.PARAMETER environment_name
The name of the environment
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function List-EnvironmentSecrets
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$repository_id,
		[Parameter(Mandatory=$FALSE)][string]$environment_name,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $QueryStrings = @(
        "per_page=$per_page",
		"page=$page"
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repositories/$repository_id/environments/$environment_name/secrets?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repositories/$repository_id/environments/$environment_name/secrets"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
