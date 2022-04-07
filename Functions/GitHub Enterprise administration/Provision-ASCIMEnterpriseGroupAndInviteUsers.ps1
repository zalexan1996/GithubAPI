<#
.SYNOPSIS
Note: The SCIM API endpoints for enterprise accounts are currently in beta and are subject to change.
Provision an enterprise group, and invite users to the group. This sends invitation emails to the email address of the invited users to join the GitHub organization that the SCIM group corresponds to.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER schemas
Required. The SCIM schema URIs.
         
.PARAMETER displayName
Required. The name of the SCIM group. This must match the GitHub organization that the group maps to.
         
.PARAMETER members



.LINK
https://docs.github.com/en/rest/reference/enterprise-admin

.OUTPUTS
 {
  "schemas": [
    "urn:ietf:params:scim:schemas:core:2.0:Group"
  ],
  "id": "abcd27f8-a9aa-11ea-8221-f59b2be9cccc",
  "externalId": null,
  "displayName": "octo-org",
  "members": [
    {
      "value": "92b58aaa-a1d6-11ea-8227-b9ce9e023ccc",
      "$ref": "https://api.github.com/scim/v2/enterprises/octo-corp/Users/92b58aaa-a1d6-11ea-8227-b9ce9e023ccc",
      "display": "octocat@github.com"
    },
    {
      "value": "aaaa8c34-a6b2-11ea-9d70-bbbbbd1c8fd5",
      "$ref": "https://api.github.com/scim/v2/enterprises/octo-corp/Users/aaaa8c34-a6b2-11ea-9d70-bbbbbd1c8fd5",
      "display": "hubot@example.com"
    }
  ],
  "meta": {
    "resourceType": "Group",
    "created": "2020-06-09T03:10:17.000+10:0",
    "lastModified": "2020-06-09T03:10:17.000+10:00",
    "location": "https://api.github.com/scim/v2/enterprises/octo-corp/Groups/abcd27f8-a9aa-11ea-8221-f59b2be9cccc"
  }
}
#>
Function Provision-ASCIMEnterpriseGroupAndInviteUsers
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string[]]$schemas,
		[Parameter(Mandatory=$FALSE)][string]$displayName,
		[Parameter(Mandatory=$FALSE)][object[]]$members
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "schemas",
		"displayName",
		"members" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Groups?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Groups"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
