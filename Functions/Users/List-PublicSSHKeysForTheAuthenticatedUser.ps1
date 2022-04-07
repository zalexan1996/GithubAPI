<#
.SYNOPSIS
Lists the public SSH keys for the authenticated user's GitHub account. Requires that you are authenticated via Basic Auth or via OAuth with at least read:public_key scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/users

.OUTPUTS
 [
  {
    "key": "2Sg8iYjAxxmI2LvUXpJjkYrMxURPc8r+dB7TJyvv1234",
    "id": 2,
    "url": "https://api.github.com/user/keys/2",
    "title": "ssh-rsa AAAAB3NzaC1yc2EAAA",
    "created_at": "2020-06-11T21:31:57Z",
    "verified": false,
    "read_only": false
  },
  {
    "key": "2Sg8iYjAxxmI2LvUXpJjkYrMxURPc8r+dB7TJy931234",
    "id": 3,
    "url": "https://api.github.com/user/keys/3",
    "title": "ssh-rsa AAAAB3NzaC1yc2EAAB",
    "created_at": "2020-07-11T21:31:57Z",
    "verified": false,
    "read_only": false
  }
]
#>
Function List-PublicSSHKeysForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
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
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
