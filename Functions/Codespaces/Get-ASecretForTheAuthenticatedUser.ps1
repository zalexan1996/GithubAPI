<#
.SYNOPSIS
Gets a secret available to a user's codespaces without revealing its encrypted value.
You must authenticate using an access token with the codespace or codespace:secrets scope to use this endpoint. User must have Codespaces access to use this endpoint.
GitHub Apps must have read access to the codespaces_user_secrets user permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER secret_name
secret_name parameter


.LINK
https://docs.github.com/en/rest/reference/codespaces

.OUTPUTS
 {
  "name": "CODESPACE_GH_SECRET",
  "created_at": "2019-08-10T14:59:22Z",
  "updated_at": "2020-01-10T14:59:22Z",
  "visibility": "selected",
  "selected_repositories_url": "https://api.github.com/user/codespaces/secrets/CODESPACE_GH_SECRET/repositories"
}
#>
Function Get-ASecretForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$secret_name
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/user/codespaces/secrets/$secret_name?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/codespaces/secrets/$secret_name"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
