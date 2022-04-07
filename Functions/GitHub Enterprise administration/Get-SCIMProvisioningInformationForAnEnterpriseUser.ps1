<#
.SYNOPSIS
Note: The SCIM API endpoints for enterprise accounts are currently in beta and are subject to change.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER scim_user_id
scim_user_id parameter


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
Function Get-SCIMProvisioningInformationForAnEnterpriseUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string]$scim_user_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
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
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
