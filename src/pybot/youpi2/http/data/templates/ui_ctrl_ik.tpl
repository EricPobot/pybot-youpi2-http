%include("ui_prolog.tpl", title="Youpi 2")

<div class="page-header"><h1>Contrôle par cinématique inverse</h1></div>

<p>La cinématique inverse consiste à déterminer les angles que les articulations doivent
    prendre afin que l'effecteur (ici la pince) soit positionnée aux coordonnées demandées.</p>

<p> Les coordonnées sont définies par:</p>
    <ul>
    <li>X, vers l'avant du boîter, égale à 0 au niveau de la face avant,</li>
    <li>Y, vers la droite (en faisant face au boîtier), égale à 0 au niveau de l'axe de rotation
        de la base du bras,</li>
    <li>Z, vers le haut, égale à 0 au niveau de la table.</li>
    </ul>

<p> Il se peut qu'aucune solution n'existe pour la position demandée, soit parce qu'elle
    est hors d'atteinte, soit parce qu'elle nécessite que certaines des articulations
    prennent des positions hors de leurs limites mécaniques.</p>

<form id="form_ik" class="form-horizontal" action="/api/v1/ik?" method="PUT">
    <div class="row">
        <div class="col-sm-8 col-sm-offset-2">
            <fieldset>
                <legend>Position</legend>
                <div class="col-sm-8">
                    <div class="form-group">
                        <label for="x" class="col-sm-6 control-label">X (en mm)</label>
                        <div class="col-sm-4">
                            <input type="number" min="0" max="300"
                                   value="100"
                                   class="form-control" id="x"
                                   placeholder="Entrez une coordonnée">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="y" class="col-sm-6 control-label">Y (en mm)</label>
                        <div class="col-sm-4">
                            <input type="number" min="-100" max="100"
                                   value="0"
                                   class="form-control" id="y"
                                   placeholder="Entrez une coordonnée">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="z" class="col-sm-6 control-label">Z (en mm)</label>
                        <div class="col-sm-4">
                            <input type="number" min="10" max="300"
                                   value="50"
                                   class="form-control" id="z"
                                   placeholder="Entrez une coordonnée">
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <button type="submit" class="btn btn-success btn-block">Envoyer</button>
                    <button type="reset" class="btn btn-default btn-block">Position par défaut</button>
                </div>
            </fieldset>
        </div>
    </div>
</form>


%include("form_gripper.tpl")
%include("epilog.tpl", version=version, ui_app=True)
