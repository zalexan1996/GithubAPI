
<#
.SYNOPSIS
Create a reaction to a team discussion comment. OAuth access tokens require the write:discussion scope. A response with an HTTP 200 status means that you already added the reaction type to this team discussion comment.
Note: You can also specify a team by org_id and team_id using the route POST /organizations/:org_id/team/:team_id/discussions/:discussion_number/comments/:comment_number/reactions.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER team_slug
team_slug parameter
         
.PARAMETER discussion_number

         
.PARAMETER comment_number

         
.PARAMETER content
Required. The reaction type to add to the team discussion comment.


.LINK
https://docs.github.com/en/rest/reference/reactions
#>
Function Create-ReactionForATeamDiscussionComment
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$team_slug,
		[Parameter(Mandatory=$FALSE)][string]$discussion_number,
		[Parameter(Mandatory=$FALSE)][string]$comment_number,
		[Parameter(Mandatory=$FALSE)][string]$content
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/discussions/$discussion_number/comments/$comment_number/reactions?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/teams/$team_slug/discussions/$discussion_number/comments/$comment_number/reactions"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"content" = "$content"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
