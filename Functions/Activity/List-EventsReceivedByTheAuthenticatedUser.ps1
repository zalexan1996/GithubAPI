
<#
.SYNOPSIS
These are events that you've received by watching repos and following users. If you are authenticated as the given user, you will see private events. Otherwise, you'll only see public events.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER username

         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/activity
#>
Function List-EventsReceivedByTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$username,
		[Parameter(Mandatory=$FALSE)][string]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$page
    )
    $QueryStrings = @("per_page=$per_page","page=$page") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/users/$username/received_events?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/users/$username/received_events"
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
