//
//  PersonViewModel.swift
//  StarWarsReader
//
//  Created by Joe Bramhall on 1/13/20.
//  Copyright © 2020 thinx. All rights reserved.
//

import Foundation
import Combine

final class PersonViewModel: ObservableObject {

  private let personId: String

  private let dataService: Swapi

  private var disposables = Set<AnyCancellable>()

  @Published var person: Person?

  var films: [Person.Film] = []

  var species: [Person.Species] = []

  var starships: [Person.Starship] = []

  var vehicles: [Person.Vehicle] = []

  init(
    resourceId: String,
    dataService: Swapi = SwapiService()
  ) {
    personId = resourceId
    self.dataService = dataService
  }

  func loadPersonContent() {
    dataService.person(with: personId)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          print("There was an error \(error)")
          self.person = nil
        case .finished:
          break
        }
      }, receiveValue: { person in
        self.person = person
        self.films = person.films
        self.species = person.species
        self.starships = person.starships
        self.vehicles = person.vehicles
      })
    .store(in: &disposables)
  }

  var viewTitle: String {
    person?.name ?? ""
  }

  var name: String? {
    person?.name
  }

  var birthYear: String? {
    person?.birthYear
  }

  var gender: String? {
    person?.gender.rawValue.localizedCapitalized
  }

  var height: String {
    guard let heightValue = person?.height else {
      return "n/a"
    }
    let heightMeters = Float(heightValue) / 100
    return String(heightMeters)
  }

  var mass: String {
    String(person?.mass ?? 0)
  }

  var hair: String {
    guard let hairColors = person?.hairColor else {
      return "n/a"
    }
    return hairColors.map { $0.rawValue.localizedLowercase }.joined(separator: ", ")
  }

  var eyes: String {
    guard let eyeColors = person?.eyeColor else {
      return "n/a"
    }
    return eyeColors.map { $0.rawValue.localizedLowercase }.joined(separator: ", ")
  }

  var skin: String {
    guard let skinTones = person?.skinColor else {
      return "n/a"
    }
    return skinTones.map { $0.rawValue.localizedLowercase }.joined(separator: ", ")
  }

  var homeworldViewModel: HomeworldRowViewModel {
    HomeworldRowViewModel(homeworld: person?.homeworld)
  }

  func speciesViewModel(forSpecies species: Person.Species) -> SpeciesRowViewModel {
    SpeciesRowViewModel(species: species)
  }

  func starshipViewModel(forStarship starship: Person.Starship) -> StarshipRowViewModel {
    StarshipRowViewModel(starship: starship)
  }

  func vehicleViewModel(forVehicle vehicle: Person.Vehicle) -> VehicleRowViewModel {
    VehicleRowViewModel(vehicle: vehicle)
  }

  func filmViewModel(forFilm film: Person.Film) -> PersonFilmRowViewModel {
    PersonFilmRowViewModel(film: film)
  }
}