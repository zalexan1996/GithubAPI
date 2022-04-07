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

.OUTPUTS
 {
  "content_type": "json",
  "insecure_ssl": "0",
  "secret": "********",
  "url": "https://example.com/webhook"
}
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
        $FinalURL = "https://api.github.com/app/hook/config?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/app/hook/config"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
