#!/bin/bash
              yum update -y
              yum install -y docker
              service docker start
              usermod -a -G docker ec2-user
              curl -sL https://rpm.nodesource.com/setup_20.x | bash -
              yum install -y nodejs
              git clone https://github.com/ClementDaniel/Node.js-website/home/ec2-user/my-node-app
              cd /home/ec2-user/my-node-app
              docker build -t my-node-app .
              docker run -d -p 8080:8080 my-node-app 
              EOF

               