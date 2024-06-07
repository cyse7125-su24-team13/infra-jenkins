#!/bin/bash

# Start and enable Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Create directory for Let's Encrypt challenge
sudo mkdir -p /var/www/html/.well-known/acme-challenge/
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

# Configure Nginx
sudo rm -f /etc/nginx/sites-enabled/default
sudo bash -c 'cat > /etc/nginx/sites-available/jenkins.rahhulganeesh.me <<EOF
server {
    listen 80;
    server_name jenkins.rahhulganeesh.me;
    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;

        # Timeout settings
        proxy_connect_timeout 600;  
        proxy_send_timeout 600;     
        proxy_read_timeout 600;    
        proxy_buffers 16 32k;       
        proxy_buffer_size 64k;
    }
}
EOF'
sudo ln -s /etc/nginx/sites-available/jenkins.rahhulganeesh.me /etc/nginx/sites-enabled/
sudo systemctl restart nginx
