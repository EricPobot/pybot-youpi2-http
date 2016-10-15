%include("prolog.tpl", title="Youpi 2 - Détails techniques")

<div class="page-header">
    <h1>Détails techniques</h1>
</div>

%include("toc_prolog.tpl")

<h2>Les drivers de moteur</h2>

<p>Ce sont des circuits L6470 (connus également sous le nom de <b>dPSPIN</b>) du constructeur
STMicroelectronics.</p>

<p>Les principales caractéristiques électriques du L6470 sont:</p>
<ul>
    <li>tension de service : entre 8 et 45V</li>
    <li>courant maximal : 3A en continu, 7A en pointe</li>
    <li>profil de vitesse configurable</li>
    <li>capable de faire du micro-stepping jusqu'au 1/128ème de pas</li>
    <li>détection de blocage sans utilisation de capteur</li>
    <li>communication sur bus SPI</li>
    <li>nombreuses fonction pour le positionnement du moteur, la recherche d'origine, la gestion de
        fin de course,...</li>
    <li>nombreuses alarmes et fonctions de sécurité configurables</li>
    <li>possibilité de chaîner plusieurs L6470 (configuration daisy-chain) pour une communication
        simple nécessitant un minimum de signaux complémentaires (chip select unique)</li>
    <li>retour d'information concernant l'état "mouvement en cours" par ligne se signalisation dédiée</li>
    <li>gestion des courants maximaux pour les différentes phases de mouvement : accélération, décélération,
    vitesse constante, maintien de position</li>
</ul>

<p>Prenant en charge un grand nombre de tâche de base, comme les rampes d'accélération et de décélération
par exemple, il allège considérablement la tâche du système de contrôle, et est ainsi parfaitement adapté à
être piloté par des MCU de faible puissance.</p>

<p>La Raspberry Pi disposant nativement d'une interface matérielle SPI, la mise en oeuvre du dSPIN dans
    ce contexte est très rapide.</p>

<div class="row">
    <div class="col-xs-6 col-md-8">
        <p>Afin de simplifier leur mise en oeuvre, et notamment ne pas nécessiter la réalisation d'un circuit imprimé
        assez délicat à faire du fait de la très petite taille du composant, Youpi utilise des mini cartes qui regroupe
        le circuit lui-même ainsi que ses auxiliaires et la connectique adaptée à un usage rapide. Plusieurs fabricants
        proposent de telles cartes, dont STMicroelectronics eux-même. Nous avons choisi le modèle fabriqué par Sparkfun
        pour des raisons d'encombrement... et de budget.</p>
    </div>
    <div class="col-xs-6 col-md-4">
        <a href="/static/img/dspin_sparkfun.jpg" class="thumbnail">
            <img src="/static/img/dspin_sparkfun.jpg" alt="Carte Sparkfun pour le dSPIN" title="Carte Sparkfun pour le dSPIN">
        </a>
    </div>
</div>

<div class="row">
    <p>Une couche logicielle a été développée pour fournir les services suivants, organisées en couches :</p>
    <ol>
        <li>communication avec les dSPINs au travers de la liaison SPI, configurée en daisy-chain,</li>
        <li>modélisation du bras de manière à dialoguer avec lui en termes d'angles d'articulation, la correspondance
        avec les consignes réelles envoyées au moteurs étant prises en charge de manière transparente,</li>
        <li>exposition des services de haut niveau du modèle (déplacement vers une pose particulière,
            actions de la pince,...)
        sur le bus système D-Bus, afin de les rendre utilisables par une application développée dans
        n'importe quel langage pour lequel un <i>binding</i> D-Bus existe (soit à peu près tous les langages courants,
        de C/C++ à Python, en passant par Java,...) y compris <i>bash</i>,
            grâce à la commande <kbd>dbus-send</kbd>.</li>
    </ol>
    <p>Aussi bien le <i>shell</i> de supervision que les différentes applications de démonstation utilisent la couche 3
    pour interagir avec le bras.</p>
    <p>Les différentes couches composant le driver du bras ont été développée en Python, à l'aide de la librairie
    <var>dbus-python</var> pour la couche 3 réalisant le binding D-Bus.</p>
    <p class="text-muted">Pour être exact, dbus-python n'est pas
    utilisé directement par ce composant, qui s'appuie en réalité sur une encapsulation des mécanismes de bas niveau
    fournie par l'environnment <var>nROS</var> développé par l'auteur. Cet environnement reproduit de manière
    approchée et simplifiée les mécanismes de <var>ROS</var>, mais en utilisant D-Bus comme support de communication
    sous-jacent.</p>
