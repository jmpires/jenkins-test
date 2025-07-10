# Reference Links
https://spacelift.io/blog/jenkins-tutorial?ref=dailydev
https://mahira-technology.medium.com/mastering-jenkins-a-step-by-step-guide-to-ci-cd-implementation-bd1b5b7a31df


# Jenkins

## Install Jenkins
```
sudo apt update
sudo apt install openjdk-17-jdk -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
 /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
 https://pkg.jenkins.io/debian binary/" | sudo tee \
 /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y

sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

## Jenkins Configuration
```
Username: admin
Password: xpto/xpto
Full Name: e.g. ubuntuLab
email: jorgepires.email@gmail.com
```

## PlugIn Configuration
+   Install the following plugin to allow to view the deployment progress in graphical mode: 
    - Manage Jenkins -> Available plugins -> Search for: ```Pipeline Stage View Plugin``` -> checkbox Install -> Install
    - Restart Jenkins in terminal with ```sudo systemctl restart jenkins```

