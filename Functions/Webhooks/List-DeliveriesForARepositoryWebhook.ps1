<#
.SYNOPSIS
Returns a list of webhook deliveries for a webhook configured in a repository.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER hook_id

         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER cursor
Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the link header for the next and previous page cursors.


.LINK
https://docs.github.com/en/rest/reference/webhooks

.OUTPUTS
 [
  {
    "id": 12345678,
    "guid": "0b989ba4-242f-11e5-81e1-c7b6966d2516",
    "delivered_at": "2019-06-03T00:57:16Z",
    "redelivery": false,
    "duration": 0.27,
    "status": "OK",
    "status_code": 200,
    "event": "issues",
    "action": "opened",
    "installation_id": 123,
    "repository_id": 456
  },
  {
    "id": 123456789,
    "guid": "0b989ba4-242f-11e5-81e1-c7b6966d2516",
    "delivered_at": "2019-06-04T00:57:16Z",
    "redelivery": true,
    "duration": 0.28,
    "status": "OK",
    "status_code": 200,
    "event": "issues",
    "action": "opened",
    "installation_id": 123,
    "repository_id": 456
  }
]
#>
Function List-DeliveriesForARepositoryWebhook
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$hook_id,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$cursor
    )
    $Querys = @()
    $QueryStrings = @(
        "per_page",
		"cursor"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks/$hook_id/deliveries?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks/$hook_id/deliveries"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