</div>

%include("jump_to_top")

<h2>Le panneau de contrôle</h2>

<div class="row">
    <div class="col-xs-6 col-md-8">
        <p>Il est construit autour d'un afficheur LCD texte 4 lignes de 20 caractères, équipé d'une interface I2C.</p>

        <p>Ce type d'interface permet de réduire à 2 le nombre de lignes de communication requies au lieu des
        8 ou 16 habituellement utilisées pour un contrôle directe. La mise en oeuvre en est également grandement
        simplifiée, puisque se faisant au moyen d'un jeu de commandes.</p>

        <p>Le contrôleur I2C du LCD intègre de plus la gestion d'un clavier matriciel comportant jusqu'à
            4 lignes de 3 touches.</p>
    </div>
    <div class="col-xs-6 col-md-4">
        <a href="/static/img/lcd05.jpg" class="thumbnail">
            <img src="/static/img/lcd05.jpg" alt="LCD I2C" title="LCD I2C">
        </a>
    </div>
</div>
<div class="row">
    <div class="col-xs-6 col-md-8">
        <p>Le LCD a été complété par 4 touches équipées de LEDs de signalisation, récupérés sur d'anciens matériels
        sono et light-show. Ces touches sont câblées de manière à reconstituer un mini-clavier 2x2, connecté
        à l'interface de scanning du contrôleur du LCD. Cela a permis d'utiliser directement les fonctsions de
        lecture qu'elle propose nativement.</p>

        <p>Un interrupteur à clé a également été ajouté, afin de pouvoir bloquer le clavier dans le cadre de
        démonstrations en public.</p>

        <p>Les LEDs de signalisation sont pilotées par un expandeur I2C PCF8574, connecté sur le même bus que
        l'afficheur. L'interrupteur à clé est également géré par l'expandeur.</p>
    </div>
    <div class="col-xs-6 col-md-4">
        <a href="/static/img/control-panel-closeup.jpg" class="thumbnail">
            <img src="/static/img/control-panel-closeup.jpg" alt="Panneau de commande" title="Panneau de commande">
        </a>
        <a href="/static/img/control-panel-detail.jpg" class="thumbnail">
            <img src="/static/img/control-panel-detail.jpg" alt="Détail du panneau de commande" title="Détail du panneau de commande">
        </a>
    </div>
