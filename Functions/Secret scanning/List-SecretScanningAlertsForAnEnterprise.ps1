<#
.SYNOPSIS
Lists secret scanning alerts for eligible repositories in an enterprise, from newest to oldest. To use this endpoint, you must be a member of the enterprise, and you must use an access token with the repo scope or security_events scope. Alerts are only returned for organizations in the enterprise for which you are an organization owner or a security manager.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER state
Set to open or resolved to only list secret scanning alerts in a specific state.
         
.PARAMETER secret_type
A comma-separated list of secret types to return. By default all secret types are returned. See "Secret scanning patterns" for a complete list of secret types (API slug).
         
.PARAMETER resolution
A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are false_positive, wont_fix, revoked, pattern_edited, pattern_deleted or used_in_tests.
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER before
A cursor, as given in the Link header. If specified, the query only searches for events before this cursor.
         
.PARAMETER after
A cursor, as given in the Link header. If specified, the query only searches for events after this cursor.


.LINK
https://docs.github.com/en/rest/reference/secret-scanning

.OUTPUTS
 [
  {
    "number": 2,
    "created_at": "2020-11-06T18:48:51Z",
    "url": "https://api.github.com/repos/owner/private-repo/secret-scanning/alerts/2",
    "html_url": "https://github.com/owner/private-repo/security/secret-scanning/2",
    "locations_url": "https://api.github.com/repos/owner/private-repo/secret-scanning/alerts/2/locations",
    "state": "resolved",
    "resolution": "false_positive",
    "resolved_at": "2020-11-07T02:47:13Z",
    "resolved_by": {
      "login": "monalisa",
      "id": 2,
      "node_id": "MDQ6VXNlcjI=",
      "avatar_url": "https://alambic.github.com/avatars/u/2?",
      "gravatar_id": "",
      "url": "https://api.github.com/users/monalisa",
      "html_url": "https://github.com/monalisa",
      "followers_url": "https://api.github.com/users/monalisa/followers",
      "following_url": "https://api.github.com/users/monalisa/following{/other_user}",
      "gists_url": "https://api.github.com/users/monalisa/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/monalisa/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/monalisa/subscriptions",
      "organizations_url": "https://api.github.com/users/monalisa/orgs",
      "repos_url": "https://api.github.com/users/monalisa/repos",
      "events_url": "https://api.github.com/users/monalisa/events{/privacy}",
      "received_events_url": "https://api.github.com/users/monalisa/received_events",
      "type": "User",
      "site_admin": true
    },
    "secret_type": "adafruit_io_key",
    "secret_type_display_name": "Adafruit IO Key",
    "secret": "aio_XXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    "repository": {
      "id": 1296269,
      "node_id": "MDEwOlJlcG9zaXRvcnkxMjk2MjY5",
      "name": "Hello-World",
      "full_name": "octocat/Hello-World",
      "owner": {
        "login": "octocat",
        "id": 1,
        "node_id": "MDQ6VXNlcjE=",
        "avatar_url": "https://github.com/images/error/octocat_happy.gif",
        "gravatar_id": "",
        "url": "https://api.github.com/users/octocat",
        "html_url": "https://github.com/octocat",
        "followers_url": "https://api.github.com/users/octocat/followers",
        "following_url": "https://api.github.com/users/octocat/following{/other_user}",
        "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
        "organizations_url": "https://api.github.com/users/octocat/orgs",
        "repos_url": "https://api.github.com/users/octocat/repos",
        "events_url": "https://api.github.com/users/octocat/events{/privacy}",
        "received_events_url": "https://api.github.com/users/octocat/received_events",
        "type": "User",
        "site_admin": false
      },
      "private": false,
      "html_url": "https://github.com/octocat/Hello-World",
      "description": "This your first repo!",
      "fork": false,
      "url": "https://api.github.com/repos/octocat/Hello-World",
      "archive_url": "https://api.github.com/repos/octocat/Hello-World/{archive_format}{/ref}",
      "assignees_url": "https://api.github.com/repos/octocat/Hello-World/assignees{/user}",
      "blobs_url": "https://api.github.com/repos/octocat/Hello-World/git/blobs{/sha}",
      "branches_url": "https://api.github.com/repos/octocat/Hello-World/branches{/branch}",
      "collaborators_url": "https://api.github.com/repos/octocat/Hello-World/collaborators{/collaborator}",
      "comments_url": "https://api.github.com/repos/octocat/Hello-World/comments{/number}",
      "commits_url": "https://api.github.com/repos/octocat/Hello-World/commits{/sha}",
      "compare_url": "https://api.github.com/repos/octocat/Hello-World/compare/{base}...{head}",
      "contents_url": "https://api.github.com/repos/octocat/Hello-World/contents/{+path}",
      "contributors_url": "https://api.github.com/repos/octocat/Hello-World/contributors",
      "deployments_url": "https://api.github.com/repos/octocat/Hello-World/deployments",
      "downloads_url": "https://api.github.com/repos/octocat/Hello-World/downloads",
      "events_url": "https://api.github.com/repos/octocat/Hello-World/events",
      "forks_url": "https://api.github.com/repos/octocat/Hello-World/forks",
      "git_commits_url": "https://api.github.com/repos/octocat/Hello-World/git/commits{/sha}",
      "git_refs_url": "https://api.github.com/repos/octocat/Hello-World/git/refs{/sha}",
      "git_tags_url": "https://api.github.com/repos/octocat/Hello-World/git/tags{/sha}",
      "git_url": "git:github.com/octocat/Hello-World.git",
      "issue_comment_url": "https://api.github.com/repos/octocat/Hello-World/issues/comments{/number}",
      "issue_events_url": "https://api.github.com/repos/octocat/Hello-World/issues/events{/number}",
      "issues_url": "https://api.github.com/repos/octocat/Hello-World/issues{/number}",
      "keys_url": "https://api.github.com/repos/octocat/Hello-World/keys{/key_id}",
      "labels_url": "https://api.github.com/repos/octocat/Hello-World/labels{/name}",
      "languages_url": "https://api.github.com/repos/octocat/Hello-World/languages",
      "merges_url": "https://api.github.com/repos/octocat/Hello-World/merges",
      "milestones_url": "https://api.github.com/repos/octocat/Hello-World/milestones{/number}",
      "notifications_url": "https://api.github.com/repos/octocat/Hello-World/notifications{?since,all,participating}",
      "pulls_url": "https://api.github.com/repos/octocat/Hello-World/pulls{/number}",
      "releases_url": "https://api.github.com/repos/octocat/Hello-World/releases{/id}",
      "ssh_url": "git@github.com:octocat/Hello-World.git",
      "stargazers_url": "https://api.github.com/repos/octocat/Hello-World/stargazers",
      "statuses_url": "https://api.github.com/repos/octocat/Hello-World/statuses/{sha}",
      "subscribers_url": "https://api.github.com/repos/octocat/Hello-World/subscribers",
      "subscription_url": "https://api.github.com/repos/octocat/Hello-World/subscription",
      "tags_url": "https://api.github.com/repos/octocat/Hello-World/tags",
      "teams_url": "https://api.github.com/repos/octocat/Hello-World/teams",
      "trees_url": "https://api.github.com/repos/octocat/Hello-World/git/trees{/sha}",
      "clone_url": "https://github.com/octocat/Hello-World.git",
      "mirror_url": "git:git.example.com/octocat/Hello-World",
      "hooks_url": "https://api.github.com/repos/octocat/Hello-World/hooks",
      "svn_url": "https://svn.github.com/octocat/Hello-World",
      "homepage": "https://github.com",
      "language": null,
      "forks_count": 9,
      "stargazers_count": 80,
      "watchers_count": 80,
      "size": 108,
      "default_branch": "master",
      "open_issues_count": 0,
      "is_template": false,
      "topics": [
        "octocat",
        "atom",
        "electron",
        "api"
      ],
      "has_issues": true,
      "has_projects": true,
      "has_wiki": true,
      "has_pages": false,
      "has_downloads": true,
      "archived": false,
      "disabled": false,
      "visibility": "public",
      "pushed_at": "2011-01-26T19:06:43Z",
      "created_at": "2011-01-26T19:01:12Z",
      "updated_at": "2011-01-26T19:14:43Z",
      "permissions": {
        "admin": false,
        "push": false,
        "pull": true
      },
      "template_repository": {
        "id": 1296269,
        "node_id": "MDEwOlJlcG9zaXRvcnkxMjk2MjY5",
        "name": "Hello-World-Template",
        "full_name": "octocat/Hello-World-Template",
        "owner": {
          "login": "octocat",
          "id": 1,
          "node_id": "MDQ6VXNlcjE=",
          "avatar_url": "https://github.com/images/error/octocat_happy.gif",
          "gravatar_id": "",
          "url": "https://api.github.com/users/octocat",
          "html_url": "https://github.com/octocat",
          "followers_url": "https://api.github.com/users/octocat/followers",
          "following_url": "https://api.github.com/users/octocat/following{/other_user}",
          "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
          "organizations_url": "https://api.github.com/users/octocat/orgs",
          "repos_url": "https://api.github.com/users/octocat/repos",
          "events_url": "https://api.github.com/users/octocat/events{/privacy}",
          "received_events_url": "https://api.github.com/users/octocat/received_events",
          "type": "User",
          "site_admin": false
        },
        "private": false,
        "html_url": "https://github.com/octocat/Hello-World-Template",
        "description": "This your first repo!",
        "fork": false,
        "url": "https://api.github.com/repos/octocat/Hello-World-Template",
        "archive_url": "https://api.github.com/repos/octocat/Hello-World-Template/{archive_format}{/ref}",
        "assignees_url": "https://api.github.com/repos/octocat/Hello-World-Template/assignees{/user}",
        "blobs_url": "https://api.github.com/repos/octocat/Hello-World-Template/git/blobs{/sha}",
        "branches_url": "https://api.github.com/repos/octocat/Hello-World-Template/branches{/branch}",
        "collaborators_url": "https://api.github.com/repos/octocat/Hello-World-Template/collaborators{/collaborator}",
        "comments_url": "https://api.github.com/repos/octocat/Hello-World-Template/comments{/number}",
        "commits_url": "https://api.github.com/repos/octocat/Hello-World-Template/commits{/sha}",
        "compare_url": "https://api.github.com/repos/octocat/Hello-World-Template/compare/{base}...{head}",
        "contents_url": "https://api.github.com/repos/octocat/Hello-World-Template/contents/{+path}",
        "contributors_url": "https://api.github.com/repos/octocat/Hello-World-Template/contributors",
        "deployments_url": "https://api.github.com/repos/octocat/Hello-World-Template/deployments",
        "downloads_url": "https://api.github.com/repos/octocat/Hello-World-Template/downloads",
        "events_url": "https://api.github.com/repos/octocat/Hello-World-Template/events",
        "forks_url": "https://api.github.com/repos/octocat/Hello-World-Template/forks",
        "git_commits_url": "https://api.github.com/repos/octocat/Hello-World-Template/git/commits{/sha}",
        "git_refs_url": "https://api.github.com/repos/octocat/Hello-World-Template/git/refs{/sha}",
        "git_tags_url": "https://api.github.com/repos/octocat/Hello-World-Template/git/tags{/sha}",
        "git_url": "git:github.com/octocat/Hello-World-Template.git",
        "issue_comment_url": "https://api.github.com/repos/octocat/Hello-World-Template/issues/comments{/number}",
        "issue_events_url": "https://api.github.com/repos/octocat/Hello-World-Template/issues/events{/number}",
        "issues_url": "https://api.github.com/repos/octocat/Hello-World-Template/issues{/number}",
        "keys_url": "https://api.github.com/repos/octocat/Hello-World-Template/keys{/key_id}",
        "labels_url": "https://api.github.com/repos/octocat/Hello-World-Template/labels{/name}",
        "languages_url": "https://api.github.com/repos/octocat/Hello-World-Template/languages",
        "merges_url": "https://api.github.com/repos/octocat/Hello-World-Template/merges",
        "milestones_url": "https://api.github.com/repos/octocat/Hello-World-Template/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/octocat/Hello-World-Template/notifications{?since,all,participating}",
        "pulls_url": "https://api.github.com/repos/octocat/Hello-World-Template/pulls{/number}",
        "releases_url": "https://api.github.com/repos/octocat/Hello-World-Template/releases{/id}",
        "ssh_url": "git@github.com:octocat/Hello-World-Template.git",
        "stargazers_url": "https://api.github.com/repos/octocat/Hello-World-Template/stargazers",
        "statuses_url": "https://api.github.com/repos/octocat/Hello-World-Template/statuses/{sha}",
        "subscribers_url": "https://api.github.com/repos/octocat/Hello-World-Template/subscribers",
        "subscription_url": "https://api.github.com/repos/octocat/Hello-World-Template/subscription",
        "tags_url": "https://api.github.com/repos/octocat/Hello-World-Template/tags",
        "teams_url": "https://api.github.com/repos/octocat/Hello-World-Template/teams",
        "trees_url": "https://api.github.com/repos/octocat/Hello-World-Template/git/trees{/sha}",
        "clone_url": "https://github.com/octocat/Hello-World-Template.git",
        "mirror_url": "git:git.example.com/octocat/Hello-World-Template",
        "hooks_url": "https://api.github.com/repos/octocat/Hello-World-Template/hooks",
        "svn_url": "https://svn.github.com/octocat/Hello-World-Template",
        "homepage": "https://github.com",
        "language": null,
        "forks": 9,
        "forks_count": 9,
        "stargazers_count": 80,
        "watchers_count": 80,
        "watchers": 80,
        "size": 108,
        "default_branch": "master",
        "open_issues": 0,
        "open_issues_count": 0,
        "is_template": true,
        "license": {
          "key": "mit",
          "name": "MIT License",
          "url": "https://api.github.com/licenses/mit",
          "spdx_id": "MIT",
          "node_id": "MDc6TGljZW5zZW1pdA==",
          "html_url": "https://api.github.com/licenses/mit"
        },
        "topics": [
          "octocat",
          "atom",
          "electron",
          "api"
        ],
        "has_issues": true,
        "has_projects": true,
        "has_wiki": true,
        "has_pages": false,
        "has_downloads": true,
        "archived": false,
        "disabled": false,
        "visibility": "public",
        "pushed_at": "2011-01-26T19:06:43Z",
        "created_at": "2011-01-26T19:01:12Z",
        "updated_at": "2011-01-26T19:14:43Z",
        "permissions": {
          "admin": false,
          "push": false,
          "pull": true
        },
        "allow_rebase_merge": true,
        "temp_clone_token": "ABTLWHOULUVAXGTRYU7OC2876QJ2O",
        "allow_squash_merge": true,
        "allow_auto_merge": false,
        "delete_branch_on_merge": true,
        "allow_merge_commit": true,
        "subscribers_count": 42,
        "network_count": 0
      }
    }
  },
  {
    "number": 1,
    "created_at": "2020-11-06T18:18:30Z",
    "url": "https://api.github.com/repos/owner/repo/secret-scanning/alerts/1",
    "html_url": "https://github.com/owner/repo/security/secret-scanning/1",
    "locations_url": "https://api.github.com/repos/owner/private-repo/secret-scanning/alerts/1/locations",
    "state": "open",
    "resolution": null,
    "resolved_at": null,
    "resolved_by": null,
    "secret_type": "mailchimp_api_key",
    "secret_type_display_name": "Mailchimp API Key",
    "secret": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-us2",
    "repository": {
      "id": 1296269,
      "node_id": "MDEwOlJlcG9zaXRvcnkxMjk2MjY5",
      "name": "Hello-World",
      "full_name": "octocat/Hello-World",
      "owner": {
        "login": "octocat",
        "id": 1,
        "node_id": "MDQ6VXNlcjE=",
        "avatar_url": "https://github.com/images/error/octocat_happy.gif",
        "gravatar_id": "",
        "url": "https://api.github.com/users/octocat",
        "html_url": "https://github.com/octocat",
        "followers_url": "https://api.github.com/users/octocat/followers",
        "following_url": "https://api.github.com/users/octocat/following{/other_user}",
        "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
        "organizations_url": "https://api.github.com/users/octocat/orgs",
        "repos_url": "https://api.github.com/users/octocat/repos",
        "events_url": "https://api.github.com/users/octocat/events{/privacy}",
        "received_events_url": "https://api.github.com/users/octocat/received_events",
        "type": "User",
        "site_admin": false
      },
      "private": false,
      "html_url": "https://github.com/octocat/Hello-World",
      "description": "This your first repo!",
      "fork": false,
      "url": "https://api.github.com/repos/octocat/Hello-World",
      "archive_url": "https://api.github.com/repos/octocat/Hello-World/{archive_format}{/ref}",
      "assignees_url": "https://api.github.com/repos/octocat/Hello-World/assignees{/user}",
      "blobs_url": "https://api.github.com/repos/octocat/Hello-World/git/blobs{/sha}",
      "branches_url": "https://api.github.com/repos/octocat/Hello-World/branches{/branch}",
      "collaborators_url": "https://api.github.com/repos/octocat/Hello-World/collaborators{/collaborator}",
      "comments_url": "https://api.github.com/repos/octocat/Hello-World/comments{/number}",
      "commits_url": "https://api.github.com/repos/octocat/Hello-World/commits{/sha}",
      "compare_url": "https://api.github.com/repos/octocat/Hello-World/compare/{base}...{head}",
      "contents_url": "https://api.github.com/repos/octocat/Hello-World/contents/{+path}",
      "contributors_url": "https://api.github.com/repos/octocat/Hello-World/contributors",
      "deployments_url": "https://api.github.com/repos/octocat/Hello-World/deployments",
      "downloads_url": "https://api.github.com/repos/octocat/Hello-World/downloads",
      "events_url": "https://api.github.com/repos/octocat/Hello-World/events",
      "forks_url": "https://api.github.com/repos/octocat/Hello-World/forks",
      "git_commits_url": "https://api.github.com/repos/octocat/Hello-World/git/commits{/sha}",
      "git_refs_url": "https://api.github.com/repos/octocat/Hello-World/git/refs{/sha}",
      "git_tags_url": "https://api.github.com/repos/octocat/Hello-World/git/tags{/sha}",
      "git_url": "git:github.com/octocat/Hello-World.git",
      "issue_comment_url": "https://api.github.com/repos/octocat/Hello-World/issues/comments{/number}",
      "issue_events_url": "https://api.github.com/repos/octocat/Hello-World/issues/events{/number}",
      "issues_url": "https://api.github.com/repos/octocat/Hello-World/issues{/number}",
      "keys_url": "https://api.github.com/repos/octocat/Hello-World/keys{/key_id}",
      "labels_url": "https://api.github.com/repos/octocat/Hello-World/labels{/name}",
      "languages_url": "https://api.github.com/repos/octocat/Hello-World/languages",
      "merges_url": "https://api.github.com/repos/octocat/Hello-World/merges",
      "milestones_url": "https://api.github.com/repos/octocat/Hello-World/milestones{/number}",
      "notifications_url": "https://api.github.com/repos/octocat/Hello-World/notifications{?since,all,participating}",
      "pulls_url": "https://api.github.com/repos/octocat/Hello-World/pulls{/number}",
      "releases_url": "https://api.github.com/repos/octocat/Hello-World/releases{/id}",
      "ssh_url": "git@github.com:octocat/Hello-World.git",
      "stargazers_url": "https://api.github.com/repos/octocat/Hello-World/stargazers",
      "statuses_url": "https://api.github.com/repos/octocat/Hello-World/statuses/{sha}",
      "subscribers_url": "https://api.github.com/repos/octocat/Hello-World/subscribers",
      "subscription_url": "https://api.github.com/repos/octocat/Hello-World/subscription",
      "tags_url": "https://api.github.com/repos/octocat/Hello-World/tags",
      "teams_url": "https://api.github.com/repos/octocat/Hello-World/teams",
      "trees_url": "https://api.github.com/repos/octocat/Hello-World/git/trees{/sha}",
      "clone_url": "https://github.com/octocat/Hello-World.git",
      "mirror_url": "git:git.example.com/octocat/Hello-World",
      "hooks_url": "https://api.github.com/repos/octocat/Hello-World/hooks",
      "svn_url": "https://svn.github.com/octocat/Hello-World",
      "homepage": "https://github.com",
      "language": null,
      "forks_count": 9,
      "stargazers_count": 80,
      "watchers_count": 80,
      "size": 108,
      "default_branch": "master",
      "open_issues_count": 0,
      "is_template": false,
      "topics": [
        "octocat",
        "atom",
        "electron",
        "api"
      ],
      "has_issues": true,
      "has_projects": true,
      "has_wiki": true,
      "has_pages": false,
      "has_downloads": true,
      "archived": false,
      "disabled": false,
      "visibility": "public",
      "pushed_at": "2011-01-26T19:06:43Z",
      "created_at": "2011-01-26T19:01:12Z",
      "updated_at": "2011-01-26T19:14:43Z",
      "permissions": {
        "admin": false,
        "push": false,
        "pull": true
      },
      "template_repository": {
        "id": 1296269,
        "node_id": "MDEwOlJlcG9zaXRvcnkxMjk2MjY5",
        "name": "Hello-World-Template",
        "full_name": "octocat/Hello-World-Template",
        "owner": {
          "login": "octocat",
          "id": 1,
          "node_id": "MDQ6VXNlcjE=",
          "avatar_url": "https://github.com/images/error/octocat_happy.gif",
          "gravatar_id": "",
          "url": "https://api.github.com/users/octocat",
          "html_url": "https://github.com/octocat",
          "followers_url": "https://api.github.com/users/octocat/followers",
          "following_url": "https://api.github.com/users/octocat/following{/other_user}",
          "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
          "organizations_url": "https://api.github.com/users/octocat/orgs",
          "repos_url": "https://api.github.com/users/octocat/repos",
          "events_url": "https://api.github.com/users/octocat/events{/privacy}",
          "received_events_url": "https://api.github.com/users/octocat/received_events",
          "type": "User",
          "site_admin": false
        },
        "private": false,
        "html_url": "https://github.com/octocat/Hello-World-Template",
        "description": "This your first repo!",
        "fork": false,
        "url": "https://api.github.com/repos/octocat/Hello-World-Template",
        "archive_url": "https://api.github.com/repos/octocat/Hello-World-Template/{archive_format}{/ref}",
        "assignees_url": "https://api.github.com/repos/octocat/Hello-World-Template/assignees{/user}",
        "blobs_url": "https://api.github.com/repos/octocat/Hello-World-Template/git/blobs{/sha}",
        "branches_url": "https://api.github.com/repos/octocat/Hello-World-Template/branches{/branch}",
        "collaborators_url": "https://api.github.com/repos/octocat/Hello-World-Template/collaborators{/collaborator}",
        "comments_url": "https://api.github.com/repos/octocat/Hello-World-Template/comments{/number}",
        "commits_url": "https://api.github.com/repos/octocat/Hello-World-Template/commits{/sha}",
        "compare_url": "https://api.github.com/repos/octocat/Hello-World-Template/compare/{base}...{head}",
        "contents_url": "https://api.github.com/repos/octocat/Hello-World-Template/contents/{+path}",
        "contributors_url": "https://api.github.com/repos/octocat/Hello-World-Template/contributors",
        "deployments_url": "https://api.github.com/repos/octocat/Hello-World-Template/deployments",
        "downloads_url": "https://api.github.com/repos/octocat/Hello-World-Template/downloads",
        "events_url": "https://api.github.com/repos/octocat/Hello-World-Template/events",
        "forks_url": "https://api.github.com/repos/octocat/Hello-World-Template/forks",
        "git_commits_url": "https://api.github.com/repos/octocat/Hello-World-Template/git/commits{/sha}",
        "git_refs_url": "https://api.github.com/repos/octocat/Hello-World-Template/git/refs{/sha}",
        "git_tags_url": "https://api.github.com/repos/octocat/Hello-World-Template/git/tags{/sha}",
        "git_url": "git:github.com/octocat/Hello-World-Template.git",
        "issue_comment_url": "https://api.github.com/repos/octocat/Hello-World-Template/issues/comments{/number}",
        "issue_events_url": "https://api.github.com/repos/octocat/Hello-World-Template/issues/events{/number}",
        "issues_url": "https://api.github.com/repos/octocat/Hello-World-Template/issues{/number}",
        "keys_url": "https://api.github.com/repos/octocat/Hello-World-Template/keys{/key_id}",
        "labels_url": "https://api.github.com/repos/octocat/Hello-World-Template/labels{/name}",
        "languages_url": "https://api.github.com/repos/octocat/Hello-World-Template/languages",
        "merges_url": "https://api.github.com/repos/octocat/Hello-World-Template/merges",
        "milestones_url": "https://api.github.com/repos/octocat/Hello-World-Template/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/octocat/Hello-World-Template/notifications{?since,all,participating}",
        "pulls_url": "https://api.github.com/repos/octocat/Hello-World-Template/pulls{/number}",
        "releases_url": "https://api.github.com/repos/octocat/Hello-World-Template/releases{/id}",
        "ssh_url": "git@github.com:octocat/Hello-World-Template.git",
        "stargazers_url": "https://api.github.com/repos/octocat/Hello-World-Template/stargazers",
        "statuses_url": "https://api.github.com/repos/octocat/Hello-World-Template/statuses/{sha}",
        "subscribers_url": "https://api.github.com/repos/octocat/Hello-World-Template/subscribers",
        "subscription_url": "https://api.github.com/repos/octocat/Hello-World-Template/subscription",
        "tags_url": "https://api.github.com/repos/octocat/Hello-World-Template/tags",
        "teams_url": "https://api.github.com/repos/octocat/Hello-World-Template/teams",
        "trees_url": "https://api.github.com/repos/octocat/Hello-World-Template/git/trees{/sha}",
        "clone_url": "https://github.com/octocat/Hello-World-Template.git",
        "mirror_url": "git:git.example.com/octocat/Hello-World-Template",
        "hooks_url": "https://api.github.com/repos/octocat/Hello-World-Template/hooks",
        "svn_url": "https://svn.github.com/octocat/Hello-World-Template",
        "homepage": "https://github.com",
        "language": null,
        "forks": 9,
        "forks_count": 9,
        "stargazers_count": 80,
        "watchers_count": 80,
        "watchers": 80,
        "size": 108,
        "default_branch": "master",
        "open_issues": 0,
        "open_issues_count": 0,
        "is_template": true,
        "license": {
          "key": "mit",
          "name": "MIT License",
          "url": "https://api.github.com/licenses/mit",
          "spdx_id": "MIT",
          "node_id": "MDc6TGljZW5zZW1pdA==",
          "html_url": "https://api.github.com/licenses/mit"
        },
        "topics": [
          "octocat",
          "atom",
          "electron",
          "api"
        ],
        "has_issues": true,
        "has_projects": true,
        "has_wiki": true,
        "has_pages": false,
        "has_downloads": true,
        "archived": false,
        "disabled": false,
        "visibility": "public",
        "pushed_at": "2011-01-26T19:06:43Z",
        "created_at": "2011-01-26T19:01:12Z",
        "updated_at": "2011-01-26T19:14:43Z",
        "permissions": {
          "admin": false,
          "push": false,
          "pull": true
        },
        "allow_rebase_merge": true,
        "temp_clone_token": "ABTLWHOULUVAXGTRYU7OC2876QJ2O",
        "allow_squash_merge": true,
        "allow_auto_merge": false,
        "delete_branch_on_merge": true,
        "allow_merge_commit": true,
        "subscribers_count": 42,
        "network_count": 0
      }
    }
  }
]
#>
Function List-SecretScanningAlertsForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$secret_type,
		[Parameter(Mandatory=$FALSE)][string]$resolution,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$before,
		[Parameter(Mandatory=$FALSE)][string]$after
    )
    $Querys = @()
    $QueryStrings = @(
        "state",
		"secret_type",
		"resolution",
		"per_page",
		"before",
		"after"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/secret-scanning/alerts?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/secret-scanning/alerts"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
