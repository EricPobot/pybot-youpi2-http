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
        <h2>Détails technique</h2>
        <p>Youpi utilise une approche modulaire aussi bien au niveau hardware que software, dans le
            but d'être le plus évolutif possible et d'encourager les contributions.</p>
        <p>Les bus I2C et SPI sont mis à profit pour faire communiquer les différents sous-ensembles
            avec la Raspberry Pi de supervision.</p>
        <p>Le bus système D-Bus et le système de fichiers virtuels sont utilisés pour faire communiquer
            les différents composants logiciels.</p>
        <p><a class="btn btn-default" href="/detail/tech" role="button">Détails &raquo;</a></p>
    </div>
</div>
<div class="row">
    <div class="col-md-6 col-md-offset-3">
        <h2>Démonstrations</h2>
        <p>Diverses démonstrations sont incluses dans Youpi et illustrent différentes capacités.</p>
        <p>Elles ont été développées en tant que petites applications indépendantes mettant en
            oeuvre les ressources matérielles de Youpi (le bros, le panneau d'affichage).</p>
        <p>Elles illustrent également la manière de développer de telles applications, et par
            conséquent la facilité avec laquelle Youpi peut être étendu.</p>
        <p><a class="btn btn-default" href="/detail/demos" role="button">Détails &raquo;</a></p>
    </div>
</div>

%include("epilog.tpl", version=version)
