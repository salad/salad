var server, service;
var urlString = "?url=";
var currentResponse;

var page = require('webpage').create();
function handle_status (status) {

    // console.log(status);
    // console.log(response);
    if (status !== 'success') {
        console.log('FAIL to load the address');
    }
    currentResponse.statusCode = 200;
    currentResponse.write('{"status": "' + status + '"}');
    currentResponse.close();
}

server = require('webserver').create();

service = server.listen(8080, function (request, response) {
    currentResponse = response;
    var page_to_open = request.url.substring(request.url.indexOf(urlString)+urlString.length);
    // console.log(page_to_open);
    page.open(page_to_open, handle_status);
});