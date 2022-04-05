
<#
.SYNOPSIS
Note: The SCIM API endpoints for enterprise accounts are currently in beta and are subject to change.
Allows you to change a provisioned group’s individual attributes. To change a group’s values, you must provide a specific Operations JSON format that contains at least one of the add, remove, or replace operations. For examples and more information on the SCIM operations format, see the SCIM specification.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER scim_group_id
Identifier generated by the GitHub SCIM endpoint.
         
.PARAMETER schemas
Required. The SCIM schema URIs.
         
.PARAMETER Operations
Required. Array of SCIM operations.
         
.PARAMETER Properties of theOperationsitems



.LINK
https://docs.github.com/en/rest/reference/enterprise-admin
#>
Function Update-AnAttributeForASCIMEnterpriseGroup
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string]$scim_group_id,
		[Parameter(Mandatory=$FALSE)][string]$schemas,
		[Parameter(Mandatory=$FALSE)][string]$Operations,
		[Parameter(Mandatory=$FALSE)][string]$Properties of theOperationsitems
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Groups/$scim_group_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Groups/$scim_group_id"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"schemas" = "$schemas"
	"Operations" = "$Operations"
    }

    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
