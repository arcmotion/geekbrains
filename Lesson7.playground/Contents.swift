import UIKit

struct Book {
    let name: String
    let author: String

}

struct StoreItem {
    let price: Double
    var count: Int
    var item: Book
}

enum BookStoreError:Error {
    case outOfStock
    case bookNotFound
    case balanceExceed
}

class BookStore {
    var books = [
        "The Da Vinci Code": StoreItem(price: 6.8, count: 3, item: Book(name: "The Da Vinci Code", author: "Dan Brown")),
        "The Catcher in the Rye": StoreItem(price: 4.1, count: 0, item: Book(name: "The Catcher in the Rye", author: "J. D. Salinger")),
        "Black Beauty": StoreItem(price: 7, count: 4, item: Book(name: "Black Beauty", author: "Anna Sewell")),
    ]
    
    var userBalance: Double
    
    init(balance: Double){
        self.userBalance = balance
    }
    
    func buyBook(name: String) -> (Book?, BookStoreError?){
        guard let book = books[name] else {
            return (nil, BookStoreError.bookNotFound)
        }
        guard book.count > 0 else {
            return (nil, BookStoreError.outOfStock)
        }
        guard book.price <= userBalance else {
            return (nil, BookStoreError.balanceExceed)
        }
        
        userBalance -= book.price
        var bookInstance = book
        bookInstance.count -= 1
        books[name] = bookInstance
        
        print("""
        Book \(bookInstance.item.author) - \(bookInstance.item.name) sold for a price of \(bookInstance.price)
        User Balance: \(userBalance)
        """)
        return (bookInstance.item, nil)
    }
}

let store = BookStore(balance: 12.5)
let purchase = store.buyBook(name: "Black Beauty")
let purchase2 = store.buyBook(name: "Black Beauty")
let purchase3 = store.buyBook(name: "The Catcher in the Rye")

if let book = purchase2.0 {
    print("You've bought a book: \(book.name)")
} else if let error = purchase2.1 {
    print("Произошла ошибка: \(error)")
}

if let book = purchase3.0 {
    print("You've bought a book: \(book.name)")
} else if let error = purchase3.1 {
    print("Произошла ошибка: \(error)")
}


/*--------------- Throwing Errors----------------*/


class NewBookStore: BookStore{
    
    /*
    почему-то не удалось перебить метод родителя через override, выдает ошибку method does not override from its superclass
     */
    
    func buyBookNew(name: String) throws -> Book {
        guard let book = books[name] else {
            throw BookStoreError.bookNotFound
        }
        guard book.count > 0 else {
            throw BookStoreError.outOfStock
        }
        guard book.price <= userBalance else {
            throw BookStoreError.balanceExceed
        }
        
        userBalance -= book.price
        var bookInstance = book
        bookInstance.count -= 1
        books[name] = bookInstance
        
        
        print("""
        Book \(bookInstance.item.author) - \(bookInstance.item.name) sold for a price of \(bookInstance.price)
        User Balance: \(userBalance)
        """)
        return bookInstance.item

    }
}
let newStore = NewBookStore(balance: 6)

do{
//    let newPurchase = try newStore.buyBookNew(name: "The Catcher in the Rye")
//    let newPurchase = try newStore.buyBookNew(name: "The Catcher")
    let newPurchase = try newStore.buyBookNew(name: "Black Beauty")
    
    print("\(newPurchase.name) bought")

}catch BookStoreError.balanceExceed {
    print("Not enough money")
}catch BookStoreError.bookNotFound {
    print("No matching book in th store")
}catch BookStoreError.outOfStock {
    print("This book is out of stock")
}catch let error {
    print(error)
}
