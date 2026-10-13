# AGENTS.md

This repo is public. Keep customer names and platform internals out of code, comments and commits. Link back to the tracking issue instead.

## Publish workflows

- Look up upstream releases with an authenticated `gh api ... --jq .tag_name` (`GH_TOKEN: ${{ github.token }}`). Never use an unauthenticated `curl` to the GitHub API: the shared runner rate limit makes it return `null`, and the build then pulls a `:null` tag.
- Guard every resolved version with `^v[0-9]+\.[0-9]+\.[0-9]+$` before writing it to `$GITHUB_OUTPUT`. Pass step outputs into `run:` through `env:`, never inline `${{ }}`.
- The default shell is `bash -e` without pipefail, so assign a `gh` call on its own line before piping its output.
- Terragrunt tags are `opentofu_<version>`. Compare against that prefix, or the image rebuilds every night.
- Atlantis copies tofu, terragrunt and sops `--from` a `terragrunt:opentofu_<ver>` tag. Both images build in parallel on push, so bump that tag in a separate PR, merged after the terragrunt image has republished it.
- Pin actions to a full commit SHA with a `# vX.Y.Z` comment.
- Use `curl -fsSL` for downloads in Dockerfiles, and verify each download against the upstream checksum file.

## Slack notifications

- Each publish workflow has a separate `notify` job with `environment: slack` and `permissions: {}`.
- The webhook is the environment secret `SLACK_WEBHOOK_URL`. The `slack` environment allows only the `master` branch, so PRs and branches can't read the secret.
- Don't move the secret to a repo or org secret, don't reference it from build jobs, and don't add `pull_request_target` workflows.
