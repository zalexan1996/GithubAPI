<#
.SYNOPSIS
Remove all previous custom labels and set the new custom labels for a specific self-hosted runner configured in an enterprise.
You must authenticate using an access token with the manage_runners:enterprise scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER runner_id
Unique identifier of the self-hosted runner.
         
.PARAMETER labels
Required. The names of the custom labels to set for the runner. You can pass an empty array to remove all custom labels.


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "total_count": 4,
  "labels": [
    {
      "id": 5,
      "name": "self-hosted",
      "type": "read-only"
    },
    {
      "id": 7,
      "name": "X64",
      "type": "read-only"
    },
    {
      "id": 20,
      "name": "macOS",
      "type": "read-only"
    },
    {
      "id": 21,
      "name": "no-gpu",
      "type": "custom"
    }
  ]
}
#>
Function Set-CustomLabelsForASelf-HostedRunnerForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][int]$runner_id,
		[Parameter(Mandatory=$FALSE)][string[]]$labels
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "labels" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runners/$runner_id/labels?$($Querys -join '&')"
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
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
