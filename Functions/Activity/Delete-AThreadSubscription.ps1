<#
.SYNOPSIS
Mutes all future notifications for a conversation until you comment on the thread or get an @mention. If you are watching the repository of the thread, you will still receive notifications. To ignore future notifications for a repository you are watching, use the Set a thread subscription endpoint and set ignore to true.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER thread_id
thread_id parameter


.LINK
https://docs.github.com/en/rest/reference/activity
#>
Function Delete-AThreadSubscription
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$thread_id
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/notifications/threads/$thread_id/subscription?$($QueryStrings -join '&')"
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
    $Output = Invoke-RestMethod -Method DELETE -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
