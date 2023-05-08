#!/bin/bash -ex
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Install packages:
yum update -y;
yum install htop -y;
yum install httpd -y;

#SSM agent
yum install amazon-ssm-agent -y
systemctl enable amazon-ssm-agent
systemctl enable amazon-ssm-agent


# Configure hostname:
hostnamectl set-hostname gwlb-spoke-1-client-1;

# Configure SSH client alive interval for ssh session timeout:
echo 'ClientAliveInterval 60' | sudo tee --append /etc/ssh/sshd_config;
service sshd restart;

# Set dark background for vim:
touch /home/ec2-user/.vimrc;
echo "set background=dark" >> /home/ec2-user/.vimrc;

# Define variables:
curl http://169.254.169.254/latest/dynamic/instance-identity/document > /home/ec2-user/iid
export instance_az=$(cat /home/ec2-user/iid |grep 'availability' | awk -F': ' '{print $2}' | awk -F',' '{print $1}');

# Start httpd and configure index.html:
systemctl start httpd
touch /var/www/html/index.html
echo "<html>" >> /var/www/html/index.html
echo "  <head>" >> /var/www/html/index.html
echo "    <title>Gateway Load Balancer Endpoint POC</title>" >> /var/www/html/index.html
echo "    <meta http-equiv='Content-Type' content='text/html; charset=ISO-8859-1'>" >> /var/www/html/index.html
echo "  </head>" >> /var/www/html/index.html
echo "  <body>" >> /var/www/html/index.html
echo "    <h1>Welcome to Spoke VPC: GWLB Endpoint POC:</h1>" >> /var/www/html/index.html
echo "    <h2>This is application running in $instance_az. Happy testing!</h2>" >> /var/www/html/index.html
echo "  </body>" >> /var/www/html/index.html
echo "</html>" >> /var/www/html/index.html