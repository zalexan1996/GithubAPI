
<#
.SYNOPSIS
Marks all notifications as "read" removes it from the default view on GitHub. If the number of notifications is too large to complete in one request, you will receive a 202 Accepted status and GitHub will run an asynchronous process to mark notifications as "read." To check whether any "unread" notifications remain, you can use the List notifications for the authenticated user endpoint and pass the query parameter all=false.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER last_read_at
Describes the last point that notifications were checked.
         
.PARAMETER read
Whether the notification has been read.


.LINK
https://docs.github.com/en/rest/reference/activity
#>
Function Mark-NotificationsAsRead
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$last_read_at,
		[Parameter(Mandatory=$FALSE)][string]$read
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/notifications?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/notifications"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"last_read_at" = "$last_read_at"
	"read" = "$read"
    }

    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

