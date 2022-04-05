
<#
.SYNOPSIS
Marks all notifications in a repository as "read" removes them from the default view on GitHub. If the number of notifications is too large to complete in one request, you will receive a 202 Accepted status and GitHub will run an asynchronous process to mark notifications as "read." To check whether any "unread" notifications remain, you can use the List repository notifications for the authenticated user endpoint and pass the query parameter all=false.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER last_read_at
Describes the last point that notifications were checked. Anything updated since this time will not be marked as read. If you omit this parameter, all notifications are marked as read. This is a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ. Default: The current timestamp.


.LINK
https://docs.github.com/en/rest/reference/activity
#>
Function Mark-RepositoryNotificationsAsRead
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$last_read_at
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/notifications?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/notifications"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"last_read_at" = "$last_read_at"
    }

    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
