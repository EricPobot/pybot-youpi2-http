%include("prolog.tpl", title="Youpi 2 - Les origines")

<div class="page-header"><h1>Les origines du projet</h1></div>

%include("toc_prolog.tpl")
<h2>Youpi</h2>

<p>Youpi est un bras robot doté de cinq degrés de liberté, commercialisé dans les années 80
    par JD Productique, à destination de l'enseignement en technologie et en automatique.</p>

<p>Il a connu un succès certain dans les collèges et les lycées techniques,
    à une époque où l'informatique et la robotique étaient des matières en vogue en France,
    notamment à travers le fameux plan <i>Informatique Pour Tous</i>.</p>

<p>A l'origine, Youpi était souvent connecté à un micro-ordinateur de la marque Thomson, les modèles plus plus
    répandus
    étant le MO5 et le TO7/70 qui furent largement distribués dans les écoles via le plan IPT. Malheureusement,
    le
    matériel informatique de l'époque est rapidement devenu obsolète et les déboires de Thomson
    Micro-Informatique ont
    laissé de nombreux enseignants sur le carreau, sans possibilité d'évolution ou même de support
    technique. </p>

<p>L'informatique à l'école fut un temps enterrée. Parallèlement, Youpi continuait vaille que vaille son chemin,
    passant
    de main en main, si bien que, hors des réseaux professionnels, on en perdit plus ou moins la trace. Dans les
    écoles,
    le MO5 vieillissant qui le pilotait tombait en panne; on se disait que c'était bien dommage de jeter un si
    joli
    robot et beaucoup atterrirent dans les armoires ou les caves, dans l'attente d'un jour meilleur.</p>

%include("jump_to_top")

<h2>Le projet</h2>

<p>On trouve sur Internet un certain nombre de sites de passionnés qui montrent leur restauration de bras Youpi
    à l'abandon. Plusieurs de ces opérations ont conduit au développement d'émulateurs des ordinateurs d'origine
    afin d'exécuter les logiciels d'alors.</p>

<div class="row">
    <div class="col-xs-6 col-md-8">
        <p>Nous avons pris une approche radicalement différente, en cherchant à utiliser Youpi directement avec
            les ressources technologies actuelles, telles que les cartes Arduino, Raspberry Pi,...</p>

        <p>Par ailleurs l'objectif était de créer des démonstrations originales, la première ayant été réalisée
            pour la Fête de la Science 2015, sous forme du pilotage interactif de Youpi au moyen d'une interface
            utilisateur sur un Minitel en partance pour la déchetterie.</p>

        <p>Cette réalisation utilisait Youpi <i>"dans son jus"</i>, c'est à dire totalement d'origine. Le
            pilotage
            assuré à l'époque par l'ordinateur dédié a été émulé par une carte Arduino générant les signaux
            électriques utilisés par l'électronique standard. La gestion du Minitel était assuré par un serveur
            Videotex développé pour s'exécuter sur une carte Raspberry Pi.
    </div>
    <div class="col-xs-6 col-md-4">
        <a href="/static/img/youpinitel-2015.jpg" class="thumbnail">
            <img src="/static/img/youpinitel-2015.jpg" alt="YouPinitel 2015">
        </a>
    </div>
</div>

%include("jump_to_top")

<h2>La suite</h2>

<p>Forts de ce premier résultat, et un tas d'idées d'évolutions et d'améliorations en tête,
    nous avons entrepris de remettre tatalement au goût du jour notre Youpi, en remplaçant son électronique
    par quelque chose de plus moderrne et performant afin de pallier les travers constatés, le plus
    préoccupant étant une forte montée en température aussi bien des moteurs que de l'électronique
    contenue dans le boîtier socle</p>

<p>Youpi a également été doté de capacités fonctionnelles nouvelles,
    notamment d'une autonomie de fonctionnement (c'est à dire sans dépendre d'un ordinateur connecté),
    et d'une architecture logicielle permettant de développer
    facilement de nouvelles fonctions sous forme d'applications indépendantes et orchestrées par un
    système de supervision.</p>

<p>Pour en savoir plus, continuez la lecture avec la <a href="/detail/works">présentation des travaux
    réalisés</a>.</p>

%include("jump_to_top")

%include("toc_epilog.tpl")
%include("epilog.tpl", version=version)