<#
.SYNOPSIS
Signature verification object
The response will include a verification object that describes the result of verifying the commit's signature. The following fields are included in the verification object:
Name Type Description
verified boolean Indicates whether GitHub considers the signature in this commit to be verified.
reason string The reason for verified value. Possible values and their meanings are enumerated in table below.
signature string The signature that was extracted from the commit.
payload string The value that was signed.
These are the possible values for reason in the verification object:
Value Description
expired_key The key that made the signature is expired.
not_signing_key The "signing" flag is not among the usage flags in the GPG key that made the signature.
gpgverify_error There was an error communicating with the signature verification service.
gpgverify_unavailable The signature verification service is currently unavailable.
unsigned The object does not include a signature.
unknown_signature_type A non-PGP signature was found in the commit.
no_user No user was associated with the committer email address in the commit.
unverified_email The committer email address in the commit was associated with a user, but the email address is not verified on her/his account.
bad_email The committer email address in the commit is not included in the identities of the PGP key that made the signature.
unknown_key The key that made the signature has not been registered with any user's account.
malformed_signature There was an error parsing the signature.
invalid The signature could not be cryptographically verified using the key whose key-id was found in the signature.
valid None of the above errors applied, so the signature is considered to be verified.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER tag_sha



.LINK
https://docs.github.com/en/rest/reference/git

.OUTPUTS
 {
  "node_id": "MDM6VGFnOTQwYmQzMzYyNDhlZmFlMGY5ZWU1YmM3YjJkNWM5ODU4ODdiMTZhYw==",
  "tag": "v0.0.1",
  "sha": "940bd336248efae0f9ee5bc7b2d5c985887b16ac",
  "url": "https://api.github.com/repos/octocat/Hello-World/git/tags/940bd336248efae0f9ee5bc7b2d5c985887b16ac",
  "message": "initial version",
  "tagger": {
    "name": "Monalisa Octocat",
    "email": "octocat@github.com",
    "date": "2014-11-07T22:01:45Z"
  },
  "object": {
    "type": "commit",
    "sha": "c3d0be41ecbe669545ee3e94d31ed9a4bc91ee3c",
    "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/c3d0be41ecbe669545ee3e94d31ed9a4bc91ee3c"
  },
  "verification": {
    "verified": false,
    "reason": "unsigned",
    "signature": null,
    "payload": null
  }
}
#>
Function Get-ATag
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$tag_sha
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/git/tags/$tag_sha?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/git/tags/$tag_sha"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
