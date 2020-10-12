#! /bin/bash
sudo yum update -y 
sudo amazon-linux-extras install epel -y 
sudo yum install stress -y 
sudo yum install -y httpd  
&& sudo systemctl start httpd  
&& sudo systemctl enable httpd 
&& echo "<h1>Hello ENCS691k Class</h1>" | sudo tee /var/www/html/index.html