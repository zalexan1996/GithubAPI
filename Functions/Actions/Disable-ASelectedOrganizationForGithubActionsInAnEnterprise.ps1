<#
.SYNOPSIS
Removes an organization from the list of selected organizations that are enabled for GitHub Actions in an enterprise. To use this endpoint, the enterprise permission policy for enabled_organizations must be configured to selected. For more information, see "Set GitHub Actions permissions for an enterprise."
You must authenticate using an access token with the admin:enterprise scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER org_id
Unique identifier of an organization.


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Disable-ASelectedOrganizationForGithubActionsInAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][int]$org_id
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/permissions/organizations/$org_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/permissions/organizations/$org_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method DELETE -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
