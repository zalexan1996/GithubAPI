<#
.SYNOPSIS
List the machine types available for a given repository based on its configuration.
You must authenticate using an access token with the codespace scope to use this endpoint.
GitHub Apps must have write access to the codespaces_metadata repository permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER location
The location to check for available machines. Assigned by IP if not provided.


.LINK
https://docs.github.com/en/rest/reference/codespaces

.OUTPUTS
 {
  "total_count": 2,
  "machines": [
    {
      "name": "standardLinux",
      "display_name": "4 cores, 8 GB RAM, 64 GB storage",
      "operating_system": "linux",
      "storage_in_bytes": 68719476736,
      "memory_in_bytes": 8589934592,
      "cpus": 4
    },
    {
      "name": "premiumLinux",
      "display_name": "8 cores, 16 GB RAM, 64 GB storage",
      "operating_system": "linux",
      "storage_in_bytes": 68719476736,
      "memory_in_bytes": 17179869184,
      "cpus": 8
    }
  ]
}
#>
Function List-AvailableMachineTypesForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$location
    )
    $Querys = @()
    $QueryStrings = @(
        "location"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/codespaces/machines?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/codespaces/machines"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
