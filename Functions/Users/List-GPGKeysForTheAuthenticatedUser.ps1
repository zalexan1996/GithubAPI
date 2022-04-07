<#
.SYNOPSIS
Lists the current user's GPG keys. Requires that you are authenticated via Basic Auth or via OAuth with at least read:gpg_key scope.

        
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
    "id": 3,
    "primary_key_id": 2,
    "key_id": "3262EFF25BA0D270",
    "public_key": "xsBNBFayYZ...",
    "emails": [
      {
        "email": "mastahyeti@users.noreply.github.com",
        "verified": true
      }
    ],
    "subkeys": [
      {
        "id": 4,
        "primary_key_id": 3,
        "key_id": "4A595D4C72EE49C7",
        "public_key": "zsBNBFayYZ...",
        "emails": [],
        "subkeys": [],
        "can_sign": false,
        "can_encrypt_comms": true,
        "can_encrypt_storage": true,
        "can_certify": false,
        "created_at": "2016-03-24T11:31:04-06:00",
        "expires_at": "2016-03-24T11:31:04-07:00"
      }
    ],
    "can_sign": true,
    "can_encrypt_comms": false,
    "can_encrypt_storage": false,
    "can_certify": true,
    "created_at": "2016-03-24T11:31:04-06:00",
    "expires_at": "2016-03-24T11:31:04-07:00",
    "raw_key": "string"
  }
]
#>
Function List-GPGKeysForTheAuthenticatedUser
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
        $FinalURL = "https://api.github.com/user/gpg_keys?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/gpg_keys"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
