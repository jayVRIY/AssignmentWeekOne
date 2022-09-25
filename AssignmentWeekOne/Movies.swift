//
//  Movies.swift
//  AssignmentWeekOne
//
//  Created by Jay on 2022/9/16.
//

import SwiftUI
struct MovieList :
    Decodable {
    var dates:SearchDate
    var page:Int
    var results:[Movie]
    var total_pages: Int
    var total_results: Int
}
struct Movie: Decodable,Identifiable{
    var adult:Bool
    var backdrop_path:String
    var genre_ids:[Int]
    var id:Int
    var original_language:String
    var original_title:String
    var overview:String
    var popularity:Double
    var poster_path:String
    var release_date:String
    var title:String
    var video:Bool
    var vote_average:Double
    var vote_count:Int
}
struct SearchDate:Decodable{
    var maximum:String
    var minimum:String
}
class MoviesModel:ObservableObject{
    @Published var movieList :MovieList = MovieList(dates: SearchDate(maximum: "", minimum: ""), page: 0, results: [], total_pages: 0, total_results: 0)
    @MainActor
    func fatchMovies() async {
        do{
            let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
            let (data,_) = try await URLSession.shared.data(from: url)
            let datastr = String(data:data,encoding: .utf8)!
            print( datastr)
            movieList = try JSONDecoder().decode(MovieList.self,from : data)
            print(movieList)
        }catch{
            print(error)
        }
    }
}
