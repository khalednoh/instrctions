============= Install Java  ===========
apt install default-jre
apt install default-jdk

============= Install Maven ===========
apt install maven

============= Install Git==============
apt-get install git

============= Install Jenkins =========

wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -

sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

apt update

apt install jenkins

systemctl start jenkins

systemctl status jenkins
	
