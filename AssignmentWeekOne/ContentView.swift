//
//  ContentView.swift
//  AssignmentWeekOne
//
//  Created by Jay on 2022/9/16.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var movieModel = MoviesModel()
    
    var body: some View {
        NavigationView{
            List{
                movies
            }.task {
                await movieModel.fatchMovies()
            }
            .listStyle(.insetGrouped)
            .navigationTitle("movies")
        }
    }
    var movies:some View{
        
        ForEach(movieModel.movieList.results){ movie in
            let path = "https://image.tmdb.org/t/p/w185\(movie.poster_path)"
            HStack(spacing:20){
                AsyncImage(url:URL(string:path)) {image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                }placeholder: {
                    ProgressView()
                }
                .frame(minWidth:90)
                .cornerRadius(10)
                .padding(8)
                
                VStack(alignment: .leading,spacing: 8){
                    Text(movie.original_title)
                        .font(.body)
                        .fontWeight(.semibold)
                    Text(movie.overview)
                }
            }.frame( height:150 )
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13")
    }
}
