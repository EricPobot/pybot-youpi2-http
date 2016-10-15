%include("prolog.tpl", title="Youpi 2 - Démonstrations")

<div class="page-header">
    <h1>Les démonstrations</h1>
</div>

%include("toc_prolog.tpl")

<h2>Tours de Hanoï</h2>

<div class="row">
    <div class="col-xs-6 col-md-8">
        <p>Dans cette démonstration, Youpi résout le célèbre problème des Tours de Hanoï.</p>
        <p>Les tours de Hanoï <span class="text-muted">(originellement, <i>la tour d'Hanoïa</i>)</span>
            sont un jeu de réflexion imaginé
            par le mathématicien français Édouard Lucas, et consistant à déplacer des disques de diamètres
            différents d'une tour de <b>départ</b> à une tour d'<b>arrivée</b> en passant par une tour
            <b>intermédiaire</b>,
            et ceci en un minimum de coups, tout en respectant les règles suivantes :</p>
            <ul>
                <li>on ne peut déplacer qu'un seul disque à la fois,</li>
                <li>on ne peut placer un disque que sur un autre disque plus grand que lui ou sur un emplacement
                    vide.</li>
            </ul>
    </div>
    <div class="col-xs-6 col-md-4">
        <a href="/static/img/hanoi.jpg" class="thumbnail">
            <img src="/static/img/hanoi.jpg" alt="Tours de Hanoï" title="Tours de Hanoï">
        </a>
    </div>
</div>

<p>On se limite ici à 3 palets, le calcul mathématique démontrant que le nombre minimal de
    mouvements pour déplacer une tour de <var>n</var> éléments est de <var>2^n - 1</var>.
    La légende originale qui mentionne une tour de 64 palets et annonce la fin de l'univers
        dès qu'elle aura été entièrement déplacé nous laisse d'ailleurs suffisamment de temps
    pour profiter de la vie. En effet, en supposant un déplacement par seconde, le temps total sera
    de <b>584,5 milliards d'années</b>, soit
        <b>43 fois</b> l'âge estimé de l'univers
    <span class="text-muted">(13,7 milliards d'années selon certaines sources)</span>.</p>

<p>Cette démonstration illustre plusieurs aspects de Youpi:</p>
<ul>
    <li>la précision de ses mouvements,</li>
    <li>la mise en oeuvre de calculs de <b>cinématique inverse</b>, les positions extrêmes des différents mouvements
    étant calculées en coordonnées cartésiennes dans l'espace en fonction de la pile concernée et de sa hauteur,
    puis converties en angles des différentes articulations du bras,</li>
</ul>

<p>Elle est développée en Python.</p>

%include("jump_to_top")

<h2>Contrôle par Minitel</h2>

<div class="row">
    <div class="col-xs-6 col-md-8">
        <p>Youpi est ici contrôlé par un opérateur qui lui donne des
            instructions au moyen d'un antique Minitel.</p>
        <p>Il s'agit d'un clin d'oeil technologique, dans lequel on relie deux objets technologiques des années
            80 (Youpi et le Minitel) par l'intermédiaire d'une technologie du 21ème siècle (la Raspberry Pi).</p>
        <p>Pour arriver à ce résultat, un serveur Videotext (le protocole utilisé par le Minitel) a été
            développé pour la Raspberry Pi, reproduisant le fonctionnement exact des serveurs qui animaient
            les ancêtres de nos sites Web d'aujourd'hui. Notre bon vieux Minitel n'y voir ainsi que du feu,
            et se retrouve à discuter de la même manière que lorsqu'il était utilisé connecté au réseau
            téléphonique analogique.</p>
        <p>Cette application est développée en Python.</p>
    </div>
    <div class="col-xs-6 col-md-4">
        <a href="/static/img/minitel.jpg" class="thumbnail">
            <img src="/static/img/minitel.jpg" alt="Minitel" title="Minitel">
        </a>
    </div>
</div>

%include("jump_to_top")

<h2>Contrôle par navigateur Web</h2>

<div class="row">
    <div class="col-xs-6 col-md-8">
        <p>Cette démonstration ressemble à celle du Minitel, mais cette fois-ci l'interface de l'opérateur
            est plus moderne puisqu'utilisant un navigateur Internet.</p>
        <p>Un serveur Web a été développé et s'exécute dans Youpi. Il affiche les pages donnant accès aux
            différents modes de commande, et gère la saisie des paraètres des mouvements souhaités par
            l'opérateur.
        <p>Outtre l'interface utilisateur, ce serveur gère les requêtes de l'API des Web Services permettant
            de contrôler Youpi depuis n'importe quelle machine connectée sur le mếmé réseau.</p>
        <p>A noter que les mêmes solutions techniques sont utilisées pour réaliser le serveur Web qui permet de naviguer
        dans les pages que vous consultez en ce moment.</p>
        <p>Les technologies utilisées sont:</p>
        <ul>
            <li>Python,</li>
            <li>micro-framework Bottle,</li>
            <li>bibliothèque Javascript jQuery,</li>
            <li>couche de présentation Bootstrap,</li>
            <li>CSS Bootstrap Slate.</li>
        </ul>
    </div>
    <div class="col-xs-6 col-md-4">
        <a href="/static/img/demo_http.png" class="thumbnail">
            <img src="/static/img/demo_http.png" alt="Démonstration HTTP" title="Démonstration HTTP">
        </a>
    </div>
</div>

%include("jump_to_top")

%include("toc_epilog.tpl")
%include("epilog.tpl", version=version)