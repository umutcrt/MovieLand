//
//  ContentView.swift
//  movieLand
//
//  Created by Umut Cörüt on 10.11.2022.
//

import SwiftUI
import Alamofire

struct WelcomeView: View {
    @StateObject var network = Network()
    @ObservedObject var moviesVM = MoviesViewModel()
    var body: some View {
        VStack {
            if network.connected {
                ContentView()
            } else {
                NoConnect()
            }
        }.onAppear() {
            network.checkConnection()
        }
    }
}
struct HorizontalView: View {
    @ObservedObject var moviesVM = MoviesViewModel()
    var body: some View {
        TabView(content: {
            ForEach(moviesVM.movies2) { element in
                NavigationLink(destination: DetailView2(choosenMovie2: element)) {
                    ZStack {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(element.backdropPath ?? "")")) { phase in
                            if let image = phase.image {
                                image.resizable()
                            } else if phase.error != nil {
                                ZStack {
                                    Color.brown
                                    Text("No image!").foregroundColor(Color.orange).font(Font.headline)
                                }
                            } else {
                                ProgressView{
                                    Text("Loading...").foregroundColor(Color.yellow).font(Font.headline)
                                }
                            }
                        }.frame(width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.40, alignment: .top)
                            .onAppear() {
                                moviesVM.getSoonMovies()
                            }
                        VStack {
                            Spacer().frame(width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.11, alignment: .top)
                            ZStack {
                                Color(.black).opacity(0.5).frame(width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.14, alignment: .bottom)
                                VStack {
                                    Text("\(element.title) (\(String(element.releaseDate[..<element.releaseDate.firstIndex(of: "-")!])))").font(.system(size: 16, weight: .bold, design: .serif)).frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.02, alignment: .topLeading).foregroundColor(.white)
                                        .lineLimit(2)
                                    Text(element.overview).font(.system(.subheadline, design: .serif, weight: .light)).frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.05, alignment: .topLeading).foregroundColor(.white)
                                        .lineLimit(2)
                                }
                            }
                        }
                    }
                }
            }
        }).tabViewStyle(.page)
            .onAppear() {
                moviesVM.getSoonMovies()
            }
            .frame(width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.30, alignment: .center)
    }
}
struct VerticalView: View {
    @ObservedObject var moviesVM = MoviesViewModel()
    static var idArray = [Int]()
    static var loadControl = true
    
    var body: some View {
        List(moviesVM.movies, id: \.self) { element in
            NavigationLink(destination: DetailView(choosenMovie: element)) {
                HStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(element.posterPath ?? "")")) { phase in
                        if let image = phase.image {
                            image.resizable()
                        } else if phase.error != nil {
                            ZStack {
                                Color.brown
                                Text("No image!").foregroundColor(Color.orange).font(Font.headline)
                            }
                        } else {
                            ProgressView{
                                Text("Loading...").foregroundColor(Color.yellow).font(Font.headline)
                            }
                        }
                    }.frame(width: UIScreen.main.bounds.width*0.277, height: UIScreen.main.bounds.height*0.128, alignment: .leading)
                        .cornerRadius(16)
                    VStack {
                        Text("\(element.title) (\(String(element.releaseDate[..<element.releaseDate.firstIndex(of: "-")!])))").font(.system(size: 16, weight: .bold, design: .serif)).frame(width: UIScreen.main.bounds.width*0.5, height: UIScreen.main.bounds.height*0.05, alignment: .bottomLeading)
                            .lineLimit(3)
                        Text(element.overview).font(.system(.subheadline, design: .serif, weight: .light)).frame(width: UIScreen.main.bounds.width*0.5, height: UIScreen.main.bounds.height*0.05, alignment: .topLeading)
                            .lineLimit(2)
                    }.padding()
                }.onAppear(){
                    if VerticalView.idArray.contains(element.id) {
                    } else {
                        VerticalView.idArray.append(element.id)
                        if moviesVM.totalPage > moviesVM.pageCount + 1 && VerticalView.idArray.count % 20 == 0 {
                            moviesVM.pageCount += 1
                            moviesVM.getMovies()
                        } else {}
                        print(VerticalView.idArray.count)
                    }
                }
            }
        }.refreshable(action: {
            moviesVM.movies.removeAll()
            VerticalView.idArray.removeAll()
            moviesVM.pageCount = 0
            moviesVM.getMovies()
            VerticalView.loadControl = false
        })
        .onAppear(){
            if VerticalView.loadControl {
                moviesVM.movies.removeAll()
                VerticalView.idArray.removeAll()
                moviesVM.pageCount = 0
                moviesVM.getMovies()
                VerticalView.loadControl = false
            } else {}

        }
        .listStyle(.plain)
    }
}
struct ContentView: View {
        
    var body: some View {
        NavigationView {
            VStack {
                HorizontalView()
                VerticalView()
            }.ignoresSafeArea(.all)
        }
    }
}

struct NoConnect: View {
    var body: some View {
        Text("No connection.")
            .onAppear() {
                VerticalView.loadControl = true
            }

            .foregroundColor(Color.orange)
            .font(.system(.title, design: .serif, weight: .light)).frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.5, alignment: .center)
    }
}
