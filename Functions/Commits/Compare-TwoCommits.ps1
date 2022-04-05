
<#
.SYNOPSIS
The basehead param is comprised of two parts: base and head. Both must be branch names in repo. To compare branches across other repositories in the same network as repo, use the format <USERNAME>:branch.
The response from the API is equivalent to running the git log base..head command; however, commits are returned in chronological order. Pass the appropriate media type to fetch diff and patch formats.
The response also includes details on the files that were changed between the two commits. This includes the status of the change (for example, if a file was added, removed, modified, or renamed), and details of the change itself. For example, files with a renamed status have a previous_filename field showing the previous filename of the file, and files with a modified status have a patch field showing the changes made to the file.
Working with large comparisons
To process a response with a large number of commits, you can use (per_page or page) to paginate the results. When using paging, the list of changed files is only returned with page 1, but includes all changed files for the entire comparison. For more information on working with pagination, see "Traversing with pagination."
When calling this API without any paging parameters (per_page or page), the returned list is limited to 250 commits and the last commit in the list is the most recent of the entire comparison. When a paging parameter is specified, the first commit in the returned list of each page is the earliest.
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

         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER basehead
The base branch and head branch to compare. This parameter expects the format {base}...{head}.


.LINK
https://docs.github.com/en/rest/reference/commits
#>
Function Compare-TwoCommits
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$page,
		[Parameter(Mandatory=$FALSE)][string]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$basehead
    )
    $QueryStrings = @("page=$page","per_page=$per_page") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/compare/$basehead?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/compare/$basehead"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

