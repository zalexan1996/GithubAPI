<#
.SYNOPSIS
Note: The SCIM API endpoints for enterprise accounts are currently in beta and are subject to change.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER startIndex
Used for pagination: the index of the first result to return.
         
.PARAMETER count
Used for pagination: the number of results to return.
         
.PARAMETER filter
filter results
         
.PARAMETER excludedAttributes
attributes to exclude


.LINK
https://docs.github.com/en/rest/reference/enterprise-admin

.OUTPUTS
 {
  "schemas": [
    "urn:ietf:params:scim:api:messages:2.0:ListResponse"
  ],
  "totalResults": 2,
  "itemsPerPage": 2,
  "startIndex": 1,
  "Resources": [
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
        "created": "2020-06-09T03:10:17.000+10:00",
        "lastModified": "2020-06-09T03:10:17.000+10:00",
        "location": "https://api.github.com/scim/v2/enterprises/octo-corp/Groups/abcd27f8-a9aa-11ea-8221-f59b2be9cccc"
      }
    },
    {
      "schemas": [
        "urn:ietf:params:scim:schemas:core:2.0:Group"
      ],
      "id": "5e75bbbb-aa1a-11ea-8644-75ff655cdddd",
      "externalId": null,
      "displayName": "octo-docs-org",
      "members": [
        {
          "value": "92b58aaa-a1d6-11ea-8227-b9ce9e023ccc",
          "$ref": "https://api.github.com/scim/v2/enterprises/octo-corp/Users/92b58aaa-a1d6-11ea-8227-b9ce9e023ccc",
          "display": "octocat@github.com"
        }
      ],
      "meta": {
        "resourceType": "Group",
        "created": "2020-06-09T16:28:01.000+10:00",
        "lastModified": "2020-06-09T16:28:01.000+10:00",
        "location": "https://api.github.com/scim/v2/enterprises/octo-corp/Groups/5e75bbbb-aa1a-11ea-8644-75ff655cdddd"
      }
    }
  ]
}
#>
Function List-ProvisionedSCIMGroupsForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][int]$startIndex,
		[Parameter(Mandatory=$FALSE)][int]$count,
		[Parameter(Mandatory=$FALSE)][string]$filter,
		[Parameter(Mandatory=$FALSE)][string]$excludedAttributes
    )
    $Querys = @()
    $QueryStrings = @(
        "startIndex",
		"count",
		"filter",
		"excludedAttributes"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
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
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
