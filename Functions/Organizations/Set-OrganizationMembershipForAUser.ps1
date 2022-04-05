
<#
.SYNOPSIS
Only authenticated organization owners can add a member to the organization or update the member's role.
If the authenticated user is adding a member to the organization, the invited user will receive an email inviting them to the organization. The user's membership status will be pending until they accept the invitation.
Authenticated users can update a user's membership by passing the role parameter. If the authenticated user changes a member's role to admin, the affected user will receive an email notifying them that they've been made an organization owner. If the authenticated user changes an owner's role to member, no email will be sent.
Rate limits
To prevent abuse, the authenticated user is limited to 50 organization invitations per 24 hour period. If the organization is more than one month old or on a paid plan, the limit is 500 invitations per 24 hour period.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER username

         
.PARAMETER role
The role to give the user in the organization. Can be one of:
* admin - The user will become an owner of the organization.
* member - The user will become a non-owner member of the organization.
Default: member


.LINK
https://docs.github.com/en/rest/reference/orgs
#>
Function Set-OrganizationMembershipForAUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$username,
		[Parameter(Mandatory=$FALSE)][string]$role
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/memberships/$username?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/memberships/$username"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"role" = "$role"
    }

    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