</div>
<div class="row">
    <p>Dans un même esprit que pour le bras lui-même, l'accès au panneau de contrôle par les applications est
    découplé grâce à un driver. Pour en rendre l'usage le plus simple possible, et n'étant pas contraint par des
    impératifs de performances de communication compte tenu du temps de réaction du LCD lui-même, l'option
    FUSE (File System in Userspace) a été utilisée ici.</p>
    <p>Elle permet de présenter les différents points de contrôle des fonctions (affichage de texte, lecture de l'étant
    des touches, modification de l'état des LEDs,...) sous forme d'une collection de fichiers virtuels, à l'image
    de ceux présents dans les arborescences <var>/sys/class</var>, <var>/proc</var> ou encore <var>/dev</var>
    de Linux.</p>
    <p>L'interaction avec le paneeau se résume donc à lire et écrire dans de simples fichiers texte, chose possible
    de manière native avec n'importe quel langage, et même directement depuis la ligne de commande au moyen des
    commandes <kbd>echo</kbd> ou <kbd>cat</kbd>.</p>
    <p>Pour faire bonne mesure, à l'accès en lecture à l'état courant des touches et de l'interrupteur
    à clé a été la génération d'événements de type clavier/souris via le mécanisme <var>evdev</var>. Ceci permet
    d'écrire l'application cliente sous forme d'une logique événementielle au lieu d'une logique de <i>polling</i>
    périodique. Cette option donne un peu plus de liberté au développeur d'extension quant au paradigme qu'il
    préfère mettre en oeuvre.</p>
    <p>Ce driver a été développé en Python et s'appuie sur la librairie <var>fusepy</var>. La gestion des événements
    est basée sur la librairie <var>evdev</var>.</p>
</div>

%include("jump_to_top")

<h2>Architecture logicielle</h2>

<div class="row">
    <div class="col-xs-6 col-md-8">
        <p>Le système de Youpi a été conçu à l'image d'Unix : un ensemble de logiciels indépendants, dédié chacun
        à une tâche spécifique, et ne gérant que cette tâche. Ces logiciels communiquent entre eux en utilisant
        les fonctionnalités de base de l'OS (Linux en l'occurrence) décrites précédemment, à savoir :</p>
        <dl>
            <dt>le système de fichiers</dt>
            <dd>Un système de fichier virtuel est créé, à la manière de <samp>/sys/class</samp>, <samp>/proc</samp>
            et consorts, donnant accès aux différents points de contrôle des entités interfacées. Par exemple,
            le panneau de contrôle se présente sous forme d'une liste de fichiers, dont ceux-ci:
                <ul>
                    <li><samp>backlight</samp> pour contrôller l'allumage du rétro-éclairage, en y écrivant <samp>0</samp>
                    ou <samp>1</samp>,</li>
                    <li><samp>leds</samp> pour contrôller l'allumage des LEDs des touches, en y écrivant le pattern binaire
                    correspondant à leur état,</li>
                    <li><samp>display</samp> pour afficher du texte, en l'écrivant dans le ficher, les séquences
                    ANSI étant interprétées pour gérer le positionnement sur l'affichage,</li>
                    <li><samp>keys</samp> qui contient la liste des touches appuyées au moment de la lecture,</li>
                    <li><samp>locked</samp> qui contient l'état de l'interrupteur de verrouillage,</li>
                    <li>...</li>
                </ul>
                <p>Ce système de fichier est implémenté sur la base de <b>FUSE</b>, afin de ne pas avoir à écrire
                de module noyau.</p>
            </dd>
            <dt>le bus de message <b>D-Bus</b></dt>
            <dd>D-Bus est utilisé pour communiquer avec le driver des moteurs du bras, car plus rapide que l'accès
            par fichiers. Le driver est un processsus tournant en tâche de fond, à l'écoute des messages envoyés
            à son attention par les programmes utilisateur.</dd>
        </dl>
        <p>La vue d'ensemble est illustrée dans les schémas de droite.</p>
    </div>
    <div class="col-xs-6 col-md-4">
        <a href="/static/img/youpi_system_arch-2.png" class="thumbnail">
            <img src="/static/img/youpi_system_arch-2.png" alt="Architecture logicielle (2)" title="Architecture logicielle (2)">
        </a>
        <a href="/static/img/youpi_system_arch-1.png" class="thumbnail">
            <img src="/static/img/youpi_system_arch-1.png" alt="Architecture logicielle (1)" title="Architecture logicielle (1)">
        </a>
    </div>
</div>

%include("jump_to_top")

<h2>Le shell</h2>

<div class="row">
    <p>A la manière de Linux, l'environnement logiciel de Youpi dispose d'un shell, lancé au démarrage du système et
    fournissant l'accès aux diverses fonctions et applications. Il utilise le panneau de contrôle pour permettre à
    l'utilisateur de naviguer dans l'arborescence des fonctions, et lance en tant que process indépendant
    les diverses applications qui les implémentent, tout comme le fait l'interface graphique du bureau
    des systèmes pour micro-ordinateurs ou smartphones.</p>

    <p>Ajouter de nouvelles fonctions est simple, et consiste à écrire le programme qui sera lancé pour l'exécuter.
    Bien que l'ensemble des logiciels de Youpi soient écrits en Python à l'heure actuelle, ceci n'est pas une contrainte
    et rien n'empêche d'en utiliser un autre, du moment qu'il fournit le moyen d'accéder à D-Bus pour communiquer
    avec le driver du bras.</p>

    <p>Afin de rendre la tâche la plus simple possible pour les développeurs de telles extensions, et ainsi encourager
    les contributeurs à étendre les possibilités de Youpi, un socle de base est fourni pour les adeptes de Python. Il
    prend en charge les tâches communes afin de laisser le contributeur se concentrer sur les spécificités de son
    application. UNe structure familière aux habitués d'Arduino est utilise, sous forme du combo de méthodes
    <samp>setup</samp>, <samp>loop</samp> et <samp>teardown</samp>.</p>

    <p>Le shell de Youpi est intégralement développé en Python.</p>
</div>

%include("jump_to_top")

%include("toc_epilog.tpl")
%include("epilog.tpl", version=version)