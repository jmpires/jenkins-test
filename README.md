# Reference Links
```
https://spacelift.io/blog/jenkins-tutorial?ref=dailydev
https://mahira-technology.medium.com/mastering-jenkins-a-step-by-step-guide-to-ci-cd-implementation-bd1b5b7a31df
https://medium.com/@marc_best/trigger-a-jenkins-build-from-a-github-push-b922468ef1ae
```

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
### Defining Username/Password/eMail
```
Username: admin
Password: xpto/xpto
Full Name: e.g. ubuntuLab
email: jorgepires.email@gmail.com
```

### PlugIn Configuration
+   Install the following plugin to allow to view the deployment progress in graphical mode: 
    - Manage Jenkins -> Available plugins -> Search for: ```Pipeline Stage View Plugin``` -> checkbox Install -> Install
    - Restart Jenkins in terminal with ```sudo systemctl restart jenkins```


### Configure Global User & eMail for local user & jenkins
+ For your VM user
```
git config --global user.email "jorgepires.email@gmail.com"
git config --global user.name "jmpires"
```
+ For Jenkins user
```
sudo -u jenkins git config --global user.email "jorgepires.email@gmail.com"
sudo -u jenkins git config --global user.name "jmpires"
```

# Git & Docker

## Install Git & Docker
```
sudo apt install git -y
sudo apt update

sudo apt install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
ARCH=$(dpkg --print-architecture)
RELEASE=$(lsb_release -cs)
echo "deb [arch=$ARCH signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $RELEASE stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker jenkins
sudo systemctl stop jenkins
sudo loginctl enable-linger jenkins

sudo su - jenkins <<EOF
echo "Testing Docker access from fresh Jenkins shell..."
docker info
EOF

sudo systemctl start jenkins
sudo -u jenkins docker info
```

# SSH local Server

## Install SSH Server
```
sudo apt update
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
sudo systemctl status ssh
systemctl list-units --type=service | grep ssh

# Confirm port 22 is open and listening
sudo ss -tuln | grep :22
# Or test SSH locally
ssh localhost
```

## Local SSH server Command Summary
```
sudo systemctl start ssh      # start the SSH server
sudo systemctl stop ssh       # stop the SSH server
sudo systemctl restart ssh    # restart the SSH server
sudo systemctl enable ssh     # enable it to start on boot
sudo systemctl disable ssh    # disable auto-start on boot
sudo systemctl status ssh     # check SSH server status
```