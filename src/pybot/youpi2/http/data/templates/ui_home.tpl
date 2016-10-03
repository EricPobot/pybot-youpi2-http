%include("ui_prolog.tpl", title="Youpi 2")

<div class="jumbotron">
    <div class="container">
        <h1>Youpi 2.0</h1>
        <p>Interface de contrôle.</p>
    </div>
</div>
<div class="row">
    <div class="col-md-4">
        <h2>Contrôle direct des moteurs</h2>
        <p>Contrôle du bras par modification de la position de ses moteurs.</p>
        <p class="text-muted">Le couplage mécanique de la transmission par courroie n'est pas compensé.</p>
        <p><a class="btn btn-default" href="/control/motor" role="button">Essayer &raquo;</a></p>
    </div>
    <div class="col-md-4">
        <h2>Contrôle direct des articulations</h2>
        <p>Contrôle du bras par modification de la position de ses articulations.</p>
        <p class="text-muted">Le couplage mécanique de la transmission par courroie est compensé
            de manière à obtenir les angles demandés entre les différents segments du bras.</p>
        <p><a class="btn btn-default" href="/control/joint" role="button">Essayer &raquo;</a></p>
    </div>
    <div class="col-md-4">
        <h2>Cinématique inverse</h2>
        <p>Contrôle du bras par définition des coordonnées dans l'espace de la pince.</p>
        <p class="text-muted">Les angles à donner aux différentes articulations sont calculés à partir des
            coordonnées cartésiennes de la pince et de sa contrainte d'orientation.</p>
        <p><a class="btn btn-default" href="/control/ik" role="button">Essayer &raquo;</a></p>
    </div>
</div>

%include("epilog.tpl", version=version)
