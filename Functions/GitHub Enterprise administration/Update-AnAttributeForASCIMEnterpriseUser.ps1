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

.OUTPUTS
 {
  "schemas": [
    "urn:ietf:params:scim:schemas:core:2.0:User"
  ],
  "id": "92b58aaa-a1d6-11ea-8227-b9ce9e023ccc",
  "externalId": "00dowz5dr9oSfDFRA0h7",
  "userName": "mona.octocat@okta.example.com",
  "name": {
    "givenName": "Monalisa",
    "familyName": "Octocat"
  },
  "emails": [
    {
      "value": "mona.octocat@okta.example.com",
      "type": "work",
      "primary": true
    },
    {
      "value": "monalisa@octocat.github.com",
      "type": "home"
    }
  ],
  "groups": [
    {
      "value": "468dd3fa-a1d6-11ea-9031-15a1f0d7811d"
    }
  ],
  "active": true,
  "meta": {
    "resourceType": "User",
    "created": "2017-03-09T16:11:13-05:00",
    "lastModified": "2017-03-09T16:11:13-05:00",
    "location": "https://api.github.com/scim/v2/enterprises/octo-corp/Users/92b58aaa-a1d6-11ea-8227-b9ce9e023ccc"
  }
}
#>
Function Update-AnAttributeForASCIMEnterpriseUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string]$scim_user_id,
		[Parameter(Mandatory=$FALSE)][string[]]$schemas,
		[Parameter(Mandatory=$FALSE)][object[]]$Operations
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "schemas",
		"Operations" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Users/$scim_user_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Users/$scim_user_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
