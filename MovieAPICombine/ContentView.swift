//
//  ContentView.swift
//  MovieAPICombine
//
//  Created by Weerawut Chaiyasomboon on 07/03/2568.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var movies: [Movie] = []
    @State private var search: String = ""
    @State private var cancellables: Set<AnyCancellable> = []
    
    private let httpClient: HTTPClient
    private var searchSubject = CurrentValueSubject<String,Never>("")
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    private func setupSearchPublisher() {
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { searchText in
                loadMovies(search: searchText)
            }
            .store(in: &cancellables)
    }
    
    private func loadMovies(search: String) {
        httpClient.fetchMovies(search: search)
            .sink { _ in
                
            } receiveValue: { movies in
                self.movies = movies
            }
            .store(in: &cancellables)

    }
    
    var body: some View {
        NavigationStack {
            List(movies) { movie in
                MovieRow(movie: movie)
            }
            .listStyle(.plain)
            .searchable(text: $search)
            .onChange(of: search, {
                searchSubject.send(search)
            })
            .navigationTitle("Movies")
            .onAppear {
                setupSearchPublisher()
            }
        }
    }
}

#Preview {
    ContentView(httpClient: HTTPClient())
}

struct MovieRow: View {
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            AsyncImage(url: movie.poster) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 150)
                    .clipped()
                
            } placeholder: {
                PlaceHolder()
            }
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.title2)
                Text(movie.year)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview("Movie Row") {
    MovieRow(movie: Movie(title: "Superman/Batman: Public Enemies", year: "2009", imdbId: "tt1398941", poster: URL(string: "https://m.media-amazon.com/images/M/MV5BZDc5NTFiMzgtZWJiOS00N2M1LWJmOGYtZmNjMzFhMzcxZjRiXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg")))
}


struct PlaceHolder: View {
    var body: some View {
        VStack {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 150)
        }
    }
}

#Preview("Placeholder") {
    PlaceHolder()
}
