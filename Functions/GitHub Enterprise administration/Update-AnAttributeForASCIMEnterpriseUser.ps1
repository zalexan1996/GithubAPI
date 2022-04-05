
<#
.SYNOPSIS
Note: The SCIM API endpoints for enterprise accounts are currently in beta and are subject to change.
Allows you to change a provisioned user's individual attributes. To change a user's values, you must provide a specific Operations JSON format that contains at least one of the add, remove, or replace operations. For examples and more information on the SCIM operations format, see the SCIM specification.
Note: Complicated SCIM path selectors that include filters are not supported. For example, a path selector defined as "path": "emails[type eq \"work\"]" will not work.
Warning: If you set active:false using the replace operation (as shown in the JSON example below), it removes the user from the enterprise, deletes the external identity, and deletes the associated :scim_user_id.
{
  "Operations":[{
    "op":"replace",
    "value":{
      "active":false
    }
  }]
}

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER scim_user_id
scim_user_id parameter
         
.PARAMETER schemas
Required. The SCIM schema URIs.
         
.PARAMETER Operations
Required. Array of SCIM operations.


.LINK
https://docs.github.com/en/rest/reference/enterprise-admin
#>
Function Update-AnAttributeForASCIMEnterpriseUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string]$scim_user_id,
		[Parameter(Mandatory=$FALSE)][string]$schemas,
		[Parameter(Mandatory=$FALSE)][string]$Operations
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Users/$scim_user_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Users/$scim_user_id"
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

