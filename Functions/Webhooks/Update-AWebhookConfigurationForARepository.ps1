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

.OUTPUTS
 {
  "content_type": "json",
  "insecure_ssl": "0",
  "secret": "********",
  "url": "https://example.com/webhook"
}
#>
Function Update-AWebhookConfigurationForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$hook_id,
		[Parameter(Mandatory=$FALSE)][string]$url,
		[Parameter(Mandatory=$FALSE)][string]$content_type,
		[Parameter(Mandatory=$FALSE)][string]$secret,
		[Parameter(Mandatory=$FALSE)][string]$insecure_ssl
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "url",
		"content_type",
		"secret",
		"insecure_ssl" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks/$hook_id/config?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks/$hook_id/config"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
