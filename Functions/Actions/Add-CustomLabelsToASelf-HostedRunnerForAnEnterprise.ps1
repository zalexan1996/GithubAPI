<#
.SYNOPSIS
Add custom labels to a self-hosted runner configured in an enterprise.
You must authenticate using an access token with the manage_runners:enterprise scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER runner_id
Unique identifier of the self-hosted runner.
         
.PARAMETER labels
Required. The names of the custom labels to add to the runner.


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Add-CustomLabelsToASelf-HostedRunnerForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][int]$runner_id,
		[Parameter(Mandatory=$FALSE)][string[]]$labels
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "labels" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runners/$runner_id/labels?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runners/$runner_id/labels"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
