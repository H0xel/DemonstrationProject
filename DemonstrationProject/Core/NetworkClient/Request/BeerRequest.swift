// Created by: Amakhin Ivan 

struct BeerRequest: Request {
    var baseURL: String = "https://api.punkapi.com/"
    var path: String = "v2/beers"
}
