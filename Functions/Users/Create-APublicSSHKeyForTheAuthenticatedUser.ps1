<#
.SYNOPSIS
Adds a public SSH key to the authenticated user's GitHub account. Requires that you are authenticated via Basic Auth, or OAuth with at least write:public_key scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER title
A descriptive name for the new key.
         
.PARAMETER key
Required. The public SSH key to add to your GitHub account.


.LINK
https://docs.github.com/en/rest/reference/users

.OUTPUTS
 {
  "key": "2Sg8iYjAxxmI2LvUXpJjkYrMxURPc8r+dB7TJyvv1234",
  "id": 2,
  "url": "https://api.github.com/user/keys/2",
  "title": "ssh-rsa AAAAB3NzaC1yc2EAAA",
  "created_at": "2020-06-11T21:31:57Z",
  "verified": false,
  "read_only": false
}
#>
Function Create-APublicSSHKeyForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$title,
		[Parameter(Mandatory=$FALSE)][string]$key
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "title",
		"key" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/user/keys?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/keys"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
