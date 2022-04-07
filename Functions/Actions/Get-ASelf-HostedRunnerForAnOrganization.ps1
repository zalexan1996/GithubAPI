<#
.SYNOPSIS
Gets a specific self-hosted runner configured in an organization.
You must authenticate using an access token with the admin:org scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER runner_id
Unique identifier of the self-hosted runner.


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "id": 23,
  "name": "MBP",
  "os": "macos",
  "status": "online",
  "busy": true,
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
Function Get-ASelf-HostedRunnerForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][int]$runner_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runners/$runner_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runners/$runner_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
