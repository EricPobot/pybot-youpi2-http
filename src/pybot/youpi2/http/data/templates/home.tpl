%include("prolog.tpl", title="Youpi 2")

<div class="jumbotron">
    <div class="container">
        <h1>Le mariage de deux époques</h1>
        <p>Un bras robotique des années 80, ramené à la vie avec
            l'aide des technologies du 21ème siècle.</p>
    </div>
</div>
<div class="row">
    <div class="col-md-4">
        <h2>Origines</h2>
        <p>L’association a reçu en don des enseignants de Physique du C.I.V.
            un bras robotique pédagogique Youpi, utilisé dans l'enseignement
            technologique dans les années 80.</p>
        <p>Etant toujours en parfait état de marche, mais n’étant cependant
            plus utilisable directement du fait de sa dépendance à des machines
            et logiciels de son époque, nous avons entrepris
            de le ressusciter à l'aide des moyens actuels.</p>
        <p><a class="btn btn-default" href="/detail/origins" role="button">Détails &raquo;</a></p>
    </div>
    <div class="col-md-4">
        <h2>Réalisations</h2>
        <p>Les moyens techniques de l'époque (ordinateur des années 80)
            ont été remplacés des ressources actuelles telles que la Raspberry Pi.</p>
        <p>L'électronique a également été totalement remplacée, afin de tirer
            parti des composants performants disponibles de nos jours.</p>
        <p>Un environnement logiciel très complet a été développé pour
            permettre d'ajouter facilement de nouvelles démonstrations.</p>
        <p><a class="btn btn-default" href="/detail/works" role="button">Détails &raquo;</a></p>
    </div>
    <div class="col-md-4">
        <h2>Technique</h2>
        <p>Youpi dispose maintenant d'un centre de contrôle intégré et ne dépend
            plus d'un ordinateur connecté pour fonctionner.</p>
        <p>Il est cependant capable de dialoguer avec l'extérieur grâce à un
            serveur HTTP interne <i>(que vous êtes en train d'utiliser)</i>.</p>
        <p>L'électronique d'origine assurant le pilotage des moteurs pas
            à pas a été remplacée par des composants intelligents, prenant en
            charge directement le contrôle de bas niveau. </p>
        <p><a class="btn btn-default" href="/detail/tech" role="button">Détails &raquo;</a></p>
    </div>
</div>

%include("epilog.tpl", version=version)
