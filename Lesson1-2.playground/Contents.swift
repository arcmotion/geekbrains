import UIKit

/*-----------Lesson 1-------------*/
//1. Решить квадратное уравнение.

// let a:Float = Float(readLine()!)!
// let b:Float = Float(readLine()!)!
// let c:Float = Float(readLine()!)!
 let a:Float = 6
 let b:Float = 5
 let c:Float = 3

 let d:Float = pow(b, 2) - 4 * a * c

 if d > 0 {
    let x1 = (-b + sqrt(d)) / (2 * a)
    let x2 = (-b - sqrt(d)) / (2 * a)
    print(x1,x2)
 } else if d == 0 {
    let x1 = (-b + sqrt(d)) / (2 * a)
    print(x1)
 }
 else{
    print("no roots")
 }

 
//2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
 
// let sideA: Float = Float(readLine()!)!
// let sideB: Float = Float(readLine()!)!
 let sideA: Float = 12.6
 let sideB: Float = 7
 let hypo: Float = sqrt(pow(sideA, 2) + pow(sideB, 2))
 let s: Float = sideA * sideB / 2
 let p: Float = sideA + sideB + hypo

 print(hypo, s, p)


//3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.

// var deposit: Float = Float(readLine()!)!
 var deposit: Float = 35000
 let percent: Float = 15 / 100
 let years: Float = 5
 
 let sum: Float = deposit + deposit * percent * years
 print("1) \(sum)")
 
 for _ in 1...Int(years) {
    deposit += deposit * percent
 }
 
 print("2) \(deposit)")



/*-----------Lesson 2-------------*/

//1. Написать функцию, которая определяет, четное число или нет.
func isEven(number: Int) -> Bool{
    return number % 2 == 0
}
print(isEven(number: 2))


//2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func isDevidedByThree(number: Int) -> Bool{
    return number % 3 == 0
}

print(isDevidedByThree(number: 4))

//3. Создать возрастающий массив из 100 чисел.
var myArray = [Int]()
for num in 1...100 {
    myArray.append(num)
}
print(myArray)

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

let newArray = myArray.filter { value in
    return !isDevidedByThree(number: value) && !isEven(number: value)
}
print("Cleaned up array: \(newArray)")

//5. Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.

func createFibonacciArray (count: Int) -> [Int] {
    var array = [0, 1]

    guard count > 2 else {
        return array.dropLast(2 - count)
    }
    for index in 0...count - 2{
        let newValue = array[index] + array[index + 1]
        array.append(newValue)
    }
    return array
}

var fibArr = createFibonacciArray(count: 15)
print(fibArr)

//6. Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:

func getPrimeNumbersArray(stride: Int){
    var array = Array(2...100)
    var step = stride;

    while true {
        array.removeAll(where: { $0 % step == 0 && $0 != step})
        guard let next = array.firstIndex(where: {$0 > step}) else {
            print(array)
            return
        }

        step = array[next]
    }
}

getPrimeNumbersArray(stride: 2)
