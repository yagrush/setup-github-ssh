#!/bin/bash

source ./setting.sh
cat - << EOS >> ~/.ssh/config
Host github.com
  HostName github.com
  IdentityFile ~/.ssh/id_rsa.GitHub_$GIT_USER
  User git
EOS
chmod 600 ~/.ssh/config
chown `whoami` ~/.ssh/config

cat - << EOS > ~/ssh-github.sh
#!/bin/bash
expect -c "
spawn ssh -T github.com
expect \"Are you sure you want to continue connecting (yes/no)?\"
send \"yes\n\"
expect \"$\"
exit 0
"
EOS
chmod +x ~/ssh-github.sh
~/ssh-github.sh
rm -f ~/ssh-github.sh

