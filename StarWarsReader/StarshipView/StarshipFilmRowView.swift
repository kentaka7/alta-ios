//
//  StarshipFilmRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct StarshipFilmRowViewModel {

  let film: Starship.Film

  var title: String {
    film.title
  }

  var filmViewModel: FilmViewModel {
    FilmViewModel(filmId: film.filmId)
  }
}

struct StarshipFilmRowView: View {

  let viewModel: StarshipFilmRowViewModel

  var body: some View {
    NavigationLink(destination: FilmView(viewModel: viewModel.filmViewModel, navigationTag: nil)) {
      Text(viewModel.title)
    }
  }
}

// swiftlint:disable all
struct StarshipFilmRowView_Previews: PreviewProvider {
  static let vm: StarshipFilmRowViewModel = {
    let falcon = loadSampleStarship("falcon")
    return StarshipFilmRowViewModel(film: falcon.films.first!)
  }()

  static var previews: some View {
    StarshipFilmRowView(viewModel: vm)
  }
}
