<#
.SYNOPSIS
Gets a specific self-hosted runner group for an enterprise.
You must authenticate using an access token with the manage_runners:enterprise scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER runner_group_id
Unique identifier of the self-hosted runner group.


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "id": 2,
  "name": "octo-runner-group",
  "visibility": "selected",
  "default": false,
  "selected_organizations_url": "https://api.github.com/enterprises/octo-corp/actions/runner-groups/2/organizations",
  "runners_url": "https://api.github.com/enterprises/octo-corp/actions/runner-groups/2/runners",
  "allows_public_repositories": false,
  "restricted_to_workflows": true,
  "selected_workflows": [
    "octo-org/octo-repo/.github/workflows/deploy.yaml@refs/heads/main"
  ],
  "workflow_restrictions_read_only": false
}
#>
Function Get-ASelf-HostedRunnerGroupForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][int]$runner_group_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runner-groups/$runner_group_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runner-groups/$runner_group_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
