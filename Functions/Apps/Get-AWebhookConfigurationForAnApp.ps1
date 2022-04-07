<#
.SYNOPSIS
Returns the webhook configuration for a GitHub App. For more information about configuring a webhook for your app, see "Creating a GitHub App."
You must use a JWT to access this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.


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
Function Get-AWebhookConfigurationForAnApp
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
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
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
