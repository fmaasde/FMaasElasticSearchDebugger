<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="{link file="backend/_resources/css/bootstrap.min.css"}">
    <link rel="stylesheet" href="{link file="backend/_resources/css/bootstrap-theme-shopware.css"}">
    <style type="text/css">
        #json-display {
            border: 2px solid #000;
            margin: 0;
            padding: 10px 20px;
        }

/*        #json-input{
            display: none;
        }*/
    </style>
</head>
<body role="document" style="padding-top: 80px">

<!-- Fixed navbar -->
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a id="test" class="navbar-brand" href="#">elasticsearch debugger</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li{if {controllerAction} === 'index'} class="active"{/if}><a href="{url controller="ElasticSearchDebugger" action="index" __csrf_token=$csrfToken}">Home</a></li>
                {*<li{if {controllerAction} === 'list'} class="active"{/if}><a href="{url controller="ElasticSearchDebugger" action="list" __csrf_token=$csrfToken}">Controller loaded list</a></li>
                <li{if {controllerAction} === 'emotion'} class="active"{/if}><a href="{url controller="ElasticSearchDebugger" action="emotion" __csrf_token=$csrfToken}">Ajax loaded list</a></li>
                <li{if {controllerAction} === 'config'} class="active"{/if}><a href="{url controller="ElasticSearchDebugger" action="config" __csrf_token=$csrfToken}">Plugin Config Form</a></li>*}
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>

<div class="container theme-showcase" role="main">
    {block name="content/main"}{/block}
</div> <!-- /container -->

<script type="text/javascript" src="{link file="backend/base/frame/postmessage-api.js"}"></script>
<script type="text/javascript" src="{link file="backend/_resources/js/jquery-2.1.4.min.js"}"></script>
<script type="text/javascript" src="{link file="backend/_resources/js/bootstrap.min.js"}"></script>

{block name="content/layout/javascript"}
<script type="text/javascript">
    $(function() {
/*        $('.title-form').on('submit', function(event) {
            var $this = $(this),
                values = $this.serializeArray().reduce(function(obj, item) {
                    obj[item.name] = item.value;
                    return obj;
                }, {});
            event.preventDefault();

            postMessageApi.window.setTitle(values.title);
        });*/


        $('.btn-getShopwareEsConfig').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getShopwareEsConfig" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }
            gInfo();
        });

        $('.btn-getEsStatus').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getEsStatus" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }

            gInfo();
        });

        $('.btn-getCountBacklog').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getCountBacklog" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }

            gInfo();
        });

        $('.btn-getClearBacklog').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getClearBacklog" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }

            gInfo();
        });

        $('.btn-getCountBackendBacklog').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getCountBackendBacklog" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }

            gInfo();
        });

        $('.btn-getClearBackendBacklog').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getClearBackendBacklog" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }

            gInfo();
        });

        $('.btn-getClusterHealth').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getClusterHealth" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }

            gInfo();
        });

        $('.btn-getClusterStatus').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getClusterStatus" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }

            gInfo();
        });

        $('.btn-getAllIndexes').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getAllIndexes" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }

            gInfo();
        });

        $('.btn-getAllSettings').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getAllSettings" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }

            gInfo();
        });

        $('.btn-getClearCache').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getClearCache" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }

            gInfo();
        });

        $('.btn-getDeleteAllIndexes').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getDeleteAllIndexes" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }

            gInfo();
        });

        $('.btn-getSWEsIndexPopulateOneShop').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getSWEsIndexPopulateOneShop" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }

            gInfo();
        });

        $('.btn-getSWEsIndexPopulate').on('click',function(){
            function gInfo() {
                var url = "{url controller="ElasticSearchDebugger" action="exec" controllerName="getSWEsIndexPopulate" __csrf_token=$csrfToken}";
                $('#json-input').load(url);
            }

            gInfo();
        });

    });
</script>
{/block}
{block name="content/javascript"}{/block}
</body>
</html>
