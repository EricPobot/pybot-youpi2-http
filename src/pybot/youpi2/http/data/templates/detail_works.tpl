%include("prolog.tpl", title="Youpi 2 - Travaux réalisés")

<div class="page-header">
    <h1>Les travaux réalisés</h1>
</div>

%include("toc_prolog.tpl")

<h2>L'électronique</h2>

<h3>Pilotage des moteurs</h3>

<div class="row">
    <div class="col-xs-6 col-md-8">
        <p>L'électronique d'origine n'avait pour seule fonction que de piloter les moteurs en
        fonction des signaux qui étaient fournis sur la prise DB25 de connexion avec l'ordinateur.
        Celui-ci avait la reponsabilité de gérer ces consignes à bas niveau. Le bras n'était donc
        pas autonome.</p>

        <p>Cette électronique utilisait une trentaine de transistors de puissance pour contrôler les
            six moteurs, occupant les deux dissipateurs thermiques situés le long des grands côtés
            du boitier. La logique de commutation des transistors était assurée par un assemblage
        complexe de circuits logiques. </p>
    </div>
    <div class="col-xs-6 col-md-4">
        <a href="/static/img/youpi-orig.jpg" class="thumbnail">
            <img src="/static/img/youpi-orig.jpg" alt="Electronique d'origine" title="Electronique d'origine">
        </a>
    </div>
</div>

<p>A noter que la commande des transistors était réalisée en tout ou rien, sans modulation du courant.
Ceci avait pour conséquence de faire passer en permanence un courant élevé dans les enroulements des
moteurs lorsque ceux-ci sont en position de maintien, résultant en un fort échauffement aussi bien
à leur niveau qu'à celui des transistors de puissance. Sans parler de la consommation électrique globale ;)</p>

<div class="row">
    <div class="col-xs-6 col-md-8">
        <p>Cette électronique a été totalement remplacée par des drivers intelligents pour moteurs pas à pas
            <i>(les 6 petites cartes rouges sur la photo)</i>,
        capables de prendre en charge les opérations de bas niveau, telles que les rampes d'accélération et de
        décélération, la modulation du courant,... Au lieu de gérer les signaux de bas niveau, le logiciel de
        contrôle du bras envoie des ordres à ces drivers, pour leur donner les consignes de position, de vitesse,
        ... afin de réaliser les mouvements souhaités.</p>
    </div>
    <div class="col-xs-6 col-md-4">
        <a href="/static/img/new-control-board.jpg" class="thumbnail">
            <img src="/static/img/new-control-board.jpg" alt="Nouvelle électronique" title="Nouvelle électronique">
        </a>
    </div>
</div>

<p>Grâce à une gestion évoluée du courant traversant les moteurs, ces drivers permettent d'en optimiser l'intensité,
et de maintenir l'échauffement tant des moteurs que des puces électroniques à un niveau extrêment bas, à peine
perceptible.</p>

%include("jump_to_top")

<h3>Panneau de commande</h3>

<div class="row">
    <div class="col-xs-6 col-md-8">
        <p>La face avant du boîtier a été équipée d'un panneau de commande composé d'un afficheur LCD et de
        plusieurs boutons, offrant l'interface utilisateur permettant de contrôler les opérations du bras
        grâce au système de supervision embarqué.</p>

        <p>Ce panneau est également équipé d'un interrupteur à clé, pour verrouiller les touches lorsque
        le bras est laissé en démonstration autonome.</p>
    </div>
    <div class="col-xs-6 col-md-4">
        <a href="/static/img/control-panel.jpg" class="thumbnail">
            <img src="/static/img/control-panel.jpg" alt="Panneau de commande" title="Panneau de commande">
        </a>
    </div>
</div>

<p>On notera au passage que les façades en aluminium ont été remplacées par des panneaux de bois verni,
    donnant à l'ensemble un ton plus chaleureux, évoquant certains amplis HiFi haut de gamme ou bien les
tableaux de bord de canots automobiles Riva ;)</p>

%include("jump_to_top")

<h2>Le système de supervision</h2>

<p>...</p>

%include("jump_to_top")

%include("toc_epilog.tpl")
%include("epilog.tpl", version=version)