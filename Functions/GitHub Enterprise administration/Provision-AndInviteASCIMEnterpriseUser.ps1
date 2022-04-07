<#
.SYNOPSIS
Note: The SCIM API endpoints for enterprise accounts are currently in beta and are subject to change.
Provision enterprise membership for a user, and send organization invitation emails to the email address.
You can optionally include the groups a user will be invited to join. If you do not provide a list of groups, the user is provisioned for the enterprise, but no organization invitation emails will be sent.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER schemas
Required. The SCIM schema URIs.
         
.PARAMETER userName
Required. The username for the user.
         
.PARAMETER name
Required.
         
.PARAMETER emails
Required. List of user emails.
         
.PARAMETER groups
List of SCIM group IDs the user is a member of.


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
    "givenName": "Mona",
    "familyName": "Octocat"
  },
  "emails": [
    {
      "value": "mona.octocat@okta.example.com",
      "type": "work",
      "primary": true
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
Function Provision-AndInviteASCIMEnterpriseUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string[]]$schemas,
		[Parameter(Mandatory=$FALSE)][string]$userName,
		[Parameter(Mandatory=$FALSE)][object]$name,
		[Parameter(Mandatory=$FALSE)][object[]]$emails,
		[Parameter(Mandatory=$FALSE)][object[]]$groups
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "schemas",
		"userName",
		"name",
		"emails",
		"groups" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Users?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Users"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
