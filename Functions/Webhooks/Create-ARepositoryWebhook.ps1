<#
.SYNOPSIS
Repositories can have multiple webhooks installed. Each webhook should have a unique config. Multiple webhooks can share the same config as long as those webhooks do not have any events that overlap.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER name
Use web to create a webhook. Default: web. This parameter only accepts the value web.
         
.PARAMETER config
Key/value pairs to provide settings for this webhook. These are defined below.
         
.PARAMETER events
Determines what events the hook is triggered for.
Default: push
         
.PARAMETER active
Determines if notifications are sent when the webhook is triggered. Set to true to send notifications.
Default:


.LINK
https://docs.github.com/en/rest/reference/webhooks

.OUTPUTS
 {
  "type": "Repository",
  "id": 12345678,
  "name": "web",
  "active": true,
  "events": [
    "push",
    "pull_request"
  ],
  "config": {
    "content_type": "json",
    "insecure_ssl": "0",
    "url": "https://example.com/webhook"
  },
  "updated_at": "2019-06-03T00:57:16Z",
  "created_at": "2019-06-03T00:57:16Z",
  "url": "https://api.github.com/repos/octocat/Hello-World/hooks/12345678",
  "test_url": "https://api.github.com/repos/octocat/Hello-World/hooks/12345678/test",
  "ping_url": "https://api.github.com/repos/octocat/Hello-World/hooks/12345678/pings",
  "deliveries_url": "https://api.github.com/repos/octocat/Hello-World/hooks/12345678/deliveries",
  "last_response": {
    "code": null,
    "status": "unused",
    "message": null
  }
}
#>
Function Create-ARepositoryWebhook
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][object]$config,
		[Parameter(Mandatory=$FALSE)][string[]]$events,
		[Parameter(Mandatory=$FALSE)][bool]$active
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "name",
		"config",
		"events",
		"active" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
