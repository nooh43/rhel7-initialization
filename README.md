# AWS RHEL 7 Initialization
Version : 0.1.0  
One script that does it all, updates your system, enable required repos, install essential packages, and more..

###### Features:
- Update your system
- Enable additional repos (extra, optional, supplementary, rhscl)
- Enable/Add EPEL
- Setup FQDN
- Change root password
- Install essential packages (nano, wget)

###### How to use
1. Login as root
`sudo su`
2. Install git
`sudo yum -y install git`
3. Clone the repository 
`git clone https://github.com/nooh43/rhel7-initialization.git`
4. Browse the folder
`cd rhel7-initialization`
5. Give the permissions
`chmod +x setup.sh`
6. Launch the script
`./setup.sh`

###### Author
Nasser Alhumood - [QatifServ](http://qatifserv.com/)