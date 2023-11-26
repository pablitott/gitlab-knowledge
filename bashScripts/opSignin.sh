# Install 1password if it does not exists
opExists=$(sudo yum list 1password 2>/dev/null)
error=$?
if [ "$error" != 0 ]; then
  # 1password is not installed
  echo "1password is not installed, installing ..."
  sudo yum install -y https://downloads.1password.com/linux/rpm/stable/x86_64/1password-cli-latest.x86_64.rpm
fi

# check if we are signin into 1password?

op whoami &>/dev/null
error=$?
if [ $error != 0 ]; then
    # in case errorwe are not signed in
    echo "Signin into 1password account $OP_ACCOUNT"
    eval $(echo $OP_PASSWORD | \
    op account add \
    --address $OP_ACCOUNT \
    --email $OP_EMAIL \
    --secret-key $OP_SECRET_KEY \
    --shorthand "personal_account" \
    --signin)
    error=$?
    if [ $error != 0 ]; then 
      echo "Error signin into 1password account $OP_ACCOUNT"
      return 1
    fi 
fi 
echo "1password settings..."
 op account get
echo ""

