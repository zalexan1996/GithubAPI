<#
.SYNOPSIS
Sets the GitHub Actions permissions policy for enabling GitHub Actions and allowed actions and reusable workflows in the repository.
If the repository belongs to an organization or enterprise that has set restrictive permissions at the organization or enterprise levels, such as allowed_actions to selected actions and reusable workflows, then you cannot override them for the repository.
You must authenticate using an access token with the repo scope to use this endpoint. GitHub Apps must have the administration repository permission to use this API.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER enabled
Required. Whether GitHub Actions is enabled on the repository.
         
.PARAMETER allowed_actions
The permissions policy that controls the actions and reusable workflows that are allowed to run. Can be one of: all, local_only, or selected.


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS

#>
Function Set-GithubActionsPermissionsForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][bool]$enabled,
		[Parameter(Mandatory=$FALSE)][string]$allowed_actions
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "enabled",
		"allowed_actions" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/permissions?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/permissions"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
