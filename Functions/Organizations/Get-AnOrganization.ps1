<#
.SYNOPSIS
To see many of the organization response values, you need to be an authenticated organization owner with the admin:org scope. When the value of two_factor_requirement_enabled is true, the organization requires all members, billing managers, and outside collaborators to enable two-factor authentication.
GitHub Apps with the Organization plan permission can use this endpoint to retrieve information about an organization's GitHub plan. See "Authenticating with GitHub Apps" for details. For an example response, see 'Response with GitHub plan information' below."

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org



.LINK
https://docs.github.com/en/rest/reference/orgs

.OUTPUTS
 {
  "login": "github",
  "id": 1,
  "node_id": "MDEyOk9yZ2FuaXphdGlvbjE=",
  "url": "https://api.github.com/orgs/github",
  "repos_url": "https://api.github.com/orgs/github/repos",
  "events_url": "https://api.github.com/orgs/github/events",
  "hooks_url": "https://api.github.com/orgs/github/hooks",
  "issues_url": "https://api.github.com/orgs/github/issues",
  "members_url": "https://api.github.com/orgs/github/members{/member}",
  "public_members_url": "https://api.github.com/orgs/github/public_members{/member}",
  "avatar_url": "https://github.com/images/error/octocat_happy.gif",
  "description": "A great organization",
  "name": "github",
  "company": "GitHub",
  "blog": "https://github.com/blog",
  "location": "San Francisco",
  "email": "octocat@github.com",
  "twitter_username": "github",
  "is_verified": true,
  "has_organization_projects": true,
  "has_repository_projects": true,
  "public_repos": 2,
  "public_gists": 1,
  "followers": 20,
  "following": 0,
  "html_url": "https://github.com/octocat",
  "created_at": "2008-01-14T04:33:35Z",
  "updated_at": "2014-03-03T18:58:10Z",
  "type": "Organization",
  "total_private_repos": 100,
  "owned_private_repos": 100,
  "private_gists": 81,
  "disk_usage": 10000,
  "collaborators": 8,
  "billing_email": "mona@github.com",
  "plan": {
    "name": "Medium",
    "space": 400,
    "private_repos": 20,
    "filled_seats": 4,
    "seats": 5
  },
  "default_repository_permission": "read",
  "members_can_create_repositories": true,
  "two_factor_requirement_enabled": true,
  "members_allowed_repository_creation_type": "all",
  "members_can_create_public_repositories": false,
  "members_can_create_private_repositories": false,
  "members_can_create_internal_repositories": false,
  "members_can_create_pages": true,
  "members_can_fork_private_repositories": false
}
#>
Function Get-AnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
