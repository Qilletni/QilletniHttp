import "http:http.ql"
import "std:util/util.ql"
import "json:json.ql"

HttpClient client = new HttpClient()
JsonConverter json = JsonConverter.createJsonConverter(true)

HttpRequest listRequest = HttpRequest.createGet("https://qpm.qilletni.dev/packages")
HttpResponse response = client.send(listRequest)

if (response.statusCode != 200) {
    printf("Unexpected status code: %d", [response.statusCode])
    exit(1)
}

Map jsonResponse = json.fromJson(response.body)

printf("Got %d packages:", [jsonResponse.get("total")])

any packages = jsonResponse.get("packages")

if (packages is any[]) { // TODO: Checking if `Map[]` doesn't work for some reason? See Qilletni-16
    for (package : packages) {
        printf("%s - %s", [package.get("name"), package.get("latest")])
    }
}
