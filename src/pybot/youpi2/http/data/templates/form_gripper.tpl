<form id="form_gripper" class="form-horizontal" action="/api/v1/gripper" method="PUT">
    <div class="row">
        <div class="col-sm-8 col-sm-offset-2">
            <fieldset>
                <legend>Pince</legend>
                <div class="col-sm-8">
                    <div class="form-group">
                        <label for="hand" class="col-sm-6 control-label">Etat</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="gripper">
                                <option>ouverte</option>
                                <option>fermée</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <button type="submit" class="btn btn-success btn-block">Envoyer</button>
                </div>
            </fieldset>
        </div>
    </div>
</form>
