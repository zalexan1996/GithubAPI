
<#
.SYNOPSIS
Removes any previous labels and sets the new labels for an issue.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER issue_number
issue_number parameter
         
.PARAMETER labels
The names of the labels to set for the issue. The labels you set replace any existing labels. You can pass an empty array to remove all labels. Alternatively, you can pass a single label as a string or an array of labels directly, but GitHub recommends passing an object with the labels key. You can also add labels to the existing labels for an issue. For more information, see "Add labels to an issue."


.LINK
https://docs.github.com/en/rest/reference/issues
#>
Function Set-LabelsForAnIssue
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$issue_number,
		[Parameter(Mandatory=$FALSE)][string]$labels
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/issues/$issue_number/labels?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/issues/$issue_number/labels"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"labels" = "$labels"
    }

    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
