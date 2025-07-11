

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


# -------------------------------------------------------------------------------------------------------------------------------------------------


# Jenkins aditional info

## Nodes
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


# TODO

1. A universal email account for my labs;
2. Improve current script in folder;
3. Automate the full process of jenkins install and setup + the <Pipeline Stage View Plugin> + <Docker Pipeline>;
4. Jenkins need 2 be authenticated in Docker with password/(TOKEN vmJenkins created) - In Jenkins file use as possible the <dockerhub-cred> iD);
