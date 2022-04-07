<#
.SYNOPSIS
Lists all self-hosted runner groups for an enterprise.
You must authenticate using an access token with the manage_runners:enterprise scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "total_count": 3,
  "runner_groups": [
    {
      "id": 1,
      "name": "Default",
      "visibility": "all",
      "default": true,
      "runners_url": "https://api.github.com/enterprises/octo-corp/actions/runner_groups/1/runners",
      "allows_public_repositories": false,
      "restricted_to_workflows": false,
      "selected_workflows": [],
      "workflow_restrictions_read_only": false
    },
    {
      "id": 2,
      "name": "octo-runner-group",
      "visibility": "selected",
      "default": false,
      "selected_organizations_url": "https://api.github.com/enterprises/octo-corp/actions/runner_groups/2/organizations",
      "runners_url": "https://api.github.com/enterprises/octo-corp/actions/runner_groups/2/runners",
      "allows_public_repositories": true,
      "restricted_to_workflows": true,
      "selected_workflows": [
        "octo-org/octo-repo/.github/workflows/deploy.yaml@refs/heads/main"
      ],
      "workflow_restrictions_read_only": false
    },
    {
      "id": 3,
      "name": "expensive-hardware",
      "visibility": "private",
      "default": false,
      "runners_url": "https://api.github.com/enterprises/octo-corp/actions/runner_groups/3/runners",
      "allows_public_repositories": true,
      "restricted_to_workflows": false,
      "selected_workflows": [
        "octo-org/octo-repo/.github/workflows/deploy.yaml@refs/heads/main"
      ],
      "workflow_restrictions_read_only": false
    }
  ]
}
#>
Function List-Self-HostedRunnerGroupsForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $Querys = @()
    $QueryStrings = @(
        "per_page",
		"page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runner-groups?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runner-groups"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
