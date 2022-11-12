//
//  ContentView.swift
//  movieLand
//
//  Created by Umut Cörüt on 10.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var moviesVM = MoviesViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(moviesVM.movies2) { element in
                                NavigationLink(destination: DetailView2(choosenMovie2: element)) {
                                    ZStack {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(element.backdropPath)")) { phase in
                                            if let image = phase.image {
                                                image.resizable()
                                            } else if phase.error != nil {
                                                ZStack {
                                                    Color.brown
                                                    Text("No image!")
                                                }
                                            } else {
                                                ProgressView{
                                                    Text("Loading...").foregroundColor(Color.yellow).font(Font.title)
                                                }
                                            }
                                        }.frame(width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.3, alignment: .center)
                                        VStack {
                                            Spacer()
                                            ZStack {
                                                Color(.black).opacity(0.5)
                                                VStack {
                                                    HStack {
                                                        Text("\(element.title) (\(String(element.releaseDate[..<element.releaseDate.firstIndex(of: "-")!])))").font(.system(size: 18, weight: .bold, design: .serif)).frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.05, alignment: .bottomLeading).foregroundColor(.white)
                                                            .lineLimit(2)
                                                        Spacer()
                                                    }
                                                    Text(element.overview).font(.system(.subheadline, design: .serif, weight: .light)).frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.05, alignment: .topLeading).foregroundColor(.white)
                                                        .lineLimit(2)
                                                }
                                            }.frame(width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.01, alignment: .bottomLeading)
                                        }
                                    }
                                }
                            }
                        }
                    }.frame(width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.30, alignment: .center)
                        .edgesIgnoringSafeArea(.all)
                    
                    List(moviesVM.movies) { element in
                        NavigationLink(destination: DetailView(choosenMovie: element)) {
                            HStack {
                                Spacer()
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(element.posterPath)")) { phase in
                                    if let image = phase.image {
                                        image.resizable()
                                    } else if phase.error != nil {
                                        ZStack {
                                            Color.brown
                                            Text("No image!")
                                        }
                                    } else {
                                        ProgressView{
                                            Text("Loading...").foregroundColor(Color.yellow).font(Font.title)
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
                            }
                        }
                    }.listStyle(.plain)
                        .refreshable {
                            moviesVM.getMovies()
                        }
                }
            }
        }.onAppear {
            moviesVM.getMovies()
            moviesVM.getSoonMovies()
        }
    }
}
