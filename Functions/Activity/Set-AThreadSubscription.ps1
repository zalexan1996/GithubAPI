<#
.SYNOPSIS
If you are watching a repository, you receive notifications for all threads by default. Use this endpoint to ignore future notifications for threads until you comment on the thread or get an @mention.
You can also use this endpoint to subscribe to threads that you are currently not receiving notifications for or to subscribed to threads that you have previously ignored.
Unsubscribing from a conversation in a repository that you are not watching is functionally equivalent to the Delete a thread subscription endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER thread_id
thread_id parameter
         
.PARAMETER ignored
Whether to block all notifications from a thread.


.LINK
https://docs.github.com/en/rest/reference/activity

.OUTPUTS
 {
  "subscribed": true,
  "ignored": false,
  "reason": null,
  "created_at": "2012-10-06T21:34:12Z",
  "url": "https://api.github.com/notifications/threads/1/subscription",
  "thread_url": "https://api.github.com/notifications/threads/1"
}
#>
Function Set-AThreadSubscription
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$thread_id,
		[Parameter(Mandatory=$FALSE)][bool]$ignored
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "ignored" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/notifications/threads/$thread_id/subscription?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/notifications/threads/$thread_id/subscription"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
