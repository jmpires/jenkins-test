# Links
https://spacelift.io/blog/jenkins-tutorial?ref=dailydev
https://mahira-technology.medium.com/mastering-jenkins-a-step-by-step-guide-to-ci-cd-implementation-bd1b5b7a31df


# Simple command sequence to install Jenkins (compare it with the script in the current folder)

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

+   Install also the following plugin to allow to view the deployment progress in graphical mode: <Pipeline Stage View Plugin>
    - Manage Jenkins -> Available plugins -> search for <Pipeline Stage View Plugin> -> checkbox Install -> Install
    - Restart Jenkins in terminal with <sudo systemctl restart jenkins>

# Jenkins setup remarks

Username: admin
Password: xpto/xpto
Full Name: e.g. ubuntuLab
email: jorgepires.email@gmail.com

# Nodes
A node is a Jenkins execution environment, and an agent is a node that Jenkins uses to run builds, tests, or deployments, usually separate from the controller.

+   Build a new node: Manage Jenkins -> Nodes -> New Node -> <Node Name> -> <Permanent agent> -> Create
    - In the Remote root directory specify a directory, e.g.(could be done after create the new node but before run into the new agent):
    sudo mkdir -p /opt/<folder=NodeName>
    sudo chown -R <current linux user>:<current linux user> /opt/<folder=NodeName>
    -> Save

    - To activate a node (Remote root directory should be already created and usable):
    click Node Name -> Status -> <copy the code accordingly the OS and execute it in a terminal window> 

+ To use the new node in the Jenkins pipeline code:
    pipeline {
    agent { label '<Agent Name' }
    ... }


# Step-by-Step repo & pipeline creation
mkdir jenkins-test && cd jenkins-test





# TO Check and ADD Information:

# Main Git Hub 4 [01] - Hands-On Continuous Integration and Automation with Jenkins
https://github.com/cirulls/hands-on-jenkins

https://github.com/cirulls/hands-on-jenkins/tree/master/section_2/exercises
https://github.com/wakaleo/game-of-life

https://medium.com/@marc_best/trigger-a-jenkins-build-from-a-github-push-b922468ef1ae
https://kohsuke.org/2011/12/01/polling-must-die-triggering-jenkins-builds-from-a-git-hook/



# TODO

## Check original script and install it in the current VM's

# Install Git
sudo apt install git -y
# Update package index
sudo apt update
# Install Docker dependencies
sudo apt install -y ca-certificates curl gnupg lsb-release
# Add Docker’s official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# Set up Docker stable repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Update package index again with Docker repo
sudo apt update
# Install Docker Engine and related tools
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Add Jenkins user to the docker group
sudo usermod -aG docker jenkins
# --- Optional: Apply group change without reboot ---
# Stop Jenkins to avoid using old session with outdated groups
sudo systemctl stop jenkins
# Enable lingering for Jenkins user so we can log in as them
sudo loginctl enable-linger jenkins
# Switch to Jenkins user with a fresh login shell
sudo su - jenkins <<EOF
echo "Testing Docker access from fresh Jenkins shell..."
docker --version
EOF
# Start Jenkins again with updated environment
sudo systemctl start jenkins
# Final check: verify Jenkins sees Docker
sudo -u jenkins docker --version









# Configure global user name & email for local user and jenkins
# For your VM user
git config --global user.email "jorgepires.email@gmail.com"
git config --global user.name "jmpires"
# For Jenkins user
sudo -u jenkins git config --global user.email "jorgepires.email@gmail.com"
sudo -u jenkins git config --global user.name "jmpires"


# Add ssh key to Github to allow to Jenkins connect
ssh-keygen -t rsa -b 4096 -C "jorgepires.email@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
Then go to GitHub:
Settings > SSH and GPG keys > New SSH key
Paste the public key there

# Add Jenkins user to known_hosts so Jenkins can connect to GitHub via SSH
sudo ssh-keyscan -t ed25519 github.com | sudo tee /var/lib/jenkins/.ssh/known_hosts
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh
sudo chmod 700 /var/lib/jenkins/.ssh
sudo chmod 644 /var/lib/jenkins/.ssh/known_hosts

# Add a deploy ssh key To Jenkins 2 be used in the deploy section of the pipelines
ssh-keygen -t rsa -b 4096 -C "jenkins-deploy" -f ~/.ssh/jenkins_deploy_key
cat ~/.ssh/jenkins_deploy_key

Then go to Jenkins:
Go to Manage Jenkins → Credentials → (global) → Add Credentials
Kind: SSH Username with private key
ID: deploy-key ✅ (or another ID you’ll refer to in the pipeline)
Description: SSH key for Jenkins deployment to production server
Username: user (same as the one you used above)
Private Key: Choose "Enter directly", then paste the contents of:
cat ~/.ssh/jenkins_deploy_key


1. A universal email account for my labs;
2. Improve current script in folder;
3. Automate the full process of jenkins install and setup + the <Pipeline Stage View Plugin> + <Docker Pipeline>;
4. Jenkins need 2 be authenticated in Docker with password/(TOKEN vmJenkins created) - In Jenkins file use as possible the <dockerhub-cred> iD);
