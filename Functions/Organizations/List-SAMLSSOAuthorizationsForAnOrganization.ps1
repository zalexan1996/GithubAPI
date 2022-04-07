<#
.SYNOPSIS
Listing and deleting credential authorizations is available to organizations with GitHub Enterprise Cloud. For more information, see GitHub's products.
An authenticated organization owner with the read:org scope can list all credential authorizations for an organization that uses SAML single sign-on (SSO). The credentials are either personal access tokens or SSH keys that organization members have authorized for the organization. For more information, see About authentication with SAML single sign-on.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page token
         
.PARAMETER login
Limits the list of credentials authorizations for an organization to a specific login


.LINK
https://docs.github.com/en/rest/reference/orgs

.OUTPUTS
 [
  {
    "login": "octocat",
    "credential_id": 161195,
    "credential_type": "personal access token",
    "token_last_eight": "71c3fc11",
    "credential_authorized_at": "2011-01-26T19:06:43Z",
    "authorized_credential_expires_at": "2011-02-25T19:06:43Z",
    "scopes": [
      "user",
      "repo"
    ]
  },
  {
    "login": "hubot",
    "credential_id": 161196,
    "credential_type": "personal access token",
    "token_last_eight": "Ae178B4a",
    "credential_authorized_at": "2019-03-29T19:06:43Z",
    "authorized_credential_expires_at": "2019-04-28T19:06:43Z",
    "scopes": [
      "repo"
    ]
  }
]
#>
Function List-SAMLSSOAuthorizationsForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page,
		[Parameter(Mandatory=$FALSE)][string]$login
    )
    $Querys = @()
    $QueryStrings = @(
        "per_page",
		"page",
		"login"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/credential-authorizations?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/credential-authorizations"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
