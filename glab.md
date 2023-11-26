# glab app
[main source](https://gitlab.com/gitlab-org/cli/-/tree/main)
[source](https://www.thegeekdiary.com/glab-auth-command-examples/)
use glab to run commands from gitlab server

```bash
# login into gitlab
glab auth login --hostname gitlab.sgssnrl.network --stdin < sgssnrl-token

glab config set --global git_protocol --host gitlab.sgssnrl.network ssh
glab ssh-key list --show-id

glab ssh-key get 75 > ~/.ssh/id_gitlab_rsa
chmod 0600 ~/.ssh/id_rsa_gitlab

eval `ssh-agent`
ssh-add ~/.ssh/id_rsa_gitlab

ssh -T git@gitlab.sgssnrl.network
```