# GithubAPI
A self-generating PowerShell module for the GitHub API.

# Requirements
- Generate GitHub token and put it in `C:/Users/Username/AppData/Roaming/github.token`
- Google Chrome
- PowerShell 7.2+ recommended. I did not test this on Windows PowerShell.


# How it works
Running the following will scrape the GitHub API's [documentation page](https://docs.github.com/en/rest/reference) and convert each endpoint to a PowerShell function.

`Import-Module ./Github.psm1 -ArgumentList $TRUE`

Why do it this way? Because ain't nobody got time for doing that manually. This script creates ~800 functions.

Passing in `$TRUE` will regenerate the cached functions (this takes my computer about 20-30 minutes), while passing in `$FALSE` just loads whatever .ps1 files happen to be in the *functions* subfolder. The web driver only navigates once for every section of the specification so we're not constantly spamming their servers.

# TODO
- Module argument to only include certain sections
- Default Parameters
