
<#
.SYNOPSIS
Remove a custom label from a self-hosted runner configured in an enterprise. Returns the remaining labels from the runner.
This endpoint returns a 404 Not Found status if the custom label is not present on the runner.
You must authenticate using an access token with the manage_runners:enterprise scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER runner_id
Unique identifier of the self-hosted runner.
         
.PARAMETER name
The name of a self-hosted runner's custom label.


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Remove-ACustomLabelFromASelf-HostedRunnerForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string]$runner_id,
		[Parameter(Mandatory=$FALSE)][string]$name
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runners/$runner_id/labels/$name?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runners/$runner_id/labels/$name"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method DELETE -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

