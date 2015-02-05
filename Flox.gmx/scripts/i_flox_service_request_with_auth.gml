/** Makes an asynchronous HTTP request at the server, with custom authentication data. */
/*private function requestWithAuthentication(method:String, path:String, data:Object, 
                                           authentication:Authentication,
                                           onComplete:Function, onError:Function):void
{

var method = argument0; // String
var path = argument1; // String
var data = argument2; // DSMap
var authentication = argument3; // DSMap
var onComplete = argument4; // script(Any result, Number status)
var onError = argument5; // script(String error, Number status, Any cachedResult)

// This is only null while a login is in process. To avoid problems with player
// authentication, we do not allow that to happen. The error callback is executed
// with a delay so that the method acts the same way as if this was a server error.
if not ds_exists(authentication,ds_type_map){
    setTimeout(execute, 1, onError, "Cannot make request while login is in process",
                           HttpStatus.FORBIDDEN);
    return;
}
    
if method == http_method_get and ds_exists(data,ds_type_map) {
    path += "?" + encodeForUri(data);
    data = null;
}
    
    var eTag:String;
    var cachedResult:Object = null;
    var headers:Object = {};
    var xFloxHeader:Object = {
        sdk: { 
            type: "as3", 
            version: Flox.VERSION
        },
        player: { 
            id:        authentication.playerId,
            authType:  authentication.type,
            authId:    authentication.id,
            authToken: authentication.token
        },
        gameKey: mGameKey,
        bodyCompression: "zlib",
        dispatchTime: DateUtil.toString(new Date())
    };
    
    headers["Content-Type"] = "application/json";
    headers["X-Flox"] = xFloxHeader;
    
    if (mCache.containsKey(path) && (method == HttpMethod.GET || method == HttpMethod.PUT))
    {
        eTag = mCache.getMetaData(path, "eTag") as String;
        cachedResult = mCache.getObject(path);

        if (cachedResult)
        {
            if (method == HttpMethod.GET) headers["If-None-Match"] = eTag;
            else if (method == HttpMethod.PUT) headers["If-Match"] = eTag;
        }
    }
    
    if (mAlwaysFail)
    {
        setTimeout(execute, 1, onError, "forced failure", 0, cachedResult);
        return;
    }

    var loader:URLLoader = new URLLoader();
    loader.addEventListener(Event.COMPLETE, onLoaderComplete);
    loader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
    loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onLoaderHttpStatus);
    
    var httpStatus:int = -1;
    var url:String = createURL("/api/games", mGameID, path);
    var request:URLRequest = new URLRequest(mUrl);
    var requestData:Object = { 
        method: method, url: url, headers: headers, body: encode(data) 
    };
    
    request.method = URLRequestMethod.POST;
    request.data = JSON.stringify(requestData);
    
    loader.load(request);
    
    function onLoaderComplete(event:Event):void
    {
        closeLoader();
        
        if (httpStatus != HttpStatus.OK)
        {
            execute(onError, "Flox Server unreachable", httpStatus, cachedResult);
        }
        else
        {
            try
            {
                var response:Object = JSON.parse(loader.data);
                var status:int = parseInt(response.status);
                var headers:Object = response.headers;
                var body:Object = getBodyFromResponse(response);
            }
            catch (e:Error)
            {
                execute(onError, "Invalid response from Flox server: " + e.message,
                        httpStatus, cachedResult);
                return;
            }
            
            if (status < 400) // success =)
            {
                var result:Object = body;
                
                if (method == HttpMethod.GET)
                {
                    if (status == HttpStatus.NOT_MODIFIED)
                        result = cachedResult;
                    else
                        mCache.setObject(path, body, { eTag: headers.ETag });
                }
                else if (method == HttpMethod.PUT)
                {
                    if ("createdAt" in result && "updatedAt" in result)
                    {
                        data = cloneObject(data);
                        data.createdAt = result.createdAt;
                        data.updatedAt = result.updatedAt;
                    }
                    
                    mCache.setObject(path, data, { eTag: headers.ETag });
                }
                else if (method == HttpMethod.DELETE)
                {
                    mCache.removeObject(path);
                }
                
                execute(onComplete, result, status);
            }
            else // error =(
            {
                var error:String = (body && body.message) ? body.message : "unknown";
                execute(onError, error, status, cachedResult);
            }
        }
    }
    
    function onLoaderError(event:IOErrorEvent):void
    {
        closeLoader();
        execute(onError, "IO " + event.text, httpStatus, cachedResult);
    }
    
    function onLoaderHttpStatus(event:HTTPStatusEvent):void
    {
        httpStatus = event.status;
    }
    
    function closeLoader():void
    {
        loader.removeEventListener(Event.COMPLETE, onLoaderComplete);
        loader.removeEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
        loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onLoaderHttpStatus);
        loader.close();
    }
}