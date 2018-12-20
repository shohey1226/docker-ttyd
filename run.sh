#!/bin/bash 

useradd -m -d /home/$USERNAME -s /bin/bash -p $(echo $PASSWORD | openssl passwd -1 -stdin) $USERNAME
chown $USERNAME:$USERNAME /home/$USERNAME 

# Enable user to sudo 
usermod -aG sudo $USERNAME
usermod -aG root $USERNAME
# no need to ask password
echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

export LETSDIR=/etc/letsencrypt/live/$DOMAIN

cd ~/ 
#cat $LETSDIR/cert.pem
runuser -l $USERNAME -c "ttyd -d 6 -c $USERNAME:$PASSWORD -S -C $LETSDIR/cert.pem -K $LETSDIR/privkey.pem bash"

