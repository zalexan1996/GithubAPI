
<#
.SYNOPSIS
Updates the webhook configuration for a repository. To update more information about the webhook, including the active state and events, use "Update a repository webhook."
Access tokens must have the write:repo_hook or repo scope, and GitHub Apps must have the repository_hooks:write permission.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER hook_id

         
.PARAMETER url
The URL to which the payloads will be delivered.
         
.PARAMETER content_type
The media type used to serialize the payloads. Supported values include json and form. The default is form.
         
.PARAMETER secret
If provided, the secret will be used as the key to generate the HMAC hex digest value for delivery signature headers.
         
.PARAMETER insecure_ssl
Determines whether the SSL certificate of the host for url will be verified when delivering payloads. Supported values include 0 (verification is performed) and 1 (verification is not performed). The default is 0. We strongly recommend not setting this to 1 as you are subject to man-in-the-middle and other attacks.


.LINK
https://docs.github.com/en/rest/reference/webhooks
#>
Function Update-AWebhookConfigurationForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$hook_id,
		[Parameter(Mandatory=$FALSE)][string]$url,
		[Parameter(Mandatory=$FALSE)][string]$content_type,
		[Parameter(Mandatory=$FALSE)][string]$secret,
		[Parameter(Mandatory=$FALSE)][string]$insecure_ssl
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks/$hook_id/config?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks/$hook_id/config"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"url" = "$url"
	"content_type" = "$content_type"
	"secret" = "$secret"
	"insecure_ssl" = "$insecure_ssl"
    }

    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

