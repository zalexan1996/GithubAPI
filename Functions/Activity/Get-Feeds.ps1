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
#>
Function Get-Feeds
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/feeds?$($QueryStrings -join '&')"
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
