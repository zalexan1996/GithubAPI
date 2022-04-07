# Import the module
Import-Module "$(Split-Path $PSScriptRoot)\GithubAPI.psm1" -ArgumentList "Activity"




<#                    Get a specific branch from a repository                        #>
<#####################################################################################>
Get-ABranch -owner godotengine -repo godot -branch master | Select-Object Name, 
    @{N="SHA"; E={$_.commit.sha}}, 
    @{N="Link";E={$_._links.self}}

# name   SHA                                      Link
# ----   ---                                      ----
# master 26879ed55f7473035d375b9809b095407de41883 https://api.github.com/repos/godotengine/godot/branches/master
<#####################################################################################>





<#                     Get all branches from a repository                            #>
<#####################################################################################>
List-Branches -owner "godotengine" -repo "godot"

# name commit                                                                                            protected
# ---- ------                                                                                            ---------
# 3.0  @{sha=362774c6176596f87506e3d330dd1d12b0b75e19; url=https://api.github.com/repos/godoteng...      True
# 3.1  @{sha=22eeafc735dfa09b5f92970ee83a208f53e4f0b0; url=https://api.github.com/repos/godoteng...      True
# 3.2  @{sha=2407df9870cb66d38c6d3523f4ed27ae3bb3c3fd; url=https://api.github.com/repos/godoteng...      True
# ...
<#####################################################################################>



