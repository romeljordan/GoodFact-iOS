//
//  FavoriteFactStorageManager.swift
//  Good Fact
//
//  Created by androiddev on 12/17/24.
//

import Foundation
import Combine
import CoreData

class FavoriteFactStorageManager: NSObject, ObservableObject {
    static let shared = FavoriteFactStorageManager()
    
    var favorites = CurrentValueSubject<[Favorite], Never>([])
    private let fetchController: NSFetchedResultsController<Favorite>
    private let managedObjectContext: NSManagedObjectContext
    
    private override init() {
        let request = Favorite.fetchRequest()
        request.sortDescriptors = []
        
        fetchController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: PersistenceController.shared.container.viewContext,
            sectionNameKeyPath: nil, cacheName: nil
        )
        managedObjectContext = PersistenceController.shared.container.viewContext
        
        super.init()
        
        fetchController.delegate = self
        
        do {
            try fetchController.performFetch()
            favorites.value = fetchController.fetchedObjects ?? []
        } catch {
            NSLog("Error: could not fetch objects")
        }
    }
    
    func fetch() -> Array<Favorite> {
        do {
            let request = Favorite.fetchRequest()
            request.sortDescriptors = []
            let result = try managedObjectContext.fetch(request)
            return result
        } catch {
            return []
        }
    }
    
    func addFavorite(id: String, content: String, source: String) {
        let item = Favorite(context: managedObjectContext)
        item.id = id
        item.content = content
        item.source = source
        
        saveContext()
    }
    
    func delete(id: String) {
        guard let item = favorites.value.first(where: { $0.id == id }) else { return }
        managedObjectContext.delete(item)
        
        saveContext()
    }
    
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

extension FavoriteFactStorageManager: NSFetchedResultsControllerDelegate {
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        guard let items = controller.fetchedObjects as? [Favorite] else { return }
        self.favorites.value = items
    }
}
