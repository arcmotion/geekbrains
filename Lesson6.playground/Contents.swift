import UIKit

protocol Experienced {
    var experience: Int { get set }
    var major: String { get set }
}

struct University<T: Experienced>{

    private(set) var elements = [T]()
    
    mutating func add(_ element: T){
        self.elements.append(element)
    }
    mutating func substract() -> T{
        return elements.removeLast()
    }
    subscript(index: Int) -> String {
        return "Teacher's info: \(elements[index].major), Experience: \(elements[index].experience) years"
        
    }
    func filter(_ predicate: (T) -> Bool) -> University<T> {
        var filteredList: [T] = []
        for i in elements {
            if(predicate(i)){
                filteredList.append(i)
            }
        }
        var filteredQueue = University()
        filteredQueue.elements = filteredList
        return filteredQueue
        
    }
    func map<U>(_ predicate: (T) -> U) -> University<U> {
        var updatedList: [U] = []
        for i in elements {
            updatedList.append(predicate(i))
        }
        var updatedQueue = University<U>()
        updatedQueue.elements = updatedList
        return updatedQueue
    }
}



class Teacher: Experienced, CustomStringConvertible {
    var major: String
    var experience: Int
    
    var description: String {
        return "Teacher: \(experience), major: \(major)"
    }
    
    init(major: String, experience: Int){
        self.major = major
        self.experience = experience
    }
}

var queue = University<Teacher>()

queue.add(Teacher(major: "Science", experience: 16))
queue.add(Teacher(major: "Psychology", experience: 5))
queue.add(Teacher(major: "Geography", experience: 4))
queue.add(Teacher(major: "Math", experience: 25))


print(queue.elements)
let filtered = queue.filter{$0.experience > 10}
print(filtered.elements)


queue.map { teacher -> Teacher in
    print("teacher major: \(teacher.major)")
    return teacher
}

print(queue[0])
