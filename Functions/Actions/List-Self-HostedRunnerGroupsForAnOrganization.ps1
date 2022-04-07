<#
.SYNOPSIS
The self-hosted runner groups REST API is available with GitHub Enterprise Cloud. For more information, see "GitHub's products."
Lists all self-hosted runner groups configured in an organization and inherited from an enterprise.
You must authenticate using an access token with the admin:org scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
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
      "runners_url": "https://api.github.com/orgs/octo-org/actions/runner_groups/1/runners",
      "inherited": false,
      "allows_public_repositories": true,
      "restricted_to_workflows": false,
      "selected_workflows": [],
      "workflow_restrictions_read_only": false
    },
    {
      "id": 2,
      "name": "octo-runner-group",
      "visibility": "selected",
      "default": false,
      "selected_repositories_url": "https://api.github.com/orgs/octo-org/actions/runner_groups/2/repositories",
      "runners_url": "https://api.github.com/orgs/octo-org/actions/runner_groups/2/runners",
      "inherited": true,
      "allows_public_repositories": true,
      "restricted_to_workflows": true,
      "selected_workflows": [
        "octo-org/octo-repo/.github/workflows/deploy.yaml@refs/heads/main"
      ],
      "workflow_restrictions_read_only": true
    },
    {
      "id": 3,
      "name": "expensive-hardware",
      "visibility": "private",
      "default": false,
      "runners_url": "https://api.github.com/orgs/octo-org/actions/runner_groups/3/runners",
      "inherited": false,
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
Function List-Self-HostedRunnerGroupsForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
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
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
