# Mise en oeuvre d'Ansible dans le BdF

Source : https://memo-linux.com/ansible-mes-premiers-pas/



### Mise en place de la configuration d'ansible

La machine hôte est un système Debian 9, la machine que l'on veut administrer également.

**Machine hôte**

Nom : NRBDFSUPERVISION



**Machine à administrer**

Nom : NRBDFDEV

IP : 10.192.12.6



Renseigner l'adresse du ou des serveur à administrer dans le fichier /etc/ansible/hosts, par exemple :

```
[NRBDF_APPLIS]

10.192.12.6
```

NRBDF_APPLIS définit un groupe, on peut mettre une adresse IP ou un nom de machine pour référencer le serveur. Le nom doit être entre crochet.



Ansible passe par ssh pour administrer des serveurs et équipements, il faut donc générer une clé dans notre profil pour enregistrer de manière sécuriser les connexions :

``` bash
$ ssh-keygen
Your public key has been saved in /home/supportbdf/.ssh/id_rsa.pub.
```



Et ensuite copier les informations d'identification ssh :

````bash
ssh-copy-id -i /home/supportbdf/.ssh/id_rsa.pub supportbdf@10.192.12.6
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/supportbdf/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
supportbdf@10.192.12.6's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'supportbdf@10.192.12.6'"
and check to make sure that only the key(s) you wanted were added.
````



On peut faire un test :

````bash
supportbdf@NRBDFSUPERVISION:~/.ssh$ ansible NRBDF_APPLIS -m ping
10.192.12.6 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
````

Le test est concluant, l'utilisation des commandes ansible est possible pour administrer le serveur NRBDFDEV.

Un ping tout simple montre que l'on peut lancer un grand nombre de commande à distance à l'aide d'Ansible.

Un exemple des commandes disponibles, la liste n'est pas exhaustive :

- apt
- pip
- mysql



On pourrait gérer une dizaine de serveur s'il y avait autant d'adresses IP renseignées dans le groupe NRBDF_APPLIS. Pour déployer sur plusieurs hôtes, on utilise la commande ansible-playbook et on lui renseigne un fichier .yaml dans lequel les instructions de déploiement sont renseignées.

Voici un exemple d'un fichier .yaml :

``` yaml
- hosts: webservers
 tasks:
 	-name: install apache2
 	apt: name=apache2 update_cache=yes state=latest
 	notify:
 	- restart-apache2
 	
 handlers:
 - name: restart apache2
 restart: name=apache2 state=restart
```



Les opération s'effectuent dans l'ordre dans lequel elles sont écrites, c'est à dire :

- installation apache2
- redémarrage d'apache2



La syntaxe pour lancer un playbook est la suivante :

```bash
$ ansible-playbook playbook.yml -f 10
```



