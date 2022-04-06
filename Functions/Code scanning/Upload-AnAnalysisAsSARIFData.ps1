<#
.SYNOPSIS
Uploads SARIF data containing the results of a code scanning analysis to make the results available in a repository. You must use an access token with the security_events scope to use this endpoint for private repositories. You can also use tokens with the public_repo scope for public repositories only. GitHub Apps must have the security_events write permission to use this endpoint.
There are two places where you can upload code scanning results.
If you upload to a pull request, for example --ref refs/pull/42/merge or --ref refs/pull/42/head, then the results appear as alerts in a pull request check. For more information, see "Triaging code scanning alerts in pull requests."
If you upload to a branch, for example --ref refs/heads/my-branch, then the results appear in the Security tab for your repository. For more information, see "Managing code scanning alerts for your repository."
You must compress the SARIF-formatted analysis data that you want to upload, using gzip, and then encode it as a Base64 format string. For example:
gzip -c analysis-data.sarif | base64 -w0
SARIF upload supports a maximum of 5000 results per analysis run. Any results over this limit are ignored and any SARIF uploads with more than 25,000 results are rejected. Typically, but not necessarily, a SARIF file contains a single run of a single tool. If a code scanning tool generates too many results, you should update the analysis configuration to run only the most important rules or queries.
The 202 Accepted, response includes an id value. You can use this ID to check the status of the upload by using this for the /sarifs/{sarif_id} endpoint. For more information, see "Get information about a SARIF upload."

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER commit_sha
Required. The SHA of the commit to which the analysis you are uploading relates.
         
.PARAMETER ref
Required. The full Git reference, formatted as refs/heads/<branch name>, refs/pull/<number>/merge, or refs/pull/<number>/head.
         
.PARAMETER sarif
Required. A Base64 string representing the SARIF file to upload. You must first compress your SARIF file using gzip and then translate the contents of the file into a Base64 encoding string. For more information, see "SARIF support for code scanning."
         
.PARAMETER checkout_uri
The base directory used in the analysis, as it appears in the SARIF file. This property is used to convert file paths from absolute to relative, so that alerts can be mapped to their correct location in the repository.
         
.PARAMETER started_at
The time that the analysis run began. This is a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ.
         
.PARAMETER tool_name
The name of the tool used to generate the code scanning analysis. If this parameter is not used, the tool name defaults to "API". If the uploaded SARIF contains a tool GUID, this will be available for filtering using the tool_guid parameter of operations such as GET /repos/{owner}/{repo}/code-scanning/alerts.


.LINK
https://docs.github.com/en/rest/reference/code-scanning
#>
Function Upload-AnAnalysisAsSARIFData
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$commit_sha,
		[Parameter(Mandatory=$FALSE)][string]$ref,
		[Parameter(Mandatory=$FALSE)][string]$sarif,
		[Parameter(Mandatory=$FALSE)][string]$checkout_uri,
		[Parameter(Mandatory=$FALSE)][string]$started_at,
		[Parameter(Mandatory=$FALSE)][string]$tool_name
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "commit_sha",
		"ref",
		"sarif",
		"checkout_uri",
		"started_at",
		"tool_name" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/sarifs?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/sarifs"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
