<#
.SYNOPSIS
GitHub provides several timeline resources in Atom format. The Feeds API lists all the feeds available to the authenticated user:
Timeline: The GitHub global public timeline
User: The public timeline for any user, using URI template
Current user public: The public timeline for the authenticated user
Current user: The private timeline for the authenticated user
Current user actor: The private timeline for activity created by the authenticated user
Current user organizations: The private timeline for the organizations the authenticated user is a member of.
Security advisories: A collection of public announcements that provide information about security-related vulnerabilities in software on GitHub.
Note: Private feeds are only returned when authenticating via Basic Auth since current feed URIs use the older, non revocable auth tokens.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.


.LINK
https://docs.github.com/en/rest/reference/activity

.OUTPUTS
 {
  "timeline_url": "https://github.com/timeline",
  "user_url": "https://github.com/{user}",
  "current_user_public_url": "https://github.com/octocat",
  "current_user_url": "https://github.com/octocat.private?token=abc123",
  "current_user_actor_url": "https://github.com/octocat.private.actor?token=abc123",
  "current_user_organization_url": "",
  "current_user_organization_urls": [
    "https://github.com/organizations/github/octocat.private.atom?token=abc123"
  ],
  "security_advisories_url": "https://github.com/security-advisories",
  "_links": {
    "timeline": {
      "href": "https://github.com/timeline",
      "type": "application/atom+xml"
    },
    "user": {
      "href": "https://github.com/{user}",
      "type": "application/atom+xml"
    },
    "current_user_public": {
      "href": "https://github.com/octocat",
      "type": "application/atom+xml"
    },
    "current_user": {
      "href": "https://github.com/octocat.private?token=abc123",
      "type": "application/atom+xml"
    },
    "current_user_actor": {
      "href": "https://github.com/octocat.private.actor?token=abc123",
      "type": "application/atom+xml"
    },
    "current_user_organization": {
      "href": "",
      "type": ""
    },
    "current_user_organizations": [
      {
        "href": "https://github.com/organizations/github/octocat.private.atom?token=abc123",
        "type": "application/atom+xml"
      }
    ],
    "security_advisories": {
      "href": "https://github.com/security-advisories",
      "type": "application/atom+xml"
    }
  }
}
#>
Function Get-Feeds
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/feeds?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/feeds"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
