
<#
.SYNOPSIS
Returns a delivery for a webhook configured in an organization.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER hook_id

         
.PARAMETER delivery_id



.LINK
https://docs.github.com/en/rest/reference/orgs
#>
Function Get-AWebhookDeliveryForAnOrganizationWebhook
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$hook_id,
		[Parameter(Mandatory=$FALSE)][string]$delivery_id
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/hooks/$hook_id/deliveries/$delivery_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/hooks/$hook_id/deliveries/$delivery_id"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
