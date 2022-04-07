<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER featured

         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/licenses

.OUTPUTS
 [
  {
    "key": "mit",
    "name": "MIT License",
    "spdx_id": "MIT",
    "url": "https://api.github.com/licenses/mit",
    "node_id": "MDc6TGljZW5zZW1pdA=="
  },
  {
    "key": "lgpl-3.0",
    "name": "GNU Lesser General Public License v3.0",
    "spdx_id": "LGPL-3.0",
    "url": "https://api.github.com/licenses/lgpl-3.0",
    "node_id": "MDc6TGljZW5zZW1pdA=="
  },
  {
    "key": "mpl-2.0",
    "name": "Mozilla Public License 2.0",
    "spdx_id": "MPL-2.0",
    "url": "https://api.github.com/licenses/mpl-2.0",
    "node_id": "MDc6TGljZW5zZW1pdA=="
  },
  {
    "key": "agpl-3.0",
    "name": "GNU Affero General Public License v3.0",
    "spdx_id": "AGPL-3.0",
    "url": "https://api.github.com/licenses/agpl-3.0",
    "node_id": "MDc6TGljZW5zZW1pdA=="
  },
  {
    "key": "unlicense",
    "name": "The Unlicense",
    "spdx_id": "Unlicense",
    "url": "https://api.github.com/licenses/unlicense",
    "node_id": "MDc6TGljZW5zZW1pdA=="
  },
  {
    "key": "apache-2.0",
    "name": "Apache License 2.0",
    "spdx_id": "Apache-2.0",
    "url": "https://api.github.com/licenses/apache-2.0",
    "node_id": "MDc6TGljZW5zZW1pdA=="
  },
  {
    "key": "gpl-3.0",
    "name": "GNU General Public License v3.0",
    "spdx_id": "GPL-3.0",
    "url": "https://api.github.com/licenses/gpl-3.0",
    "node_id": "MDc6TGljZW5zZW1pdA=="
  }
]
#>
Function Get-AllCommonlyUsedLicenses
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][bool]$featured,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $Querys = @()
    $QueryStrings = @(
        "featured",
		"per_page",
		"page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/licenses?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/licenses"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
