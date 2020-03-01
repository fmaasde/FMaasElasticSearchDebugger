<?php

use Doctrine\DBAL\Driver\PDOStatement;
use Doctrine\DBAL\Query\QueryBuilder;
use Doctrine\ORM\AbstractQuery;
use Doctrine\ORM\Query\Expr\Join;
use Shopware\Components\CSRFWhitelistAware;



/*
 * (c) shopware AG <info@shopware.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
class Shopware_Controllers_Backend_ElasticSearchDebugger extends Enlight_Controller_Action implements CSRFWhitelistAware
{

    public function preDispatch()
    {
        $this->get('template')->addTemplateDir(__DIR__ . '/../../Resources/views/');
    }

    public function postDispatch()
    {
        $csrfToken = $this->container->get('BackendSession')->offsetGet('X-CSRF-Token');
        $this->View()->assign([ 'csrfToken' => $csrfToken ]);
    }

    public function indexAction()
    {
/*        $esConfig = Shopware()->Container()->getParameter('shopware.es');
        $esClient = $esConfig["client"];
        $esHost = $esClient["hosts"][0];
        $url = 'http://'.$esHost.'/';*/



        //$textarea = $this->getCurl($url, 4);
        //$textarea = $this->getShopwareEsConfig();

        $this->View()->assign(['textarea' => $textarea]);
    }

    public function getSWEsIndexPopulate(){
        $shDir = dirname(__DIR__ );

        $shDir =  dirname($shDir);
        $shDir = $shDir. '/Resources/sh/';

        $shopwareRoot = Shopware()->DocPath();
        $execute = "cd ". $shDir . " && ./SwEsIndexPopulate.sh " . $shopwareRoot;// . " " . $shopId;

        $output = shell_exec($execute);
        //$output = "{  \"sw:es:index:populate\": \"" . $output . "\" }";
        $json_decode = htmlspecialchars(json_encode($output), ENT_QUOTES, 'UTF-8');

        return $json_decode;
    }

    public function getSWEsIndexPopulateOneShop(){
        $shDir = dirname(__DIR__ );

        $shDir =  dirname($shDir);
        $shDir = $shDir. '/Resources/sh/';

        $shopwareRoot = Shopware()->DocPath();
        $shopId  = 1;
        $execute = "cd ". $shDir . " && ./SwEsIndexPopulate.sh " . $shopwareRoot . " " . $shopId;

        $output = shell_exec($execute);
        //$output = "{  \"sw:es:index:populate\": \"" . $output . "\" }";
        $json_decode = htmlspecialchars(json_encode($output), ENT_QUOTES, 'UTF-8');

        return $json_decode;
    }

    public function execAction()
    {
        $esConfig = Shopware()->Container()->getParameter('shopware.es');
        $esClient = $esConfig["client"];
        $esHost = $esClient["hosts"][0];
        $url = 'http://'.$esHost.'/';

        $controllerName = $this->Request()->getParam('controllerName');

        if ($controllerName){
            echo $this->$controllerName($url);
        }
    }

    public function getShopwareEsConfig(){
        return json_encode(Shopware()->Container()->getParameter('shopware.es'),JSON_PRESERVE_ZERO_FRACTION);
    }

    public function getEsStatus($url){
        return $this->getCurl($url, 0);
    }

    public function getClusterHealth($url){
        return $this->getCurl($url, 1);
    }

    public function getClusterStatus($url){
        return $this->getCurl($url, 2);
    }

    public function getAllIndexes($url){
        return $this->getCurl($url, 3);
    }

    public function getAllSettings($url){
        return $this->getCurl($url, 4);
    }

    /**
     * @throws \Exception
     *
     * @return string
     */
    public function getCountBacklog()
    {
        /** @var QueryBuilder $queryBuilder */
        $queryBuilder = $this->get('dbal_connection')->createQueryBuilder();

        $query = $queryBuilder
            ->select('count(id)')
            ->from('s_es_backlog');

        $result = $query->execute()->fetchColumn();

        $result = "{ \"s_es_backlog\": ".$result."}";

        return $result;
    }

    /**
     * @throws \Exception
     *
     */
    public function getClearBacklog(): void
    {
        $output = "{\"before\": ";
        $output  = $output.$this->getCountBacklog();

        /** @var QueryBuilder $queryBuilder */
        $this->get('dbal_connection')->exec('TRUNCATE TABLE `s_es_backlog`');

        $output  = $output.", \"status\": \"s_es_backlog truncated\", \"after\": ".$this->getCountBacklog()."}";

        echo $output;
    }

    /**
     * @throws \Exception
     *
     * @return string
     */
    public function getCountBackendBacklog()
    {
        /** @var QueryBuilder $queryBuilder */
        $queryBuilder = $this->get('dbal_connection')->createQueryBuilder();

        $query = $queryBuilder
            ->select('count(id)')
            ->from('s_es_backend_backlog');

        $result = $query->execute()->fetchColumn();

        $result = "{ \"s_es_backend_backlog\": ".$result."}";
        return $result;
    }

    /**
     * @throws \Exception
     *
     */
    public function getClearBackendBacklog(): void
    {
        $output = "{\"before\": ";
        $output  = $output.$this->getCountBackendBacklog();

        /** @var QueryBuilder $queryBuilder */
        $this->get('dbal_connection')->exec('TRUNCATE TABLE `s_es_backend_backlog`');

        $output  = $output.", \"status\": \"s_es_backlog truncated\", \"after\": ".$this->getCountBackendBacklog()."}";

        echo $output;
    }

    public function getclearCache($url){
        $url = $url.'_cache/clear';
        return $this->callAPI('POST',$url);
    }

    /**
     * @desc    Get information from ES
     *
     * @param   string $url    The Adress of the ES
     * @param   int  $option   Define the Information you want
     *
     *
     */
    private function getCurl($url, $option) {
        switch ($option) {
            case 0: $url = $url;break; // Status
            case 1: $url = $url.'_cluster/health';break; //Cluster Health
            case 2: $url = $url.'_cluster/state';break; // Cluster Status
            case 3: $url = $url.'_cat/indices?format=json';break; // list all indexes
            case 4: $url = $url.'_all/_settings?flat_settings=true';break; // list all settings

        }

        return $this->callAPI('GET',$url);
    }

    /**
     * @desc    Do a DELETE request with cURL
     *
     * @param   string $path   path that goes after the URL fx. "/user/login"
     * @param   array  $json   If you need to send some json with your request.
     *                         For me delete requests are always blank
     */
    public function getDeleteAllIndexes($url)
    {
        $url = $url.'_all';

        return $this->callAPI('DELETE',$url);
    }

    public function callAPI($method, $url, $data = NULL) {
        $curl = curl_init($url);

        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);

        if ($data){
            curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($data));
        }

        switch ($method) {
            case "GET":
                curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "GET");
                break;
            case "POST":
                curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "POST");
                break;
            case "PUT":
                curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "PUT");
                break;
            case "DELETE":
                curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "DELETE");
                if ($data){
                    curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($data));
                }
                break;
        }
        $response = curl_exec($curl);
        $data = $response;
        //$data = json_decode($response);

        /* Check for 404 (file not found). */
        $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        // Check the HTTP Status code
        switch ($httpCode) {
            case 200:
                $error_status = "200: Success";
                return ($data);
                break;
            case 404:
                $error_status = "404: API Not found";
                break;
            case 500:
                $error_status = "500: servers replied with an error.";
                break;
            case 502:
                $error_status = "502: servers may be down or being upgraded. Hopefully they'll be OK soon!";
                break;
            case 503:
                $error_status = "503: service unavailable. Hopefully they'll be OK soon!";
                break;
            default:
                $error_status = "Undocumented error: " . $httpCode . " : " . curl_error($curl);
                break;
        }
        curl_close($curl);
        echo $error_status;
        die;
    }

    public function getWhitelistedCSRFActions()
    {
        return ['index'];
    }
}
