<#
.SYNOPSIS
The self-hosted runner groups REST API is available with GitHub Enterprise Cloud. For more information, see "GitHub's products."
Gets a specific self-hosted runner group for an organization.
You must authenticate using an access token with the admin:org scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
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
  "selected_repositories_url": "https://api.github.com/orgs/octo-org/actions/runner_groups/2/repositories",
  "runners_url": "https://api.github.com/orgs/octo-org/actions/runner_groups/2/runners",
  "inherited": false,
  "allows_public_repositories": true,
  "restricted_to_workflows": true,
  "selected_workflows": [
    "octo-org/octo-repo/.github/workflows/deploy.yaml@refs/heads/main"
  ],
  "workflow_restrictions_read_only": false
}
#>
Function Get-ASelf-HostedRunnerGroupForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
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
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups/$runner_group_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups/$runner_group_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
