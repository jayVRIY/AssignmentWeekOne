import SwiftUI
struct MovieDetail: View{
    var movieDetail:Movie
    init(for movieDetail:Movie){
        self.movieDetail=movieDetail
    }
    var body: some View{
        VStack(spacing:0){
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movieDetail.backdrop_path)"))
            VStack(alignment: .leading, spacing: 30){
                VStack{
                    HStack{
                        Spacer()
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w185\(movieDetail.poster_path)")){image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:120)
                        }placeholder: {
                            ProgressView()
                        }.offset()
                            .border(.white, width: 2)
                        Spacer()
                        VStack{
                            Text(movieDetail.title).fontWeight(.semibold)
                            Text(movieDetail.release_date)
                        }.offset(y:25)
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    Text(movieDetail.overview)
                }.offset(y:-80)
                Spacer(
                )
            }
            .frame(maxWidth:.infinity, maxHeight: .infinity )
            .background(.black)
            .foregroundColor(.white)
        
        }.ignoresSafeArea()
    }
}
