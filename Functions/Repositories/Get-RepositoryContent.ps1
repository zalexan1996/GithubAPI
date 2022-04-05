
<#
.SYNOPSIS
Gets the contents of a file or directory in a repository. Specify the file path or directory in :path. If you omit :path, you will receive the contents of the repository's root directory. See the description below regarding what the API response includes for directories.
Files and symlinks support a custom media type for retrieving the raw content or rendered HTML (when supported). All content types support a custom media type to ensure the content is returned in a consistent object format.
Note:
To get a repository's contents recursively, you can recursively get the tree.
This API has an upper limit of 1,000 files for a directory. If you need to retrieve more files, use the Git Trees API.
This API supports files up to 1 megabyte in size.
If the content is a directory
The response will be an array of objects, one object for each item in the directory. When listing the contents of a directory, submodules have their "type" specified as "file". Logically, the value should be "submodule". This behavior exists in API v3 for backwards compatibility purposes. In the next major version of the API, the type will be returned as "submodule".
If the content is a symlink
If the requested :path points to a symlink, and the symlink's target is a normal file in the repository, then the API responds with the content of the file (in the format shown in the example. Otherwise, the API responds with an object describing the symlink itself.
If the content is a submodule
The submodule_git_url identifies the location of the submodule repository, and the sha identifies a specific commit within the submodule repository. Git uses the given URL when cloning the submodule repository, and checks out the submodule at that specific commit.
If the submodule repository is not hosted on github.com, the Git URLs (git_url and _links["git"]) and the github.com URLs (html_url and _links["html"]) will have null values.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER path
path parameter
         
.PARAMETER ref
The name of the commit/branch/tag. Default: the repository’s default branch (usually master)


.LINK
https://docs.github.com/en/rest/reference/repos
#>
Function Get-RepositoryContent
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$path,
		[Parameter(Mandatory=$FALSE)][string]$ref
    )
    $QueryStrings = @("ref=$ref") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/contents/$path?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/contents/$path"
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

