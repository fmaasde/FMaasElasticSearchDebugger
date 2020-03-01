{extends file="parent:backend/_base/layout.tpl"}

{block name="content/main"}
    <div class="page-header">
        <h1><code>elasticsearch</code> debugger</h1>
    </div>
    <br/><br/>
    <h2>Info</h2>
    <p>Click the Buttons and  wait till the preview shows something.<br/>
    After that you can beautfy the JSON with the "Make the  Output readable"-Button.<br/><br/>
    Have Fun Debugging elasticsearch in the Shopware Backend  ;-)<br/>
    </p>
    <br/><br/>
    <h2>JSON-Viewer</h2>
    <script type="text/javascript" src="{link file="backend/_resources/js/jquery-2.1.4.min.js"}"></script>
    <script type="text/javascript" src="{link file="backend/_resources/js/jquery-3.3.1.slim.min.js"}"></script>
    <script type="text/javascript" src="{link file="backend/_resources/js/jquery.json-editor.min.js"}"></script>


    <div class="btn-group" role="group" aria-label="...">
        <button type="button" class="btn btn-default btn-getShopwareEsConfig">Shopware ES Config</button>
    </div>
    <br/>
    <br/>
    <div class="btn-group" role="group" aria-label="...">
        <button type="button" class="btn btn-default btn-getCountBacklog">Count Backlog</button>
        <button type="button" class="btn btn-danger btn-getClearBacklog">Delete Backlog</button>
    </div>
    <br/>
    <br/>
    <div class="btn-group" role="group" aria-label="...">
        <button type="button" class="btn btn-default btn-getCountBackendBacklog">Count Backend Backlog</button>
        <button type="button" class="btn btn-danger btn-getClearBackendBacklog">Delete Backend Backlog</button>
    </div>
    <br/>
    <br/>
    <div class="btn-group" role="group" aria-label="...">
        <button type="button" class="btn btn-default btn-getEsStatus">ES Status</button>
        <button type="button" class="btn btn-default btn-getClusterHealth">Cluster Health</button>
        <button type="button" class="btn btn-default btn-getAllIndexes">List All Indexes</button>
        <button type="button" class="btn btn-default btn-getAllSettings">List All Settings</button>
        <button type="button" class="btn btn-warning btn-getClusterStatus">Cluster Status (Slow)</button>
    </div>
    <br/>
    <br/>
    <div class="btn-group" role="group" aria-label="...">
        <button type="button" class="btn btn-danger btn-getClearCache">ClearCache</button>
        <button type="button" class="btn btn-danger btn-getDeleteAllIndexes">Delete All Indexes</button>
    </div>
    <br/>
    <br/>
    <div class="btn-group" role="group" aria-label="...">
        <button type="button" class="btn btn-warning btn-getSWEsIndexPopulateOneShop">(experimental) Index shopID=1</button>
        <button type="button" class="btn btn-warning btn-getSWEsIndexPopulate">(experimental) Index all Shops</button>
    </div>
    <br/>
    <br/>
    <br/>
    <div class="panel panel-default">
        <div class="panel-heading"><h3 class="panel-title">JSON</h3></div>
        <div class="panel-body">
            <label for="json-input">Preview</label><br/>
            <textarea id="json-input">
                {if $textarea}
                    {$textarea}
                {else}
                    "empty"
                {/if}
            </textarea><br/>

            <button id="translate">Make the Output readable</button><br/>


            <pre id="json-display"></pre>
        </div>
    </div>
    <br/>


    <script type="text/javascript">
        function getJson() {
            try {
                return JSON.parse($('#json-input').val());
            } catch (ex) {
                alert('Wrong JSON Format: ' + ex);
            }
        }

        var editor = new JsonEditor('#json-display', getJson());
        $('#translate').on('click', function () {
            editor.load(getJson());
        });
    </script>



{*    <div class="panel panel-default">
        <div class="panel-heading"><h3 class="panel-title">Set the window title</h3></div>
        <div class="panel-body">

            <form class="form-horizontal title-form">
                <div class="form-group">
                    <label for="windowTitle" class="col-sm-2 control-label">Title</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="windowTitle" name="title" required placeholder="Your title...">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-primary">Set title</button>
                    </div>
                </div>
            </form>
        </div>
    </div>*}

{/block}
