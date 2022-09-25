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
        let moviesObj:[Movie] = movieModel.movieList.results
        TabView{
            NavigationView{
                List{
                    movies
                }.task {
                    await movieModel.fatchMovies()
                }
                .listStyle(.insetGrouped)
                .navigationTitle("movies")
                
            }.tabItem{
                Image(systemName: "film")
                Text("New Playing")
            }
            NavigationView{
                List(){
                    ForEach(1..<moviesObj.count+1){ index in
                        let value = Int(index)
                        if (value % 2 == 1){
                            HStack{
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w185\(moviesObj[value-1].poster_path)")){image in
                                    image.resizable()
                                    
                                }placeholder: {
                                    ProgressView()
                                }
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w185\(moviesObj[value].poster_path)")){image in
                                    image.resizable()
                                }placeholder: {
                                    ProgressView()
                                }
                                
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                    .navigationTitle("Superhero")
                }
                
                .listRowInsets(EdgeInsets())
            }.listStyle(.inset)
                .listRowInsets(EdgeInsets())
                .padding(0)
                .tabItem({
                    Image(systemName: "bolt.circle")
                    Text("Superhero")
                })
        }
    }
    var movies:some View{
        
        ForEach(movieModel.movieList.results){ movie in
            let path = "https://image.tmdb.org/t/p/w185\(movie.poster_path)"
            NavigationLink(destination: MovieDetail(for: movie)){
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
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13")
    }
}
