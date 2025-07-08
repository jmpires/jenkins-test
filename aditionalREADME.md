# This adds GitHub and Localhost to the known_hosts folder
sudo ssh-keyscan -H localhost | sudo tee /var/lib/jenkins/.ssh/known_hosts
sudo ssh-keyscan -t ed25519 github.com | sudo tee -a /var/lib/jenkins/.ssh/known_hosts
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh
sudo chmod 700 /var/lib/jenkins/.ssh
sudo chmod 600 /var/lib/jenkins/.ssh/known_hosts


sudo cat /var/lib/jenkins/.ssh/id_ed25519.pub


# Post-Run Verification:
sudo -u jenkins ssh jmpires@localhost # I think this is already checked ...
sudo -u jenkins ssh -T git@github.com


# Post-Run Verification:
sudo -u jenkins ssh jmpires@localhost