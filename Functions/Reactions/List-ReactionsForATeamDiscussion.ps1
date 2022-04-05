
<#
.SYNOPSIS
List the reactions to a team discussion. OAuth access tokens require the read:discussion scope.
Note: You can also specify a team by org_id and team_id using the route GET /organizations/:org_id/team/:team_id/discussions/:discussion_number/reactions.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER team_slug
team_slug parameter
         
.PARAMETER discussion_number

         
.PARAMETER content
Returns a single reaction type. Omit this parameter to list all reactions to a team discussion.
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/reactions
#>
Function List-ReactionsForATeamDiscussion
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$team_slug,
		[Parameter(Mandatory=$FALSE)][string]$discussion_number,
		[Parameter(Mandatory=$FALSE)][string]$content,
		[Parameter(Mandatory=$FALSE)][string]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$page
    )
    $QueryStrings = @("content=$content","per_page=$per_page","page=$page") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/discussions/$discussion_number/reactions?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/discussions/$discussion_number/reactions"
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
