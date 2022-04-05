
<#
.SYNOPSIS
This endpoint triggers notifications. Creating content too quickly using this endpoint may result in secondary rate limiting. See "Secondary rate limits" and "Dealing with secondary rate limits" for details.
Pull request reviews created in the PENDING state do not include the submitted_at property in the response.
Note: To comment on a specific line in a file, you need to first determine the position of that line in the diff. The GitHub REST API v3 offers the application/vnd.github.v3.diff media type. To see a pull request diff, add this media type to the Accept header of a call to the single pull request endpoint.
The position value equals the number of lines down from the first "@@" hunk header in the file you want to add a comment. The line just below the "@@" line is position 1, the next line is position 2, and so on. The position in the diff continues to increase through lines of whitespace and additional hunks until the beginning of a new file.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER pull_number

         
.PARAMETER commit_id
The SHA of the commit that needs a review. Not using the latest commit SHA may render your review comment outdated if a subsequent commit modifies the line you specify as the position. Defaults to the most recent commit in the pull request when you do not specify a value.
         
.PARAMETER body
Required when using REQUEST_CHANGES or COMMENT for the event parameter. The body text of the pull request review.
         
.PARAMETER event
The review action you want to perform. The review actions include: APPROVE, REQUEST_CHANGES, or COMMENT. By leaving this blank, you set the review action state to PENDING, which means you will need to submit the pull request review when you are ready.
         
.PARAMETER comments
Use the following table to specify the location, destination, and contents of the draft review comment.
         
.PARAMETER Properties of thecommentsitems



.LINK
https://docs.github.com/en/rest/reference/pulls
#>
Function Create-AReviewForAPullRequest
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$pull_number,
		[Parameter(Mandatory=$FALSE)][string]$commit_id,
		[Parameter(Mandatory=$FALSE)][string]$body,
		[Parameter(Mandatory=$FALSE)][string]$event,
		[Parameter(Mandatory=$FALSE)][string]$comments,
		[Parameter(Mandatory=$FALSE)][string]$Properties of thecommentsitems
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/$pull_number/reviews?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/$pull_number/reviews"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"commit_id" = "$commit_id"
	"body" = "$body"
	"event" = "$event"
	"comments" = "$comments"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

