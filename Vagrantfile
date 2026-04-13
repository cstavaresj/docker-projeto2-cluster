# -*- mode: ruby -*-
# vi: set ft=ruby :

machines = {
  "master" => {"memory" => "1024", "cpu" => "1", "ip" => "100", "image" => "bento/ubuntu-24.04"},
  "node01" => {"memory" => "1024", "cpu" => "1", "ip" => "101", "image" => "bento/ubuntu-24.04"},
  "node02" => {"memory" => "1024", "cpu" => "1", "ip" => "102", "image" => "bento/ubuntu-24.04"},
  "node03" => {"memory" => "1024", "cpu" => "1", "ip" => "103", "image" => "bento/ubuntu-24.04"}
}

Vagrant.configure("2") do |config|
  machines.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.box = "#{conf["image"]}"
      machine.vm.hostname = "#{name}"
      machine.vm.network "private_network", ip: "192.168.56.#{conf["ip"]}"

      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
      end

      # Instalação do Docker comum a todos
      machine.vm.provision "shell", path: "docker.sh"

      if name == "master"
        # Provisionamento específico do Master
        machine.vm.provision "shell", path: "master.sh"
      else
        machine.vm.provision "shell", inline: <<-SHELL
          echo "Aguardando token..."
          # Espera o arquivo existir e NÃO estar vazio
          while [ ! -s /vagrant/worker.sh ]; do
            sleep 2
          done
          
          # Pequena pausa extra para o VirtualBox sincronizar o arquivo no disco
          sleep 5 
          
          echo "Token validado! Ingressando no cluster..."
          # Roda o join forçando o uso da interface eth1 (rede privada)
          sudo bash /vagrant/worker.sh
SHELL
      end
    end
  end
end