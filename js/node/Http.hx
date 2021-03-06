package js.node;

import js.node.events.EventEmitter ;
import js.node.http.*;
import js.node.net.Socket;
import js.node.Url;
import js.node.Crypto;
/* HTTP ............................................*/
  
/* 
   Emits:
   data,end,close
 */
extern class HttpServerReq 
extends EventEmitter
{
  var method:String;
  var url:String;
  var headers:Dynamic;
  var trailers:Dynamic;
  var httpVersion:String;
  var connection:Socket;
  function setEncoding(enc:String):Void;
  function pause():Void;
  function resume():Void;
}

/* Emits:
   data,end,close
*/
extern class HttpClientResp 
extends EventEmitter 
{
  var statusCode:Int;
  var httpVersion:String;
  var headers:Dynamic;
  var client:HttpClient;
  function setEncoding(enc:String):Void;
  function resume():Void;
  function pause():Void;  
}

typedef HttpServerListenerMethod = HttpServerReq->ServerResponse->Void;
interface IHttpServerListener {}

abstract HttpServerListener( Dynamic ) 
  from HttpServerListenerMethod to HttpServerListenerMethod
  from IHttpServerListener to IHttpServerListener
{}

extern class HttpClient 
extends EventEmitter 
{
  function request(method:String,path:String,?headers:Dynamic):ClientRequest;
  function verifyPeer():Bool;
  function getPeerCertificate():CryptoPeerCert;
}

/* 
 */
typedef HttpReqOpt = {
  @:optional var host : String;
  @:optional var hostname : String;
  @:optional var port : Int;
  @:optional var localAddress : String;
  @:optional var socketPath : String;
  @:optional var method : String;
  @:optional var path : String;
  @:optional var headers : Dynamic;
  @:optional var auth : Dynamic;
  @:optional var agent : Dynamic;
}

extern class Http 
implements npm.Package.Require<"http","*"> 
{
  static function createServer(?listener:HttpServerListener):Server;
  static function createClient(port:Int,host:String):HttpClient;
  @:overload(function(parsedUrl:UrlObj,res:HttpClientResp->Void):ClientRequest {})
  static function request(options:HttpReqOpt,res:HttpClientResp->Void):ClientRequest;
  @:overload(function(parsedUrl:UrlObj,res:HttpClientResp->Void):ClientRequest {})
  static function get(options:HttpReqOpt,res:HttpClientResp->Void):ClientRequest;
  static function getAgent(host:String,port:Int):Agent;
}
