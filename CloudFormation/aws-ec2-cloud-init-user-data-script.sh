#!/bin/bash

# Make cloud-init run this script on every boot, not just first boot
cat > /etc/cloud/cloud.cfg.d/99-custom.cfg << 'EOF'
cloud_final_modules:
- [scripts-user, always]
EOF

# Log the execution time
echo "Running user data script at $(date)" >> /var/log/boot-script.log

# Change ec2-user password
# Generate a random password or set your own
NEW_PASSWORD="YourNewStrongPassword123!"  # Replace with your desired password

# Update the password for ec2-user
echo "ec2-user:$NEW_PASSWORD" | chpasswd

# Log that password was changed (don't log the actual password)
echo "Password for ec2-user was updated at $(date)" >> /var/log/boot-script.log

# Optionally force password change on next login
# chage -d 0 ec2-user

# Make sure password authentication is enabled in SSH
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd

echo "SSH password authentication enabled" >> /var/log/boot-script.log

# Output the password to a secure location on the instance
# (you can retrieve it via SSH or console if needed)
echo "New password for ec2-user: $NEW_PASSWORD" > /root/ec2-user-password.txt
chmod 600 /root/ec2-user-password.txt
