//: Playground - noun: a place where people can play

import UIKit

do {
     try [1, 2, 3].filter {s in s >= 2}
     let a = try [1, 2, 3].map {n in n * 2}
    print(a)

    let b = try [1, 2, 3].map {$0 * 2}

    try [1,2,3].flatMap { (element)  in [element]}
} catch {
}



var result : [Int] = []
for element in [1,2,3] {
    result.append(element)
}

var result2 : [Int] = []
for element in [1,2,3] {
    if(element >= 2) {
        result2.append(element)
    }
}


let numbers = [1, 2, 3, 4]

let mapped = numbers.map { Array(repeating: $0, count: $0) }
print(mapped)

let flatMapped = numbers.flatMap { Array(repeating: $0, count: $0) }
print(flatMapped)

print(result)



let appleFilter = [123:"first",124 : "lasto"].filter {(key,value) in value == "lasto"}
print(appleFilter)


//let customFilter = [123:"first",124 : "lasto"].filterCopy {(key,value) in value == "lasto"}
//print(customFilter)

let addAll = [1,2,3,4].reduce(0) { (acc, next)  in
    acc + next
}

let concatWithComma : String = ["Str1", "Str2", "Str3"].reduce("") { (acc, next)  in
    acc + "," + next
}
