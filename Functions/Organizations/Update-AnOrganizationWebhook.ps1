<#
.SYNOPSIS
Updates a webhook configured in an organization. When you update a webhook, the secret will be overwritten. If you previously had a secret set, you must provide the same secret or set a new secret or the secret will be removed. If you are only updating individual webhook config properties, use "Update a webhook configuration for an organization."

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER hook_id

         
.PARAMETER config
Key/value pairs to provide settings for this webhook. These are defined below.
         
.PARAMETER events
Determines what events the hook is triggered for.
Default: push
         
.PARAMETER active
Determines if notifications are sent when the webhook is triggered. Set to true to send notifications.
Default:
         
.PARAMETER name



.LINK
https://docs.github.com/en/rest/reference/orgs
#>
Function Update-AnOrganizationWebhook
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][int]$hook_id,
		[Parameter(Mandatory=$FALSE)][object]$config,
		[Parameter(Mandatory=$FALSE)][string[]]$events,
		[Parameter(Mandatory=$FALSE)][bool]$active,
		[Parameter(Mandatory=$FALSE)][string]$name
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "config",
		"events",
		"active",
		"name" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/hooks/$hook_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/hooks/$hook_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
