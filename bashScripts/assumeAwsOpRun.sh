SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"
SCRIPT_PATH="$(cd -- "$MY_PATH" && pwd)"

op whoami &>/dev/null
error=$?
if [[ "$error" != 0 ]]; then 
  echo "You are not signed in 1Password, see $SCRIPT_PATH/opSignin.sh to sign "
  return 1
fi 

# https://developer.1password.com/docs/cli/secrets-scripts/#option-1-use-op-run-to-load-secrets-into-the-environment
# Method 2 to run aws commands
echo "test connection"
# following command is a =n example to use op run
opEnvironment="$SCRIPT_PATH/icloudUser.env"

if [[ -f $opEnvironment ]]; then
  echo "AWS connection Identity"
  op run --env-file $opEnvironment aws sts get-caller-identity
else
  echo "file $opEnvironment does not exists, see $SCRIPT_PATH/assumeAwsOp.sh to create one"
fi 


