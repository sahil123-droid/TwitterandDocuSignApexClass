@isTest
global class TwitterPost_UtilityMock  implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        if(String.valueOf(request.getEndpoint()).contains('home_timeline')){
            response.setBody('[{"id":"test id", "name":"test name"}]');
        }
        else if(String.valueOf(request.getEndpoint()).contains('liked_tweets')){
            response.setBody('{ "data" : {"id" : "123456789", "text" : "blah blah"} }');
        }
        else if(String.valueOf(request.getEndpoint()).contains('likes')){
            response.setBody('{ "data" : {"liked" : "true"} }');
        }
        else if(String.valueOf(request.getEndpoint()).contains('update')){
            response.setBody('{ "postcreated" : "true" , "id_str" : "123456789" }');
        }
        response.setStatusCode(200);
        return response; 
    }
}