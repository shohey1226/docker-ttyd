#!/bin/bash +x

useradd -m -d /home/$USERNAME -s /bin/bash -p $(echo $PASSWORD | openssl passwd -1 -stdin) $USERNAME
chown $USERNAME:$USERNAME /home/$USERNAME 

# Enable user to sudo 
usermod -aG sudo $USERNAME
# no need to ask password
echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#su -c "ttyd -c $USERNAME:$PASSWORD --ssl --ssl-cert $LETSDIR/live/devany.app/cert.pem --ssl-key $LETSDIR/live/devany.app/privkey.pem bash" - $USERNAME
su -c "ttyd -c $USERNAME:$PASSWORD -ssl-cert /etc/letsencrypt/live/devany.app/cert.pem  bash" - $USERNAME

