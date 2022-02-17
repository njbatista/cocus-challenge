#!/bin/bash
yum update -y        # Update each package already installed
yum install -y httpd # Install pache
service httpd start  # Start apache
echkconfig httpd on   # Start apache whenever the VM starts up
echo "My web server configured with Terraform!" > /var/www/html/index.html # Create a file called index.html in the webserver's root directory 