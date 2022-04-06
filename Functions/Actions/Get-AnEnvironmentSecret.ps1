<#
.SYNOPSIS
Gets a single environment secret without revealing its encrypted value. You must authenticate using an access token with the repo scope to use this endpoint. GitHub Apps must have the secrets repository permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER repository_id

         
.PARAMETER environment_name
The name of the environment
         
.PARAMETER secret_name
secret_name parameter


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Get-AnEnvironmentSecret
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$repository_id,
		[Parameter(Mandatory=$FALSE)][string]$environment_name,
		[Parameter(Mandatory=$FALSE)][string]$secret_name
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repositories/$repository_id/environments/$environment_name/secrets/$secret_name?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repositories/$repository_id/environments/$environment_name/secrets/$secret_name"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
