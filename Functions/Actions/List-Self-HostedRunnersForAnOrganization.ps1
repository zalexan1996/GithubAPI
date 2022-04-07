<#
.SYNOPSIS
Lists all self-hosted runners configured in an organization.
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
  "total_count": 2,
  "runners": [
    {
      "id": 23,
      "name": "linux_runner",
      "os": "linux",
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
          "id": 11,
          "name": "Linux",
          "type": "read-only"
        }
      ]
    },
    {
      "id": 24,
      "name": "mac_runner",
      "os": "macos",
      "status": "offline",
      "busy": false,
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
  ]
}
#>
Function List-Self-HostedRunnersForAnOrganization
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
        $FinalURL = "https://api.github.com/orgs/$org/actions/runners?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runners"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
