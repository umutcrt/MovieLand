


import SwiftUI

struct DetailView2: View {
    
    @ObservedObject var moviesDetail2 = MoviesViewModel()
    var choosenMovie2: Result2
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(choosenMovie2.backdropPath ?? "")")) { phase in
                if let image = phase.image {
                    image.resizable()
                } else if phase.error != nil {
                    ZStack {
                        Color.brown
                        Text("No image!").foregroundColor(Color.orange).font(Font.title)
                    }
                } else {
                    ProgressView{
                        Text("Loading...").foregroundColor(Color.yellow).font(Font.title)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.30, alignment: .top)
            HStack {
                Image("IMDB Logo@0.0x").padding()
                Image("Rate Icon")
                let dateUpdate = formatDate(dateString: choosenMovie2.releaseDate)
                Text("\(String(format: "%.1f", choosenMovie2.voteAverage))/10").font(.system(.subheadline, design: .rounded, weight: .semibold)).frame(alignment: .leading)
                Text("•").foregroundColor(.yellow)
                Text("\(dateUpdate ?? "No date information.")").font(.system(.subheadline, design: .rounded, weight: .semibold))
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.02, alignment: .top).padding()
            Text("\(choosenMovie2.title) (\(String(choosenMovie2.releaseDate[..<choosenMovie2.releaseDate.firstIndex(of: "-")!])))")
                .font(.system(.title3, design: .rounded, weight: .bold)).frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.02, alignment: .topLeading).padding()
                .lineLimit(2)
            List (moviesDetail2.movies3) { i in
                
                Text(i.content)
                    .font(.system(.body, design: .rounded, weight: .semibold))
            }.listStyle(PlainListStyle())
                .onAppear {
                    moviesDetail2.getMovieDetail(movieID: choosenMovie2.id)
                }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

