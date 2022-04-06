# GithubAPI
A dynamically generated PowerShell module for the GitHub RestAPI. Passing `$TRUE` into the module scrapes https://docs.github.com/en/rest/reference and converts each endpoint into PowerShell functions. Regenerating the function definitions is not necessary in order to use this module because I've done the generating for you!

# Requirements
- Generate a GitHub OAuth token and put it in `C:/Users/Username/AppData/Roaming/github.token`
- PowerShell 7.2+ recommended. I did not test this on Windows PowerShell.
- Selenium module (if you want to regenerate the function definitions)
- Google Chrome (if you want to regenerate the function definitions)


# How to
**Make sure your GitHub OAuth token is in `$ENV:AppData/github.token` before using this module** 

## Import all modules WITHOUT regenerating the function definitions
`Import-Module ./GithubAPI`

## Import [Specific Sections](https://docs.github.com/en/rest/reference) WITHOUT regenerating the function definitions
`Import-Module ./GithubAPI -ArgumentList @("Branches", "Commits", "Releases", "Repositories"), $FALSE`

## Import all sections and regenerate the function definitions
`Import-Module ./GithubAPI -ArgumentList @("ALL"), $TRUE`


# TODO
- ~~Module argument to only include certain sections~~
- Default Parameters