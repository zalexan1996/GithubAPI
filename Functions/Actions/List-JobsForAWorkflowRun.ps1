<#
.SYNOPSIS
Lists jobs for a workflow run. Anyone with read access to the repository can use this endpoint. If the repository is private you must use an access token with the repo scope. GitHub Apps must have the actions:read permission to use this endpoint. You can use parameters to narrow the list of results. For more information about using parameters, see Parameters.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER run_id
The id of the workflow run.
         
.PARAMETER filter
Filters jobs by their completed_at timestamp. Can be one of:
* latest: Returns jobs from the most recent execution of the workflow run.
* all: Returns all jobs for a workflow run, including from old executions of the workflow run.
Default: latest
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "total_count": 1,
  "jobs": [
    {
      "id": 399444496,
      "run_id": 29679449,
      "run_url": "https://api.github.com/repos/octo-org/octo-repo/actions/runs/29679449",
      "node_id": "MDEyOldvcmtmbG93IEpvYjM5OTQ0NDQ5Ng==",
      "head_sha": "f83a356604ae3c5d03e1b46ef4d1ca77d64a90b0",
      "url": "https://api.github.com/repos/octo-org/octo-repo/actions/jobs/399444496",
      "html_url": "https://github.com/octo-org/octo-repo/runs/399444496",
      "status": "completed",
      "conclusion": "success",
      "started_at": "2020-01-20T17:42:40Z",
      "completed_at": "2020-01-20T17:44:39Z",
      "name": "build",
      "steps": [
        {
          "name": "Set up job",
          "status": "completed",
          "conclusion": "success",
          "number": 1,
          "started_at": "2020-01-20T09:42:40.000-08:00",
          "completed_at": "2020-01-20T09:42:41.000-08:00"
        },
        {
          "name": "Run actions/checkout@v2",
          "status": "completed",
          "conclusion": "success",
          "number": 2,
          "started_at": "2020-01-20T09:42:41.000-08:00",
          "completed_at": "2020-01-20T09:42:45.000-08:00"
        },
        {
          "name": "Set up Ruby",
          "status": "completed",
          "conclusion": "success",
          "number": 3,
          "started_at": "2020-01-20T09:42:45.000-08:00",
          "completed_at": "2020-01-20T09:42:45.000-08:00"
        },
        {
          "name": "Run actions/cache@v3",
          "status": "completed",
          "conclusion": "success",
          "number": 4,
          "started_at": "2020-01-20T09:42:45.000-08:00",
          "completed_at": "2020-01-20T09:42:48.000-08:00"
        },
        {
          "name": "Install Bundler",
          "status": "completed",
          "conclusion": "success",
          "number": 5,
          "started_at": "2020-01-20T09:42:48.000-08:00",
          "completed_at": "2020-01-20T09:42:52.000-08:00"
        },
        {
          "name": "Install Gems",
          "status": "completed",
          "conclusion": "success",
          "number": 6,
          "started_at": "2020-01-20T09:42:52.000-08:00",
          "completed_at": "2020-01-20T09:42:53.000-08:00"
        },
        {
          "name": "Run Tests",
          "status": "completed",
          "conclusion": "success",
          "number": 7,
          "started_at": "2020-01-20T09:42:53.000-08:00",
          "completed_at": "2020-01-20T09:42:59.000-08:00"
        },
        {
          "name": "Deploy to Heroku",
          "status": "completed",
          "conclusion": "success",
          "number": 8,
          "started_at": "2020-01-20T09:42:59.000-08:00",
          "completed_at": "2020-01-20T09:44:39.000-08:00"
        },
        {
          "name": "Post actions/cache@v3",
          "status": "completed",
          "conclusion": "success",
          "number": 16,
          "started_at": "2020-01-20T09:44:39.000-08:00",
          "completed_at": "2020-01-20T09:44:39.000-08:00"
        },
        {
          "name": "Complete job",
          "status": "completed",
          "conclusion": "success",
          "number": 17,
          "started_at": "2020-01-20T09:44:39.000-08:00",
          "completed_at": "2020-01-20T09:44:39.000-08:00"
        }
      ],
      "check_run_url": "https://api.github.com/repos/octo-org/octo-repo/check-runs/399444496",
      "labels": [
        "self-hosted",
        "foo",
        "bar"
      ],
      "runner_id": 1,
      "runner_name": "my runner",
      "runner_group_id": 2,
      "runner_group_name": "my runner group"
    }
  ]
}
#>
Function List-JobsForAWorkflowRun
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$run_id,
		[Parameter(Mandatory=$FALSE)][string]$filter,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $Querys = @()
    $QueryStrings = @(
        "filter",
		"per_page",
		"page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runs/$run_id/jobs?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runs/$run_id/jobs"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
