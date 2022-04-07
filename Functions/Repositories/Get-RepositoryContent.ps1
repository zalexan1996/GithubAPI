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

.OUTPUTS
 {
  "type": "file",
  "encoding": "base64",
  "size": 5362,
  "name": "README.md",
  "path": "README.md",
  "content": "encoded content ...",
  "sha": "3d21ec53a331a6f037a91c368710b99387d012c1",
  "url": "https://api.github.com/repos/octokit/octokit.rb/contents/README.md",
  "git_url": "https://api.github.com/repos/octokit/octokit.rb/git/blobs/3d21ec53a331a6f037a91c368710b99387d012c1",
  "html_url": "https://github.com/octokit/octokit.rb/blob/master/README.md",
  "download_url": "https://raw.githubusercontent.com/octokit/octokit.rb/master/README.md",
  "_links": {
    "git": "https://api.github.com/repos/octokit/octokit.rb/git/blobs/3d21ec53a331a6f037a91c368710b99387d012c1",
    "self": "https://api.github.com/repos/octokit/octokit.rb/contents/README.md",
    "html": "https://github.com/octokit/octokit.rb/blob/master/README.md"
  }
}  [
  {
    "type": "file",
    "size": 625,
    "name": "octokit.rb",
    "path": "lib/octokit.rb",
    "sha": "fff6fe3a23bf1c8ea0692b4a883af99bee26fd3b",
    "url": "https://api.github.com/repos/octokit/octokit.rb/contents/lib/octokit.rb",
    "git_url": "https://api.github.com/repos/octokit/octokit.rb/git/blobs/fff6fe3a23bf1c8ea0692b4a883af99bee26fd3b",
    "html_url": "https://github.com/octokit/octokit.rb/blob/master/lib/octokit.rb",
    "download_url": "https://raw.githubusercontent.com/octokit/octokit.rb/master/lib/octokit.rb",
    "_links": {
      "self": "https://api.github.com/repos/octokit/octokit.rb/contents/lib/octokit.rb",
      "git": "https://api.github.com/repos/octokit/octokit.rb/git/blobs/fff6fe3a23bf1c8ea0692b4a883af99bee26fd3b",
      "html": "https://github.com/octokit/octokit.rb/blob/master/lib/octokit.rb"
    }
  },
  {
    "type": "dir",
    "size": 0,
    "name": "octokit",
    "path": "lib/octokit",
    "sha": "a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
    "url": "https://api.github.com/repos/octokit/octokit.rb/contents/lib/octokit",
    "git_url": "https://api.github.com/repos/octokit/octokit.rb/git/trees/a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
    "html_url": "https://github.com/octokit/octokit.rb/tree/master/lib/octokit",
    "download_url": null,
    "_links": {
      "self": "https://api.github.com/repos/octokit/octokit.rb/contents/lib/octokit",
      "git": "https://api.github.com/repos/octokit/octokit.rb/git/trees/a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
      "html": "https://github.com/octokit/octokit.rb/tree/master/lib/octokit"
    }
  }
]  {
  "type": "symlink",
  "target": "/path/to/symlink/target",
  "size": 23,
  "name": "some-symlink",
  "path": "bin/some-symlink",
  "sha": "452a98979c88e093d682cab404a3ec82babebb48",
  "url": "https://api.github.com/repos/octokit/octokit.rb/contents/bin/some-symlink",
  "git_url": "https://api.github.com/repos/octokit/octokit.rb/git/blobs/452a98979c88e093d682cab404a3ec82babebb48",
  "html_url": "https://github.com/octokit/octokit.rb/blob/master/bin/some-symlink",
  "download_url": "https://raw.githubusercontent.com/octokit/octokit.rb/master/bin/some-symlink",
  "_links": {
    "git": "https://api.github.com/repos/octokit/octokit.rb/git/blobs/452a98979c88e093d682cab404a3ec82babebb48",
    "self": "https://api.github.com/repos/octokit/octokit.rb/contents/bin/some-symlink",
    "html": "https://github.com/octokit/octokit.rb/blob/master/bin/some-symlink"
  }
}  {
  "type": "submodule",
  "submodule_git_url": "git://github.com/jquery/qunit.git",
  "size": 0,
  "name": "qunit",
  "path": "test/qunit",
  "sha": "6ca3721222109997540bd6d9ccd396902e0ad2f9",
  "url": "https://api.github.com/repos/jquery/jquery/contents/test/qunit?ref=master",
  "git_url": "https://api.github.com/repos/jquery/qunit/git/trees/6ca3721222109997540bd6d9ccd396902e0ad2f9",
  "html_url": "https://github.com/jquery/qunit/tree/6ca3721222109997540bd6d9ccd396902e0ad2f9",
  "download_url": null,
  "_links": {
    "git": "https://api.github.com/repos/jquery/qunit/git/trees/6ca3721222109997540bd6d9ccd396902e0ad2f9",
    "self": "https://api.github.com/repos/jquery/jquery/contents/test/qunit?ref=master",
    "html": "https://github.com/jquery/qunit/tree/6ca3721222109997540bd6d9ccd396902e0ad2f9"
  }
}
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
    $Querys = @()
    $QueryStrings = @(
        "ref"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/contents/$path?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/contents/$path"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
