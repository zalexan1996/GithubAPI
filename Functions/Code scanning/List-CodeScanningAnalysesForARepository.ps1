
<#
.SYNOPSIS
Lists the details of all code scanning analyses for a repository, starting with the most recent. The response is paginated and you can use the page and per_page parameters to list the analyses you're interested in. By default 30 analyses are listed per page.
The rules_count field in the response give the number of rules that were run in the analysis. For very old analyses this data is not available, and 0 is returned in this field.
You must use an access token with the security_events scope to use this endpoint with private repos, the public_repo scope also grants permission to read security events on public repos only. GitHub Apps must have the security_events read permission to use this endpoint.
Deprecation notice: The tool_name field is deprecated and will, in future, not be included in the response for this endpoint. The example response reflects this change. The tool name can now be found inside the tool field.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER tool_name
The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either tool_name or tool_guid, but not both.
         
.PARAMETER tool_guid
The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either tool_guid or tool_name, but not both.
         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER ref
The Git reference for the analyses you want to list. The ref for a branch can be formatted either as refs/heads/<branch name> or simply <branch name>. To reference a pull request use refs/pull/<number>/merge.
         
.PARAMETER sarif_id
Filter analyses belonging to the same SARIF upload.


.LINK
https://docs.github.com/en/rest/reference/code-scanning
#>
Function List-CodeScanningAnalysesForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$tool_name,
		[Parameter(Mandatory=$FALSE)][string]$tool_guid,
		[Parameter(Mandatory=$FALSE)][string]$page,
		[Parameter(Mandatory=$FALSE)][string]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$ref,
		[Parameter(Mandatory=$FALSE)][string]$sarif_id
    )
    $QueryStrings = @("tool_name=$tool_name","tool_guid=$tool_guid","page=$page","per_page=$per_page","ref=$ref","sarif_id=$sarif_id") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/analyses?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/code-scanning/analyses"
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

