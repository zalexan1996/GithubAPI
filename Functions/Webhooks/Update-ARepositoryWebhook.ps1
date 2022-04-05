
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
         
.PARAMETER Properties of theconfigobject

         
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
#>
Function Update-ARepositoryWebhook
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$hook_id,
		[Parameter(Mandatory=$FALSE)][string]$config,
		[Parameter(Mandatory=$FALSE)][string]$Properties of theconfigobject,
		[Parameter(Mandatory=$FALSE)][string]$events,
		[Parameter(Mandatory=$FALSE)][string]$add_events,
		[Parameter(Mandatory=$FALSE)][string]$remove_events,
		[Parameter(Mandatory=$FALSE)][string]$active
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks/$hook_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks/$hook_id"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"config" = "$config"
	"events" = "$events"
	"add_events" = "$add_events"
	"remove_events" = "$remove_events"
	"active" = "$active"
    }

    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

