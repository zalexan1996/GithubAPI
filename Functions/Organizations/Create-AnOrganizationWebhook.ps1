<#
.SYNOPSIS
Here's how you can create a hook that posts payloads in JSON format:

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER name
Required. Must be passed as "web".
         
.PARAMETER config
Required. Key/value pairs to provide settings for this webhook. These are defined below.
         
.PARAMETER events
Determines what events the hook is triggered for.
Default: push
         
.PARAMETER active
Determines if notifications are sent when the webhook is triggered. Set to true to send notifications.
Default:


.LINK
https://docs.github.com/en/rest/reference/orgs

.OUTPUTS
 {
  "id": 1,
  "url": "https://api.github.com/orgs/octocat/hooks/1",
  "ping_url": "https://api.github.com/orgs/octocat/hooks/1/pings",
  "deliveries_url": "https://api.github.com/orgs/octocat/hooks/1/deliveries",
  "name": "web",
  "events": [
    "push",
    "pull_request"
  ],
  "active": true,
  "config": {
    "url": "http://example.com",
    "content_type": "json"
  },
  "updated_at": "2011-09-06T20:39:23Z",
  "created_at": "2011-09-06T17:26:27Z",
  "type": "Organization"
}
#>
Function Create-AnOrganizationWebhook
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
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
        $FinalURL = "https://api.github.com/orgs/$org/hooks?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/hooks"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
