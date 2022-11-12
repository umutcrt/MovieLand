


import SwiftUI

struct DetailView: View {
    
    @ObservedObject var moviesDetail = MoviesViewModel()
    var choosenMovie: Result
    
    var body: some View {
        List (moviesDetail.movies3) { i in
            VStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(choosenMovie.backdropPath)")) { phase in
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
                }
                .frame(width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.3, alignment: .bottom)
                .edgesIgnoringSafeArea(.all)
                HStack {
                    Image("IMDB Logo@0.0x").padding()
                    Image("Rate Icon")
                    let dateUpdate = choosenMovie.releaseDate.replacingOccurrences(of: "-", with: ".")
                    Text("\(String(format: "%.1f", choosenMovie.voteAverage))/10").font(.system(.subheadline, design: .rounded, weight: .semibold)).frame(alignment: .leading)
                    Text("•").foregroundColor(.yellow)
                    Text("\(String(dateUpdate[..<(dateUpdate.firstIndex(of: "T") ?? dateUpdate.endIndex)]))").font(.system(.subheadline, design: .rounded, weight: .semibold))
                    Spacer()
                }
                Text("\(choosenMovie.title) (\(String(choosenMovie.releaseDate[..<choosenMovie.releaseDate.firstIndex(of: "-")!])))")
                    .font(.system(.title3, design: .rounded, weight: .bold)).frame(width: UIScreen.main.bounds.width*0.9, alignment: .topLeading)
                    .lineLimit(2)
                Text(i.content != "" ? i.content : "Movie content not available.")
                    .font(.system(.body, design: .rounded, weight: .semibold)).frame(width: UIScreen.main.bounds.width*0.9, alignment: .topLeading)
            }
        }.listStyle(PlainListStyle())
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                moviesDetail.getMovieDetail(movieID: choosenMovie.id)
            }
    }
}
