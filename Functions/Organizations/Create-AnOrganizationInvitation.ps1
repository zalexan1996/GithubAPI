<#
.SYNOPSIS
Invite people to an organization by using their GitHub user ID or their email address. In order to create invitations in an organization, the authenticated user must be an organization owner.
This endpoint triggers notifications. Creating content too quickly using this endpoint may result in secondary rate limiting. See "Secondary rate limits" and "Dealing with secondary rate limits" for details.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER invitee_id
Required unless you provide email. GitHub user ID for the person you are inviting.
         
.PARAMETER email
Required unless you provide invitee_id. Email address of the person you are inviting, which can be an existing GitHub user.
         
.PARAMETER role
Specify role for new member. Can be one of:
* admin - Organization owners with full administrative rights to the organization and complete access to all repositories and teams.
* direct_member - Non-owner organization members with ability to see other members and join teams by invitation.
* billing_manager - Non-owner organization members with ability to manage the billing settings of your organization.
Default: direct_member
         
.PARAMETER team_ids
Specify IDs for the teams you want to invite new members to.


.LINK
https://docs.github.com/en/rest/reference/orgs

.OUTPUTS
 {
  "id": 1,
  "login": "monalisa",
  "node_id": "MDQ6VXNlcjE=",
  "email": "octocat@github.com",
  "role": "direct_member",
  "created_at": "2016-11-30T06:46:10-08:00",
  "inviter": {
    "login": "other_user",
    "id": 1,
    "node_id": "MDQ6VXNlcjE=",
    "avatar_url": "https://github.com/images/error/other_user_happy.gif",
    "gravatar_id": "",
    "url": "https://api.github.com/users/other_user",
    "html_url": "https://github.com/other_user",
    "followers_url": "https://api.github.com/users/other_user/followers",
    "following_url": "https://api.github.com/users/other_user/following{/other_user}",
    "gists_url": "https://api.github.com/users/other_user/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/other_user/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/other_user/subscriptions",
    "organizations_url": "https://api.github.com/users/other_user/orgs",
    "repos_url": "https://api.github.com/users/other_user/repos",
    "events_url": "https://api.github.com/users/other_user/events{/privacy}",
    "received_events_url": "https://api.github.com/users/other_user/received_events",
    "type": "User",
    "site_admin": false
  },
  "team_count": 2,
  "invitation_teams_url": "https://api.github.com/organizations/2/invitations/1/teams"
}
#>
Function Create-AnOrganizationInvitation
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][int]$invitee_id,
		[Parameter(Mandatory=$FALSE)][string]$email,
		[Parameter(Mandatory=$FALSE)][string]$role,
		[Parameter(Mandatory=$FALSE)][int[]]$team_ids
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "invitee_id",
		"email",
		"role",
		"team_ids" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/invitations?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/invitations"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
