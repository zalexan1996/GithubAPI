<#
.SYNOPSIS
Returns a single tree using the SHA1 value for that tree.
If truncated is true in the response then the number of items in the tree array exceeded our maximum limit. If you need to fetch more items, use the non-recursive method of fetching trees, and fetch one sub-tree at a time.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER tree_sha

         
.PARAMETER recursive
Setting this parameter to any value returns the objects or subtrees referenced by the tree specified in :tree_sha. For example, setting recursive to any of the following will enable returning objects or subtrees: 0, 1, "true", and "false". Omit this parameter to prevent recursively returning objects or subtrees.


.LINK
https://docs.github.com/en/rest/reference/git

.OUTPUTS
 {
  "sha": "9fb037999f264ba9a7fc6274d15fa3ae2ab98312",
  "url": "https://api.github.com/repos/octocat/Hello-World/trees/9fb037999f264ba9a7fc6274d15fa3ae2ab98312",
  "tree": [
    {
      "path": "file.rb",
      "mode": "100644",
      "type": "blob",
      "size": 30,
      "sha": "44b4fc6d56897b048c772eb4087f854f46256132",
      "url": "https://api.github.com/repos/octocat/Hello-World/git/blobs/44b4fc6d56897b048c772eb4087f854f46256132"
    },
    {
      "path": "subdir",
      "mode": "040000",
      "type": "tree",
      "sha": "f484d249c660418515fb01c2b9662073663c242e",
      "url": "https://api.github.com/repos/octocat/Hello-World/git/blobs/f484d249c660418515fb01c2b9662073663c242e"
    },
    {
      "path": "exec_file",
      "mode": "100755",
      "type": "blob",
      "size": 75,
      "sha": "45b983be36b73c0788dc9cbcb76cbb80fc7bb057",
      "url": "https://api.github.com/repos/octocat/Hello-World/git/blobs/45b983be36b73c0788dc9cbcb76cbb80fc7bb057"
    }
  ],
  "truncated": false
}  {
  "sha": "fc6274d15fa3ae2ab983129fb037999f264ba9a7",
  "url": "https://api.github.com/repos/octocat/Hello-World/trees/fc6274d15fa3ae2ab983129fb037999f264ba9a7",
  "tree": [
    {
      "path": "subdir/file.txt",
      "mode": "100644",
      "type": "blob",
      "size": 132,
      "sha": "7c258a9869f33c1e1e1f74fbb32f07c86cb5a75b",
      "url": "https://api.github.com/repos/octocat/Hello-World/git/7c258a9869f33c1e1e1f74fbb32f07c86cb5a75b"
    }
  ],
  "truncated": false
}
#>
Function Get-ATree
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$tree_sha,
		[Parameter(Mandatory=$FALSE)][string]$recursive
    )
    $Querys = @()
    $QueryStrings = @(
        "recursive"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/git/trees/$tree_sha?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/git/trees/$tree_sha"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
