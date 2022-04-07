<#
.SYNOPSIS
Creates a new file or replaces an existing file in a repository.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER path
path parameter
         
.PARAMETER message
Required. The commit message.
         
.PARAMETER content
Required. The new file content, using Base64 encoding.
         
.PARAMETER sha
Required if you are updating a file. The blob SHA of the file being replaced.
         
.PARAMETER branch
The branch name. Default: the repository’s default branch (usually master)
         
.PARAMETER committer
The person that committed the file. Default: the authenticated user.
         
.PARAMETER author
The author of the file. Default: The committer or the authenticated user if you omit committer.


.LINK
https://docs.github.com/en/rest/reference/repos

.OUTPUTS
 {
  "content": {
    "name": "hello.txt",
    "path": "notes/hello.txt",
    "sha": "a56507ed892d05a37c6d6128c260937ea4d287bd",
    "size": 9,
    "url": "https://api.github.com/repos/octocat/Hello-World/contents/notes/hello.txt",
    "html_url": "https://github.com/octocat/Hello-World/blob/master/notes/hello.txt",
    "git_url": "https://api.github.com/repos/octocat/Hello-World/git/blobs/a56507ed892d05a37c6d6128c260937ea4d287bd",
    "download_url": "https://raw.githubusercontent.com/octocat/HelloWorld/master/notes/hello.txt",
    "type": "file",
    "_links": {
      "self": "https://api.github.com/repos/octocat/Hello-World/contents/notes/hello.txt",
      "git": "https://api.github.com/repos/octocat/Hello-World/git/blobs/a56507ed892d05a37c6d6128c260937ea4d287bd",
      "html": "https://github.com/octocat/Hello-World/blob/master/notes/hello.txt"
    }
  },
  "commit": {
    "sha": "18a43cd8e1e3a79c786e3d808a73d23b6d212b16",
    "node_id": "MDY6Q29tbWl0MThhNDNjZDhlMWUzYTc5Yzc4NmUzZDgwOGE3M2QyM2I2ZDIxMmIxNg==",
    "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/18a43cd8e1e3a79c786e3d808a73d23b6d212b16",
    "html_url": "https://github.com/octocat/Hello-World/git/commit/18a43cd8e1e3a79c786e3d808a73d23b6d212b16",
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
      "url": "https://api.github.com/repos/octocat/Hello-World/git/trees/9a21f8e2018f42ffcf369b24d2cd20bc25c9e66f",
      "sha": "9a21f8e2018f42ffcf369b24d2cd20bc25c9e66f"
    },
    "parents": [
      {
        "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/da5a433788da5c255edad7979b328b67d79f53f6",
        "html_url": "https://github.com/octocat/Hello-World/git/commit/da5a433788da5c255edad7979b328b67d79f53f6",
        "sha": "da5a433788da5c255edad7979b328b67d79f53f6"
      }
    ],
    "verification": {
      "verified": false,
      "reason": "unsigned",
      "signature": null,
      "payload": null
    }
  }
}  {
  "content": {
    "name": "hello.txt",
    "path": "notes/hello.txt",
    "sha": "95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
    "size": 9,
    "url": "https://api.github.com/repos/octocat/Hello-World/contents/notes/hello.txt",
    "html_url": "https://github.com/octocat/Hello-World/blob/master/notes/hello.txt",
    "git_url": "https://api.github.com/repos/octocat/Hello-World/git/blobs/95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
    "download_url": "https://raw.githubusercontent.com/octocat/HelloWorld/master/notes/hello.txt",
    "type": "file",
    "_links": {
      "self": "https://api.github.com/repos/octocat/Hello-World/contents/notes/hello.txt",
      "git": "https://api.github.com/repos/octocat/Hello-World/git/blobs/95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
      "html": "https://github.com/octocat/Hello-World/blob/master/notes/hello.txt"
    }
  },
  "commit": {
    "sha": "7638417db6d59f3c431d3e1f261cc637155684cd",
    "node_id": "MDY6Q29tbWl0NzYzODQxN2RiNmQ1OWYzYzQzMWQzZTFmMjYxY2M2MzcxNTU2ODRjZA==",
    "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/7638417db6d59f3c431d3e1f261cc637155684cd",
    "html_url": "https://github.com/octocat/Hello-World/git/commit/7638417db6d59f3c431d3e1f261cc637155684cd",
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
      "url": "https://api.github.com/repos/octocat/Hello-World/git/trees/691272480426f78a0138979dd3ce63b77f706feb",
      "sha": "691272480426f78a0138979dd3ce63b77f706feb"
    },
    "parents": [
      {
        "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/1acc419d4d6a9ce985db7be48c6349a0475975b5",
        "html_url": "https://github.com/octocat/Hello-World/git/commit/1acc419d4d6a9ce985db7be48c6349a0475975b5",
        "sha": "1acc419d4d6a9ce985db7be48c6349a0475975b5"
      }
    ],
    "verification": {
      "verified": false,
      "reason": "unsigned",
      "signature": null,
      "payload": null
    }
  }
}
#>
Function Create-OrUpdateFileContents
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$path,
		[Parameter(Mandatory=$FALSE)][string]$message,
		[Parameter(Mandatory=$FALSE)][string]$content,
		[Parameter(Mandatory=$FALSE)][string]$sha,
		[Parameter(Mandatory=$FALSE)][string]$branch,
		[Parameter(Mandatory=$FALSE)][object]$committer,
		[Parameter(Mandatory=$FALSE)][object]$author
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "message",
		"content",
		"sha",
		"branch",
		"committer",
		"author" 
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
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
