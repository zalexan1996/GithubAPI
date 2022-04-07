<#
.SYNOPSIS
List files larger than 100MB found during the import

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo



.LINK
https://docs.github.com/en/rest/reference/migrations

.OUTPUTS
 [
  {
    "ref_name": "refs/heads/master",
    "path": "foo/bar/1",
    "oid": "d3d9446802a44259755d38e6d163e820",
    "size": 10485760
  },
  {
    "ref_name": "refs/heads/master",
    "path": "foo/bar/2",
    "oid": "6512bd43d9caa6e02c990b0a82652dca",
    "size": 11534336
  },
  {
    "ref_name": "refs/heads/master",
    "path": "foo/bar/3",
    "oid": "c20ad4d76fe97759aa27a0c99bff6710",
    "size": 12582912
  }
]
#>
Function Get-LargeFiles
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import/large_files?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import/large_files"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
