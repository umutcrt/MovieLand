


import SwiftUI

struct DetailView2: View {
    
    @ObservedObject var moviesDetail2 = MoviesViewModel()
    var choosenMovie2: Result2
    
    var body: some View {
        
        List (moviesDetail2.movies3) { i in
            VStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(choosenMovie2.backdropPath)")) { phase in
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
                    let dateUpdate = choosenMovie2.releaseDate.replacingOccurrences(of: "-", with: ".")
                    Text("\(String(format: "%.1f", choosenMovie2.voteAverage))/10").font(.system(.subheadline, design: .rounded, weight: .semibold)).frame(alignment: .leading)
                    Text("•").foregroundColor(.yellow)
                    Text("\(String(dateUpdate[..<(dateUpdate.firstIndex(of: "T") ?? dateUpdate.endIndex)]))").font(.system(.subheadline, design: .rounded, weight: .semibold))
                    Spacer()
                }
                Text("\(choosenMovie2.title) (\(String(choosenMovie2.releaseDate[..<choosenMovie2.releaseDate.firstIndex(of: "-")!])))")
                    .font(.system(.title3, design: .rounded, weight: .bold)).frame(width: UIScreen.main.bounds.width*0.9, alignment: .topLeading)
                    .lineLimit(2)
                Text(i.content != "" ? i.content : "Movie content not available.")
                    .font(.system(.body, design: .rounded, weight: .semibold)).frame(width: UIScreen.main.bounds.width*0.9, alignment: .topLeading)
            }
        }.listStyle(PlainListStyle())
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                moviesDetail2.getMovieDetail(movieID: choosenMovie2.id)
            }
    }
}

