//
//  NowPlayingViewModel.swift
//  movieLand
//
//  Created by Umut Cörüt on 10.11.2022.
//

import Foundation
import Alamofire
class MoviesViewModel : ObservableObject {
    
    var pageCount = 0
    @Published var movies = [Result]()
    @Published var movies2 = [Result2]()
    @Published var movies3 = [Result3]()
    @Published var movieContent = ""
    init() {
        getMovies()
        getSoonMovies()
    }
    func getMovies() {
        pageCount += 1
        AF.request("https://api.themoviedb.org/3/movie/upcoming?api_key=c4bc339b27ebb4b0594d9c50e9100897&page=\(pageCount)", method: .get).responseDecodable(of:Welcome.self) { response in
            switch response.result {
            case .success(let data):
                let results = data.results
                self.movies += results
            case .failure(let error):
                print(error)
            }
        }
    }
    func getSoonMovies() {
        AF.request("https://api.themoviedb.org/3/movie/now_playing?api_key=c4bc339b27ebb4b0594d9c50e9100897&page=1", method: .get).responseDecodable(of:Welcome2.self) { response in
            switch response.result {
            case .success(let data):
                let results = data.results
                self.movies2 = results
            case .failure(let error):
                print(error)
            }
        }
    }
    func getMovieDetail(movieID: Int) {
        AF.request("https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=c4bc339b27ebb4b0594d9c50e9100897", method: .get).responseDecodable(of:Welcome3.self) { response in
            switch response.result {
            case .success(let data):
                let results = data.results
                self.movies3 = results
            case .failure(let error):
                print(error)
            }
        }
    }
}
