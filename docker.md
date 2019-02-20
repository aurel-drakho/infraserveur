Administration docker création container pour créer une infrastructure réseau d'entreprise



source : https://docs.microsoft.com/en-us/virtualization/windowscontainers/quick-start/quick-start-windows-server

L'objectif de ce document est de mettre en place docker sur un Serveur Windows 2019, un fichier 'dockerfile

## Documentation sur le web

Open an elevated PowerShell session and run the following commands.

First, install the Docker-Microsoft PackageManagement Provider from the [PowerShell Gallery](https://www.powershellgallery.com/packages/DockerMsftProvider).

PowerShell 			

```powershell
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
```

Next, you use the PackageManagement PowerShell module to install the latest version of Docker.

PowerShell 			

```powershell
Install-Package -Name docker -ProviderName DockerMsftProvider
```

When PowerShell asks you whether to trust the package source 'DockerDefault', type `A` to continue the installation. When the installation is complete, reboot the computer.

PowerShell

```powershell
Restart-Computer -Force
```



## En pratique

Exemple de création d'un container 'hello-world'

__J'ai rencontré des problèmes à la création d'un container docker, le processus n'était pas lancé sur la machine.__

PS C:\Windows\system32> docker run hello-world
C:\Program Files\Docker\docker.exe: error during connect: Post http://%2F%2F.%2Fpipe%2Fdocker_engine/v1.39/containers/create: open //./pipe/docker_engine: Le fichier spécifié est introuvable. In the default daemon configuration on Windows, the docker client must be run elevated to connect. This error may also indicate that the docker daemon is not running.
See 'C:\Program Files\Docker\docker.exe run --help'.
PS C:\Windows\system32> docker pull --help

Usage:  docker pull [OPTIONS] NAME[:TAG|@DIGEST]

Pull an image or a repository from a registry

Options:
  -a, --all-tags                Download all tagged images in the repository
      --disable-content-trust   Skip image verification (default true)
      --platform string         Set platform if server is multi-platform
                                capable
PS C:\Windows\system32> docker push --help

Usage:  docker push [OPTIONS] NAME[:TAG]

Push an image or a repository to a registry

Options:
      --disable-content-trust   Skip image signing (default true)
PS C:\Windows\system32> docker pull mcr.microsoft.com/windows/servercore:ltsc2019
error during connect: Post http://%2F%2F.%2Fpipe%2Fdocker_engine/v1.39/images/create?fromImage=mcr.microsoft.com%2Fwindows%2Fservercore&tag=ltsc2019: open //./pipe/docker_engine: Le fichier spécifié est introuvable. In the default daemon configuration on Windows, the docker client must be run elevated to connect. This error may also indicate that the docker daemon is not running.

PS C:\Windows\system32> cd "C:\Program Files\Docker"
PS C:\Program Files\Docker> ls


    Répertoire : C:\Program Files\Docker


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----       11/02/2019     09:58       64147016 docker.exe
-a----       11/02/2019     09:58       70873160 dockerd.exe
-a----       14/12/2018     23:23        2465792 libeay32.dll
-a----       11/05/2017     22:32          56978 libwinpthread-1.dll
-a----       10/02/2019     04:16           6247 licenses.txt
-a----       14/02/2019     17:00            142 metadata.json
-a----       14/12/2018     23:23         357888 ssleay32.dll
-a----       09/06/2016     22:53          87888 vcruntime140.dll



PS C:\Program Files\Docker> .\dockerd.exe
INFO[2019-02-15T08:49:30.612873600+01:00] Windows default isolation mode: process
INFO[2019-02-15T08:49:30.798796200+01:00] Loading containers: start.
INFO[2019-02-15T08:49:30.800847400+01:00] Restoring existing overlay networks from HNS into docker
INFO[2019-02-15T08:49:34.891823400+01:00] Loading containers: done.
INFO[2019-02-15T08:49:34.994630000+01:00] unable to lookup licensing details without a daemon.cluster
INFO[2019-02-15T08:49:34.998567100+01:00] Docker daemon                                 commit=1ac774dfdd graphdriver(s)=windowsfilter version=18.09.2
INFO[2019-02-15T08:49:34.998567100+01:00] starting telemetry service
INFO[2019-02-15T08:49:35.030527800+01:00] Daemon has completed initialization
INFO[2019-02-15T08:49:35.235991100+01:00] API listen on //./pipe/docker_engine
INFO[2019-02-15T08:55:18.941395500+01:00] sending event                                 container=3fc3da387b56c0e9196888f1ac5c4a30d8cdd236b302ae278b7df0ae03ce3c11 event=start event-info="{3fc3da387b56c0e9196888f1ac5c4a30d8cdd236b302ae278b7df0ae03ce3c11 init 3916 0 0001-01-01 00:00:00 +0000 UTC false <nil>}" module=libcontainerd namespace=moby
INFO[2019-02-15T08:55:28.327738900+01:00] sending event                                 container=3fc3da387b56c0e9196888f1ac5c4a30d8cdd236b302ae278b7df0ae03ce3c11 event=exit event-info="{3fc3da387b56c0e9196888f1ac5c4a30d8cdd236b302ae278b7df0ae03ce3c11 init 3916 0 2019-02-15 08:55:27.0810675 +0100 CET m=+356.703548301 false <nil>}" module=libcontainerd namespace=moby



PS C:\Windows\system32> docker run microsoft/dotnet-samples:dotnetapp-nanoserver-1809
Unable to find image 'microsoft/dotnet-samples:dotnetapp-nanoserver-1809' locally
dotnetapp-nanoserver-1809: Pulling from microsoft/dotnet-samples
6a5e981230da: Pull complete
7fe5fc4b6b6d: Pull complete
e246797eaa11: Pull complete
1e66b88a6a25: Pull complete
bc612261b431: Pull complete
ea0ba5e33e76: Pull complete
ba41b7656325: Pull complete
9bfe3aa1173c: Pull complete
7bd4fabc8b3d: Pull complete
c2f01337e7f7: Pull complete
Digest: sha256:165c5b3782b4127d7aa8430523117d3f4d1ca603ae2ff8160339481a0aff9f3a
Status: Downloaded newer image for microsoft/dotnet-samples:dotnetapp-nanoserver-1809
    Hello from .NET Core!
__________________
​                        \
​                        \
​                            ....
​                            ....'
​                            ....
​                          ..........
​                      .............'..'..
​                  ................'..'.....
​                .......'..........'..'..'....
​                ........'..........'..'..'.....
​              .'....'..'..........'..'.......'.
​              .'..................'...   ......
​              .  ......'.........         .....
​              .                           ......
​              ..    .            ..        ......
​            ....       .                 .......
​            ......  .......          ............
​              ................  ......................
​              ........................'................
​            ......................'..'......    .......
​          .........................'..'.....       .......
​      ........    ..'.............'..'....      ..........
​    ..'..'...      ...............'.......      ..........
​    ...'......     ...... ..........  ......         .......
  ...........   .......              ........        ......
  .......        '...'.'.              '.'.'.'         ....
  .......       .....'..               ..'.....
​    ..       ..........               ..'........
​            ............               ..............
​          .............               '..............
​          ...........'..              .'.'............
​        ...............              .'.'.............
​        .............'..               ..'..'...........
​        ...............                 .'..............
​        .........                        ..............
​          .....


**Environment**
Platform: .NET Core
OS: Microsoft Windows 10.0.17763

PS C:\Windows\system32> docker images ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
PS C:\Windows\system32>





## Installer Hyper-V

Installation en powershell du rôle Hyper-V sur le serveur Windows 2019

```powershell
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools
Success Restart Needed Exit Code      Feature Result                               
------- -------------- ---------      --------------                               
True    Yes            SuccessRest... {Hyper-V, Module Hyper-V pour Windows Powe...
AVERTISSEMENT : Vous devez redemarrer ce serveur pour terminer le processus d’installation.
```





Un fichier dockerfile aurait des arguments pour lancer le programme powershell et lancer le script qui installerait les rôles DHCP par exemple.  La configuration du dhcp devrait être effectuée dans le fichier docker.

Je n'ai pas pu terminer cette partie pour le moment par manque de temps.



## Installer un serveur RDWEB

J'ai reçu de la part d'un camarade un fichier ps1 qui permet d'avoir les différentes commandes powershell nécessaires à l'installation d'un serveur rdweb.

Etant donné que Docker est déjà installé et fonctionnel, on ne reviendra pas dessus mais il s'agit d'un pré-requis pour les étapes suivantes.

Les grandes étapes pour faire un container personnalisé sont :

- Identifier et tester les commandes PowerShell pour installer le serveur
- Créer un fichier 'Dockerfile' dans lequel les différentes instructions sont nécessaires pour déployer le serveur
  - Dockerfile
    FROM servercore/ltsc2019
    COPY rdweb.ps1 c:\admin\install\
    RUN powershell c:\admin\install\rdweb.ps1
- Lancer la commande docker -t build . dans le répertoire contenant les fichiers de travail (Dockerfile, fichier.ps1)
- Lancer le déploiement du container personnalisé : docker run -it ...
- Suivre et vérifier le déploiement du container