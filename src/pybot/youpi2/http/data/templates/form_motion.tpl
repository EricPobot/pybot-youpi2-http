<form id="form_motion" class="form-horizontal" action="{{ action }}" method="PUT">
    <div class="row">
        <div class="col-sm-8 col-sm-offset-2">
            <fieldset>
                <legend>{{ legend }}</legend>
                <div class="col-sm-8">
                    <div class="form-group">
                        <label for="base" class="col-sm-6 control-label">Base</label>
                        <div class="col-sm-4">
                            <input type="number" min="-175" max="175"
                                   value="0"
                                   class="form-control" id="base"
                                   placeholder="Entrez un angle">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="shoulder" class="col-sm-6 control-label">Epaule</label>
                        <div class="col-sm-4">
                            <input type="number" min="-90" max="90"
                                   value="0"
                                   class="form-control" id="shoulder"
                                   placeholder="Entrez un angle">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="elbow" class="col-sm-6 control-label">Coude</label>
                        <div class="col-sm-4">
                            <input type="number" min="-90" max="90"
                                   value="0"
                                   class="form-control" id="elbow"
                                   placeholder="Entrez un angle">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="wrist" class="col-sm-6 control-label">Poignet</label>
                        <div class="col-sm-4">
                            <input type="number" min="-90" max="90"
                                   value="0"
                                   class="form-control" id="wrist"
                                   placeholder="Entrez un angle">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="hand" class="col-sm-6 control-label">Rotation de la pince</label>
                        <div class="col-sm-4">
                            <input type="number" min="-180" max="180"
                                   value="0"
                                   class="form-control" id="hand"
                                   placeholder="Entrez un angle">
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <button type="submit" class="btn btn-success btn-block">Envoyer</button>
                    <button type="reset" class="btn btn-default btn-block">Remise à zéro</button>
                </div>
            </fieldset>
        </div>
    </div>
</form>
