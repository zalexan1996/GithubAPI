
<#
.SYNOPSIS
View the progress of an import.
Import status
This section includes details about the possible values of the status field of the Import Progress response.
An import that does not have errors will progress through these steps:
detecting - the "detection" step of the import is in progress because the request did not include a vcs parameter. The import is identifying the type of source control present at the URL.
importing - the "raw" step of the import is in progress. This is where commit data is fetched from the original repository. The import progress response will include commit_count (the total number of raw commits that will be imported) and percent (0 - 100, the current progress through the import).
mapping - the "rewrite" step of the import is in progress. This is where SVN branches are converted to Git branches, and where author updates are applied. The import progress response does not include progress information.
pushing - the "push" step of the import is in progress. This is where the importer updates the repository on GitHub. The import progress response will include push_percent, which is the percent value reported by git push when it is "Writing objects".
complete - the import is complete, and the repository is ready on GitHub.
If there are problems, you will see one of these in the status field:
auth_failed - the import requires authentication in order to connect to the original repository. To update authentication for the import, please see the Update an import section.
error - the import encountered an error. The import progress response will include the failed_step and an error message. Contact GitHub Support for more information.
detection_needs_auth - the importer requires authentication for the originating repository to continue detection. To update authentication for the import, please see the Update an import section.
detection_found_nothing - the importer didn't recognize any source control at the URL. To resolve, Cancel the import and retry with the correct URL.
detection_found_multiple - the importer found several projects or repositories at the provided URL. When this is the case, the Import Progress response will also include a project_choices field with the possible project choices as values. To update project choice, please see the Update an import section.
The project_choices field
When multiple projects are found at the provided URL, the response hash will include a project_choices field, the value of which is an array of hashes each representing a project choice. The exact key/value pairs of the project hashes will differ depending on the version control type.
Git LFS related fields
This section includes details about Git LFS related fields that may be present in the Import Progress response.
use_lfs - describes whether the import has been opted in or out of using Git LFS. The value can be opt_in, opt_out, or undecided if no action has been taken.
has_large_files - the boolean value describing whether files larger than 100MB were found during the importing step.
large_files_size - the total size in gigabytes of files larger than 100MB found in the originating repository.
large_files_count - the total number of files larger than 100MB found in the originating repository. To see a list of these files, make a "Get Large Files" request.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo



.LINK
https://docs.github.com/en/rest/reference/migrations
#>
Function Get-AnImportStatus
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import"
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

