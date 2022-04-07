<#
.SYNOPSIS
View extended details for a single GPG key. Requires that you are authenticated via Basic Auth or via OAuth with at least read:gpg_key scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER gpg_key_id
gpg_key_id parameter


.LINK
https://docs.github.com/en/rest/reference/users

.OUTPUTS
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
  "raw_key": "\"-----BEGIN PGP PUBLIC KEY BLOCK-----\\nVersion: GnuPG v2\\n\\n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\\nIts/HFYRLiFgDLmTlxo=\\n=+OzK\\n-----END PGP PUBLIC KEY BLOCK-----\""
}
#>
Function Get-AGPGKeyForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$gpg_key_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/user/gpg_keys/$gpg_key_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/gpg_keys/$gpg_key_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
