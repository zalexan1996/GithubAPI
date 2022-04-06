<#
.SYNOPSIS
Note: The SCIM API endpoints for enterprise accounts are currently in beta and are subject to change.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER scim_group_id
Identifier generated by the GitHub SCIM endpoint.
         
.PARAMETER excludedAttributes
Attributes to exclude.


.LINK
https://docs.github.com/en/rest/reference/enterprise-admin
#>
Function Get-SCIMProvisioningInformationForAnEnterpriseGroup
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string]$scim_group_id,
		[Parameter(Mandatory=$FALSE)][string]$excludedAttributes
    )
    $QueryStrings = @(
        "excludedAttributes=$excludedAttributes"
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Groups/$scim_group_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Groups/$scim_group_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
