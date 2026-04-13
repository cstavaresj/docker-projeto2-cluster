#!/bin/bash
sudo ufw disable
# Agora usando o IP 192.168.56.100
sudo docker swarm init --advertise-addr 192.168.56.100
# Gera o token para a pasta compartilhada
echo "#!/bin/bash" > /vagrant/worker.sh
sudo docker swarm join-token worker | grep "docker swarm join" >> /vagrant/worker.sh