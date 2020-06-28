#!/bin/bash

source ./setting.sh
sudo yum install -y expect git
export SSH_KEY_NAME="$HOME/.ssh/id_rsa.GitHub_$GIT_USER"

cat - << EOS > ~/ssh-kg.sh
#!/bin/bash
expect -c "
spawn ssh-keygen -t rsa -b 4096 -C \"$GIT_EMAIL\" -f $SSH_KEY_NAME
expect \"Enter passphrase (empty for no passphrase):\"
send \"\n\"
expect \"Enter same passphrase again:\"
send \"\n\"
expect \"$\"
exit 0
"
EOS
chmod +x ~/ssh-kg.sh
~/ssh-kg.sh
rm -f ~/ssh-kg.sh

chmod 644 $SSH_KEY_NAME.pub
chmod 600 $SSH_KEY_NAME
cat $SSH_KEY_NAME.pub
