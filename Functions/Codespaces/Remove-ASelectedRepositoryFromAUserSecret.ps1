<#
.SYNOPSIS
Removes a repository from the selected repositories for a user's codespace secret. You must authenticate using an access token with the user or read:user scope to use this endpoint. User must have Codespaces access to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER secret_name
secret_name parameter
         
.PARAMETER repository_id



.LINK
https://docs.github.com/en/rest/reference/codespaces
#>
Function Remove-ASelectedRepositoryFromAUserSecret
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$secret_name,
		[Parameter(Mandatory=$FALSE)][int]$repository_id
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/codespaces/secrets/$secret_name/repositories/$repository_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/codespaces/secrets/$secret_name/repositories/$repository_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method DELETE -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
