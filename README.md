# Elasticsearch Debugger

This plugins helps you debugging elasticsearch integration via Backend in Shopware:

* Integrated JSON-Viewer
* Shows
  * Shopware ES Config
  * Count of Backlog Items
  * Count of Backend Backlog Items
  * ES Status
  * Cluster Health
  * List All Indexes
  * List All Settings
  * Cluster Status
  * ClearCache
* Delete
  * Backlog Items
  * Backend Backlog Items
  * All Indexes
* (Experimental) Populate Index
  * shopId=1
  * All

### Installation

Unzip this Plugin in ```custom/plugins``` as ```FMaasElasticSearchDebugger```

Now go to the administration panel of your Shopware installation and install the plugin using our plugin manager. After successfully installing the plugin clear the cache and reload the backend. The module is now available under the "Settings" main menu entry.

### License
The plugin is published under MIT. Please see [License File](LICENSE) for more information.

### Used
[jquery.json-editor](https://github.com/dblate/jquery.json-editor) by [dblate](https://github.com/dblate)

[Lightweight Backend Module Example](https://github.com/shopwareLabs/SwagLightweightModule) - [Doc](https://developers.shopware.com/developers-guide/lightweight-backend-modules/)
