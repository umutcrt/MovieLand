//
//  NowPlayingViewModel.swift
//  movieLand
//
//  Created by Umut Cörüt on 10.11.2022.
//

import Foundation
import Alamofire
class MoviesViewModel : ObservableObject {
    
    @Published var movies = [Result]()
    @Published var totalPage = 0
    @Published var pageCount = 0
    @Published var movies2 = [Result2]()
    @Published var movies3 = [Result3]()
    

    
//    func refreshMovie() {
//        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=c4bc339b27ebb4b0594d9c50e9100897&page=1") else {
//            return
//        }
//        let task = URLSession.shared.dataTask(with: url) {data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            do {
//                let newMovies = try JSONDecoder().decode(Welcome.self, from: data)
//                DispatchQueue.main.async {
//                    self.movies = newMovies.results
//                }
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
//    }
    
    func getMovies() {
            pageCount += 1
            print(pageCount)
            AF.request("https://api.themoviedb.org/3/movie/upcoming?api_key=c4bc339b27ebb4b0594d9c50e9100897&page=\(pageCount)", method: .get).responseDecodable(of:Welcome.self) { response in
                switch response.result {
                case .success(let data):
                    let results = data.results
                    
                    self.movies += results
                    let pageResult = data.totalPages
                    self.totalPage = pageResult
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
                if results.isEmpty {
                    self.movies3 = [Result3(content: "Movie content not available.", id: "")]
                } else {
                    self.movies3 = results
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension DateFormatter {
    static let posixFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
func formatDate(dateString: String, inFormat: String = "yyyy-MM-dd", outFormat: String = "dd.MM.yyyy") -> String? {

    let dateFormatter = DateFormatter.posixFormatter
   
    dateFormatter.dateFormat = inFormat
    guard let date = dateFormatter.date(from: dateString) else { return nil }

    dateFormatter.dateFormat = outFormat
    return dateFormatter.string(from: date)
}
