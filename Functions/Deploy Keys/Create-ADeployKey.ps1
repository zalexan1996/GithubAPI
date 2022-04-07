<#
.SYNOPSIS
You can create a read-only deploy key.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER title
A name for the key.
         
.PARAMETER key
Required. The contents of the key.
         
.PARAMETER read_only
If true, the key will only be able to read repository contents. Otherwise, the key will be able to read and write.
Deploy keys with write access can perform the same actions as an organization member with admin access, or a collaborator on a personal repository. For more information, see "Repository permission levels for an organization" and "Permission levels for a user account repository."


.LINK
https://docs.github.com/en/rest/reference/deploy_keys

.OUTPUTS
 {
  "id": 1,
  "key": "ssh-rsa AAA...",
  "url": "https://api.github.com/repos/octocat/Hello-World/keys/1",
  "title": "octocat@octomac",
  "verified": true,
  "created_at": "2014-12-10T15:53:42Z",
  "read_only": true
}
#>
Function Create-ADeployKey
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$title,
		[Parameter(Mandatory=$FALSE)][string]$key,
		[Parameter(Mandatory=$FALSE)][bool]$read_only
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "title",
		"key",
		"read_only" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/keys?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/keys"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
