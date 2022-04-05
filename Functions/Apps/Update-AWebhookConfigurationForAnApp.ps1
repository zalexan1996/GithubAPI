
<#
.SYNOPSIS
Updates the webhook configuration for a GitHub App. For more information about configuring a webhook for your app, see "Creating a GitHub App."
You must use a JWT to access this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER url
The URL to which the payloads will be delivered.
         
.PARAMETER content_type
The media type used to serialize the payloads. Supported values include json and form. The default is form.
         
.PARAMETER secret
If provided, the secret will be used as the key to generate the HMAC hex digest value for delivery signature headers.
         
.PARAMETER insecure_ssl
Determines whether the SSL certificate of the host for url will be verified when delivering payloads. Supported values include 0 (verification is performed) and 1 (verification is not performed). The default is 0. We strongly recommend not setting this to 1 as you are subject to man-in-the-middle and other attacks.


.LINK
https://docs.github.com/en/rest/reference/apps
#>
Function Update-AWebhookConfigurationForAnApp
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$url,
		[Parameter(Mandatory=$FALSE)][string]$content_type,
		[Parameter(Mandatory=$FALSE)][string]$secret,
		[Parameter(Mandatory=$FALSE)][string]$insecure_ssl
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/app/hook/config?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/app/hook/config"
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

