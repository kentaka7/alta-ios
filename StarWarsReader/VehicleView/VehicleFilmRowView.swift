//
//  VehicleFilmRowView.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/14/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import SwiftUI

struct VehicleFilmRowViewModel {

  let film: Vehicle.Film

  var title: String {
    film.title
  }

  var filmViewModel: FilmViewModel {
    FilmViewModel(filmId: film.filmId)
  }
}

struct VehicleFilmRowView: View {

  let viewModel: VehicleFilmRowViewModel

  var body: some View {
    NavigationLink(destination: FilmView(viewModel: viewModel.filmViewModel, navigationTag: nil)) {
      Text(viewModel.title)
    }
  }
}

// swiftlint:disable all
struct VehicleFilmRowView_Previews: PreviewProvider {
  static let vm: VehicleFilmRowViewModel = {
    let airspeeder = loadSampleVehicle("airspeeder")
    return VehicleFilmRowViewModel(film: airspeeder.films.first!)
  }()

  static var previews: some View {
    VehicleFilmRowView(viewModel: vm)
  }
}
