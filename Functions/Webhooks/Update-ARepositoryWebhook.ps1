<#
.SYNOPSIS
Updates a webhook configured in a repository. If you previously had a secret set, you must provide the same secret or set a new secret or the secret will be removed. If you are only updating individual webhook config properties, use "Update a webhook configuration for a repository."

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER hook_id

         
.PARAMETER config
Key/value pairs to provide settings for this webhook. These are defined below.
         
.PARAMETER events
Determines what events the hook is triggered for. This replaces the entire array of events.
Default: push
         
.PARAMETER add_events
Determines a list of events to be added to the list of events that the Hook triggers for.
         
.PARAMETER remove_events
Determines a list of events to be removed from the list of events that the Hook triggers for.
         
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
Function Update-ARepositoryWebhook
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$hook_id,
		[Parameter(Mandatory=$FALSE)][object]$config,
		[Parameter(Mandatory=$FALSE)][string[]]$events,
		[Parameter(Mandatory=$FALSE)][string[]]$add_events,
		[Parameter(Mandatory=$FALSE)][string[]]$remove_events,
		[Parameter(Mandatory=$FALSE)][bool]$active
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "config",
		"events",
		"add_events",
		"remove_events",
		"active" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks/$hook_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks/$hook_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
