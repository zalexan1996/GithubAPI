<#
.SYNOPSIS
Creates a new Git commit object.
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

         
.PARAMETER message
Required. The commit message
         
.PARAMETER tree
Required. The SHA of the tree object this commit points to
         
.PARAMETER parents
The SHAs of the commits that were the parents of this commit. If omitted or empty, the commit will be written as a root commit. For a single parent, an array of one SHA should be provided; for a merge commit, an array of more than one should be provided.
         
.PARAMETER author
Information about the author of the commit. By default, the author will be the authenticated user and the current date. See the author and committer object below for details.
         
.PARAMETER committer
Information about the person who is making the commit. By default, committer will use the information set in author. See the author and committer object below for details.
         
.PARAMETER signature
The PGP signature of the commit. GitHub adds the signature to the gpgsig header of the created commit. For a commit signature to be verifiable by Git or GitHub, it must be an ASCII-armored detached PGP signature over the string commit as it would be written to the object database. To pass a signature parameter, you need to first manually create a valid PGP signature, which can be complicated. You may find it easier to use the command line to create signed commits.


.LINK
https://docs.github.com/en/rest/reference/git

.OUTPUTS
 {
  "sha": "7638417db6d59f3c431d3e1f261cc637155684cd",
  "node_id": "MDY6Q29tbWl0NzYzODQxN2RiNmQ1OWYzYzQzMWQzZTFmMjYxY2M2MzcxNTU2ODRjZA==",
  "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/7638417db6d59f3c431d3e1f261cc637155684cd",
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
  "message": "my commit message",
  "tree": {
    "url": "https://api.github.com/repos/octocat/Hello-World/git/trees/827efc6d56897b048c772eb4087f854f46256132",
    "sha": "827efc6d56897b048c772eb4087f854f46256132"
  },
  "parents": [
    {
      "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/7d1b31e74ee336d15cbd21741bc88a537ed063a0",
      "sha": "7d1b31e74ee336d15cbd21741bc88a537ed063a0",
      "html_url": "https://github.com/octocat/Hello-World/commit/7d1b31e74ee336d15cbd21741bc88a537ed063a0"
    }
  ],
  "verification": {
    "verified": false,
    "reason": "unsigned",
    "signature": null,
    "payload": null
  },
  "html_url": "https://github.com/octocat/Hello-World/commit/7638417db6d59f3c431d3e1f261cc637155684cd"
}
#>
Function Create-ACommit
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$message,
		[Parameter(Mandatory=$FALSE)][string]$tree,
		[Parameter(Mandatory=$FALSE)][string[]]$parents,
		[Parameter(Mandatory=$FALSE)][object]$author,
		[Parameter(Mandatory=$FALSE)][object]$committer,
		[Parameter(Mandatory=$FALSE)][string]$signature
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "message",
		"tree",
		"parents",
		"author",
		"committer",
		"signature" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/git/commits?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/git/commits"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
