SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"
SCRIPT_PATH="$(cd -- "$MY_PATH" && pwd)"

op whoami &>/dev/null
error=$?
if [[ "$error" != 0 ]]; then 
  echo "You are not signed in 1Password, see opSignin.sh to sign "
  return 1
fi 

# https://developer.1password.com/docs/cli/secrets-scripts/#option-1-use-op-run-to-load-secrets-into-the-environment
# Method 1 to run aws commands
# following lines were moved to file ./opScripts/icloudUser.env
export AWS_ACCESS_KEY_ID="$(op read 'op://automation/aws icloud/access key id')"
export AWS_SECRET_ACCESS_KEY="$(op read 'op://automation/aws icloud/secret access key')"
export AWS_DEFAULT_REGION="$(op read 'op://automation/aws icloud/region')"
opEnvironment="$SCRIPT_PATH/icloudUser.env"

if [[ ! -f $opEnvironment ]]; then
  # prepare the environment file
  echo 'AWS_ACCESS_KEY_ID=op://automation/aws icloud/access key id' > $SCRIPT_PATH/icloudUser.env
  echo 'AWS_SECRET_ACCESS_KEY=op://automation/aws icloud/secret access key' >> $SCRIPT_PATH/opScripts/icloudUser.env
  echo 'AWS_DEFAULT_REGION=op://automation/aws icloud/region' >> $SCRIPT_PATH/icloudUser.env
fi 
aws sts get-caller-identity
# source $SCRIPT_PATH/assumeNone.sh '^AWS_*'


