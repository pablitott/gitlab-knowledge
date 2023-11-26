# awsLightSail project
## Goal
  This project is a work to automate AWS LightSail instances

## Knowlege
### AWS Scripts
using: aws sts get-caller-identity
{
    "UserId": "AIDA2BKRFWRAFQGPWEU6E",
    "Account": "690049365056",
    "Arn": "arn:aws:iam::690049365056:user/pablito"
}
Account Name: Pablo-Personal
for AWS credentials see 1password
aws lightsail get-instances
  aws lightsail get-instances | jq '.[][0].name'

aws lightsail get-instance-state --instance-name "Ubuntu-2"
  aws lightsail get-instance-state --instance-name "Ubuntu-2" | jq '.state.name'

aws lightsail stop-instance      --instance-name "Ubuntu-2" | jq '.[][0].status'

aws lightsail start-instance      --instance-name "Ubuntu-2" | jq '.[][0].status'

### Python
- pipenv
  Create a virtual environment for python
  - [init.sh](./init.sh)

- 1password cli (op)
  Automate retrieve 1 password items
  - [opSignin.sh](./bashScripts/opSignin.sh)
  - [assumeAwsOp.sh](./bashScripts/assumeAwsOp.sh)
  - [opSignOut.sh](./bashScripts/opSignOut.sh)


- 1password python
  - [python 1password](https://developer.1password.com/docs/cli/reference/management-commands/connect/#connect-token)

- python aws  
  Use Python to handle LightSail instances


### 1Password
[main source](https://developer.1password.com/docs/cli)  
1Password pluin is used to authenticate with 3rd party, e.g.
- op plugin list   
  List of plugins  
- op plugin init aws  
  shows options to get the op items or import into op
- op plugin glab
  prompts for the token to authenticate with gitlab



---
#### Connect to 1password
```bash
op account add --address $OP_ACCOUNT --email $OP_EMAIL --secret-key $OP_SECRET_KEY --signin
```

you can grant access to 1password using tokens, use the following link to create tokens
[1password connect token](https://developer.1password.com/docs/cli/reference/management-commands/connect/#connect-token)

```bash
#get the first active server
  serverName=$(op connect server list | awk "NR==2{print;exit}" | awk -F' ' '{print $2}')
  vaultName=automation

  op connect vault grant --server $serverName --vault $vaultName
  error=$?
  if [[ "$error" == 0 ]]; then
    export OP_TOKEN=$(op connect token create lightsail_token --server $serverName --vault "$vaultName,r")
  fi 
```

### gitlab cli
[source](https://developer.1password.com/docs/cli/shell-plugins/gitlab/)
[source](https://docs.gitlab.com/ee/editor_extensions/gitlab_cli/index.html)