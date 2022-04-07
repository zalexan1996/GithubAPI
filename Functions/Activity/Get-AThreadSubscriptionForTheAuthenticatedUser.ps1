<#
.SYNOPSIS
This checks to see if the current user is subscribed to a thread. You can also get a repository subscription.
Note that subscriptions are only generated if a user is participating in a conversation--for example, they've replied to the thread, were @mentioned, or manually subscribe to a thread.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER thread_id
thread_id parameter


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
Function Get-AThreadSubscriptionForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$thread_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
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
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
