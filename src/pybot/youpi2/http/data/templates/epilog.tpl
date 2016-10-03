        <footer>
            <div class="container text-muted">
                <p>Version: {{ version }} - &copy; 2016 POBOT</p>
            </div>
        </footer>
    </div> <!-- /container -->

    <div class="modal fade" id="pleaseWaitDialog" tabindex="-1" role="dialog"
         data-backdrop="static" data-keyboard="false" data-show="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h1>Opération en cours...</h1>
                </div>
                <div class="modal-body">
                    <div class="progress">
                        <div class="progress-bar progress-bar-info progress-bar-striped active"
                             role="progressbar"
                             style="width: 100%;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="/static/js/jquery-3.1.1.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="/static/js/bootstrap.min.js"></script>
    <script src="/static/js/bootstrap-toc.min.js"></script>
    <script src="/static/js/youpi.js"></script>

</body>
</html>
