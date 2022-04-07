<#
.SYNOPSIS
Select the repositories that will use a user's codespace secret.
You must authenticate using an access token with the codespace or codespace:secrets scope to use this endpoint. User must have Codespaces access to use this endpoint.
GitHub Apps must have write access to the codespaces_user_secrets user permission and write access to the codespace_secrets repository permission on all referenced repositories to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER secret_name
secret_name parameter
         
.PARAMETER selected_repository_ids
Required. An array of repository ids for which a codespace can access the secret. You can manage the list of selected repositories using the List selected repositories for a user secret, Add a selected repository to a user secret, and Remove a selected repository from a user secret endpoints.


.LINK
https://docs.github.com/en/rest/reference/codespaces

.OUTPUTS

#>
Function Set-SelectedRepositoriesForAUserSecret
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$secret_name,
		[Parameter(Mandatory=$FALSE)][int[]]$selected_repository_ids
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "selected_repository_ids" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/user/codespaces/secrets/$secret_name/repositories?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/codespaces/secrets/$secret_name/repositories"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
