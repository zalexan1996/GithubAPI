<#
.SYNOPSIS
Sets the GitHub Actions permissions policy for organizations and allowed actions and reusable workflows in an enterprise.
You must authenticate using an access token with the admin:enterprise scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER enabled_organizations
Required. The policy that controls the organizations in the enterprise that are allowed to run GitHub Actions. Can be one of: all, none, or selected.
         
.PARAMETER allowed_actions
The permissions policy that controls the actions and reusable workflows that are allowed to run. Can be one of: all, local_only, or selected.


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Set-GithubActionsPermissionsForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string]$enabled_organizations,
		[Parameter(Mandatory=$FALSE)][string]$allowed_actions
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "enabled_organizations",
		"allowed_actions" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/permissions?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/permissions"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
