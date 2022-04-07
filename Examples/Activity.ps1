# Import the module
Import-Module "$(Split-Path $PSScriptRoot)\GithubAPI.psm1" -ArgumentList "Activity"



<#            List the users that have starred the GithubAPI repository.             #>
<#####################################################################################>
List-StarGazers -Owner Zalexan1996 -Repo GithubAPI | Select-Object Login, URL
# login        url
# -----        ---
# wethreetrees https://api.github.com/users/wethreetrees
# Kalmanq      https://api.github.com/users/Kalmanq
# mickedefault https://api.github.com/users/mickedefault
# Celerium     https://api.github.com/users/Celerium
# kayaclick    https://api.github.com/users/kayaclick
<#####################################################################################>






<#                              List the 5 latest public events                      #>
<#####################################################################################>
List-PublicEvents -per_page 5 | Select-Object Type,
    @{N="Actor"; E={$_.Actor.Login}},
    @{N="Repo";E={$_.Repo.Name}},
    @{N="Timestamp";E={$_.Created_At}}

# Type                          Actor               Repo                                    Timestamp
# ----                          -----               ----                                    ---------
# PullRequestReviewCommentEvent Lisa394             FeebyOpenICT/Feeby                      4/7/2022 6:27:37 PM
# IssueCommentEvent             wpmobilebot         woocommerce/woocommerce-android         4/7/2022 6:42:19 PM
# PullRequestEvent              sruti1312           opensearch-project/performance-analyzer 4/7/2022 6:42:19 PM
# PullRequestEvent              AndresAlvarado7     AndresAlvarado7/FinalProject            4/7/2022 6:42:19 PM
# PushEvent                     github-actions[bot] prashis/prashis                         4/7/2022 6:42:19 PM
<#####################################################################################>



<#              List the 5 latest events on the PowerShell repository                #>
<#####################################################################################>
List-RepositoryEvents -owner PowerShell -repo PowerShell -per_page 5 | Select-Object Type,
    @{N="Actor"; E={$_.Actor.Login}},
    @{N="Repo";E={$_.Repo.Name}},
    @{N="Timestamp";E={$_.Created_At}}

# type              Actor       Repo                  Timestamp
# ----              -----       ----                  ---------
# IssueCommentEvent PaulHigin   PowerShell/PowerShell 4/7/2022 6:26:00 PM
# IssueCommentEvent mklement0   PowerShell/PowerShell 4/7/2022 6:16:05 PM
# IssueCommentEvent PaulHigin   PowerShell/PowerShell 4/7/2022 6:14:26 PM
# IssueCommentEvent PaulHigin   PowerShell/PowerShell 4/7/2022 6:12:17 PM
# IssueCommentEvent awakecoding PowerShell/PowerShell 4/7/2022 6:10:46 PM
<#####################################################################################>