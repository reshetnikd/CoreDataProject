//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Dmitry Reshetnik on 24.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI
import CoreData

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    @State private var lastNameFilter = "A"
//    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")/*NSPredicate(format: "universe IN %@",["Aliens", "Firefly", "Star Trek"])*/) var ships: FetchedResults<Ship>
//    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
//    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
    
    var body: some View {
//        VStack {
//            List {
//                ForEach(countries, id: \.self) { country in
//                    Section(header: Text(country.wrappedFullName)) {
//                        ForEach(country.candyArray, id: \.self) { candy in
//                            Text(candy.wrappedName)
//                        }
//                    }
//                }
//            }
//
//            Button("Add") {
//                let candy1 = Candy(context: self.moc)
//                candy1.name = "Mars"
//                candy1.origin = Country(context: self.moc)
//                candy1.origin?.shortName = "UK"
//                candy1.origin?.fullName = "United Kingdom"
//
//                let candy2 = Candy(context: self.moc)
//                candy2.name = "KitKat"
//                candy2.origin = Country(context: self.moc)
//                candy2.origin?.shortName = "UK"
//                candy2.origin?.fullName = "United Kingdom"
//
//                let candy3 = Candy(context: self.moc)
//                candy3.name = "Twix"
//                candy3.origin = Country(context: self.moc)
//                candy3.origin?.shortName = "UK"
//                candy3.origin?.fullName = "United Kindom"
//
//                let candy4 = Candy(context: self.moc)
//                candy4.name = "Toblerone"
//                candy4.origin = Country(context: self.moc)
//                candy4.origin?.shortName = "CH"
//                candy4.origin?.fullName = "Switzerland"
//
//                try? self.moc.save()
//            }
//        }
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter, sortDescriptors: [NSSortDescriptor(key: "firstName", ascending: false)], appliedPredicate: .contains) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? self.moc.save()
            }

            Button("Show A") {
                self.lastNameFilter = "A"
            }

            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
//        VStack {
//            List(ships, id: \.self) { ship in
//                Text(ship.name ?? "Unknown name")
//            }
//
//            Button("Add Examples") {
//                let ship1 = Ship(context: self.moc)
//                ship1.name = "Enterprise"
//                ship1.universe = "Star Trek"
//
//                let ship2 = Ship(context: self.moc)
//                ship2.name = "Defiant"
//                ship2.universe = "Star Trek"
//
//                let ship3 = Ship(context: self.moc)
//                ship3.name = "Millennium Falcon"
//                ship3.universe = "Star Wars"
//
//                let ship4 = Ship(context: self.moc)
//                ship4.name = "Executor"
//                ship4.universe = "Star Wars"
//
//                try? self.moc.save()
//            }
//        }
//        VStack {
//            List(wizards, id: \.self) { wizard in
//                Text(wizard.name ?? "Unknown")
//            }
//
//            Button("Add") {
//                let wizard = Wizard(context: self.moc)
//                wizard.name = "Harry Potter"
//            }
//
//            Button("Save") {
//                do {
//                    try self.moc.save()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        List(students, id: \.self) { student in
//            if self.moc.hasChanges {
//                //try? self.moc.save()
//            }
//            Text(student.name)
//        }
    }
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    enum Predicate: String {
        case beginsWith = "BEGINSWITH"
        case contains = "CONTAINS"
    }
    
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }
    
    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }
    
    init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor], appliedPredicate: Predicate, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(appliedPredicate) %@", filterKey, filterValue))
        self.content = content
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
