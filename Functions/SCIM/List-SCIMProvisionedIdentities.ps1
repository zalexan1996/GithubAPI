
<#
.SYNOPSIS
Retrieves a paginated list of all provisioned organization members, including pending invitations. If you provide the filter parameter, the resources for all matching provisions members are returned.
When a user with a SAML-provisioned external identity leaves (or is removed from) an organization, the account's metadata is immediately removed. However, the returned list of user accounts might not always match the organization or enterprise member list you see on GitHub. This can happen in certain cases where an external identity associated with an organization will not match an organization member:
When a user with a SCIM-provisioned external identity is removed from an organization, the account's metadata is preserved to allow the user to re-join the organization in the future.
When inviting a user to join an organization, you can expect to see their external identity in the results before they accept the invitation, or if the invitation is cancelled (or never accepted).
When a user is invited over SCIM, an external identity is created that matches with the invitee's email address. However, this identity is only linked to a user account when the user accepts the invitation by going through SAML SSO.
The returned list of external identities can include an entry for a null user. These are unlinked SAML identities that are created when a user goes through the following Single Sign-On (SSO) process but does not sign in to their GitHub account after completing SSO:
The user is granted access by the IdP and is not a member of the GitHub organization.
The user attempts to access the GitHub organization and initiates the SAML SSO process, and is not currently signed in to their GitHub account.
After successfully authenticating with the SAML SSO IdP, the null external identity entry is created and the user is prompted to sign in to their GitHub account:
If the user signs in, their GitHub account is linked to this entry.
If the user does not sign in (or does not create a new account when prompted), they are not added to the GitHub organization, and the external identity null entry remains in place.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER startIndex
Used for pagination: the index of the first result to return.
         
.PARAMETER count
Used for pagination: the number of results to return.
         
.PARAMETER filter
Filters results using the equals query parameter operator (eq). You can filter results that are equal to id, userName, emails, and external_id. For example, to search for an identity with the userName Octocat, you would use this query:
?filter=userName%20eq%20\"Octocat\".
To filter results for the identity with the email octocat@github.com, you would use this query:
?filter=emails%20eq%20\"octocat@github.com\".


.LINK
https://docs.github.com/en/rest/reference/scim
#>
Function List-SCIMProvisionedIdentities
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$startIndex,
		[Parameter(Mandatory=$FALSE)][string]$count,
		[Parameter(Mandatory=$FALSE)][string]$filter
    )
    $QueryStrings = @("startIndex=$startIndex","count=$count","filter=$filter") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/scim/v2/organizations/$org/Users?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/scim/v2/organizations/$org/Users"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

