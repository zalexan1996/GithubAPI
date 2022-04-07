<#
.SYNOPSIS
Note: The SCIM API endpoints for enterprise accounts are currently in beta and are subject to change.
Retrieves a paginated list of all provisioned enterprise members, including pending invitations.
When a user with a SAML-provisioned external identity leaves (or is removed from) an enterprise, the account's metadata is immediately removed. However, the returned list of user accounts might not always match the organization or enterprise member list you see on GitHub. This can happen in certain cases where an external identity associated with an organization will not match an organization member:
When a user with a SCIM-provisioned external identity is removed from an enterprise, the account's metadata is preserved to allow the user to re-join the organization in the future.
When inviting a user to join an organization, you can expect to see their external identity in the results before they accept the invitation, or if the invitation is cancelled (or never accepted).
When a user is invited over SCIM, an external identity is created that matches with the invitee's email address. However, this identity is only linked to a user account when the user accepts the invitation by going through SAML SSO.
The returned list of external identities can include an entry for a null user. These are unlinked SAML identities that are created when a user goes through the following Single Sign-On (SSO) process but does not sign in to their GitHub account after completing SSO:
The user is granted access by the IdP and is not a member of the GitHub enterprise.
The user attempts to access the GitHub enterprise and initiates the SAML SSO process, and is not currently signed in to their GitHub account.
After successfully authenticating with the SAML SSO IdP, the null external identity entry is created and the user is prompted to sign in to their GitHub account:
If the user signs in, their GitHub account is linked to this entry.
If the user does not sign in (or does not create a new account when prompted), they are not added to the GitHub enterprise, and the external identity null entry remains in place.

        
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
        "urn:ietf:params:scim:schemas:core:2.0:User"
      ],
      "id": "92b58aaa-a1d6-11ea-8227-b9ce9e023ccc",
      "externalId": "00dowz5dr9oSfDFRA0h7",
      "userName": "octocat@github.com",
      "name": {
        "givenName": "Mona",
        "familyName": "Octocat"
      },
      "emails": [
        {
          "value": "octocat@github.com",
          "primary": true,
          "type": "work"
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
        "created": "2020-05-30T04:02:34.000+10:00",
        "lastModified": "2020-05-30T04:05:04.000+10:00",
        "location": "https://api.github.com/scim/v2/enterprises/octo-corp/Users/92b58aaa-a1d6-11ea-8227-b9ce9e023ccc"
      }
    },
    {
      "schemas": [
        "urn:ietf:params:scim:schemas:core:2.0:User"
      ],
      "id": "e18b8c34-a6b2-11ea-9d70-54abbd1c8fd5",
      "externalId": "sdfoiausdofiua",
      "userName": "hubot@example.com",
      "name": {
        "givenName": "hu",
        "familyName": "bot"
      },
      "emails": [
        {
          "value": "hubot@example.com",
          "type": "work",
          "primary": true
        }
      ],
      "groups": [],
      "active": true,
      "meta": {
        "resourceType": "User",
        "created": "2020-06-05T08:29:40.000+10:00",
        "lastModified": "2020-06-05T08:30:19.000+10:00",
        "location": "https://api.github.com/scim/v2/enterprises/octo-corp/Users/e18b8c34-a6b2-11ea-9d70-54abbd1c8fd5"
      }
    }
  ]
}
#>
Function List-SCIMProvisionedIdentitiesForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][int]$startIndex,
		[Parameter(Mandatory=$FALSE)][int]$count,
		[Parameter(Mandatory=$FALSE)][string]$filter
    )
    $Querys = @()
    $QueryStrings = @(
        "startIndex",
		"count",
		"filter"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
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
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
