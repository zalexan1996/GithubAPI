<#
.SYNOPSIS
Gets a Git commit object.
Signature verification object
The response will include a verification object that describes the result of verifying the commit's signature. The following fields are included in the verification object:
Name Type Description
verified boolean Indicates whether GitHub considers the signature in this commit to be verified.
reason string The reason for verified value. Possible values and their meanings are enumerated in the table below.
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

         
.PARAMETER commit_sha
commit_sha parameter


.LINK
https://docs.github.com/en/rest/reference/git

.OUTPUTS
 {
  "sha": "7638417db6d59f3c431d3e1f261cc637155684cd",
  "node_id": "MDY6Q29tbWl0NmRjYjA5YjViNTc4NzVmMzM0ZjYxYWViZWQ2OTVlMmU0MTkzZGI1ZQ==",
  "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/7638417db6d59f3c431d3e1f261cc637155684cd",
  "html_url": "https://github.com/octocat/Hello-World/commit/7638417db6d59f3c431d3e1f261cc637155684cd",
  "author": {
    "date": "2014-11-07T22:01:45Z",
    "name": "Monalisa Octocat",
    "email": "octocat@github.com"
  },
  "committer": {
    "date": "2014-11-07T22:01:45Z",
    "name": "Monalisa Octocat",
    "email": "octocat@github.com"
  },
  "message": "added readme, because im a good github citizen",
  "tree": {
    "url": "https://api.github.com/repos/octocat/Hello-World/git/trees/691272480426f78a0138979dd3ce63b77f706feb",
    "sha": "691272480426f78a0138979dd3ce63b77f706feb"
  },
  "parents": [
    {
      "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/1acc419d4d6a9ce985db7be48c6349a0475975b5",
      "sha": "1acc419d4d6a9ce985db7be48c6349a0475975b5",
      "html_url": "https://github.com/octocat/Hello-World/commit/7638417db6d59f3c431d3e1f261cc637155684cd"
    }
  ],
  "verification": {
    "verified": false,
    "reason": "unsigned",
    "signature": null,
    "payload": null
  }
}
#>
Function Get-ACommit
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$commit_sha
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/git/commits/$commit_sha?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/git/commits/$commit_sha"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
