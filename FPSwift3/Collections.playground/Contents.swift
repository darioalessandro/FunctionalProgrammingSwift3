//: Playground - noun: a place where people can play

import UIKit

let c = [1,2,3].filter {s in s >= 2}
print(c)


let appleFilter = [123:"first",124 : "lasto"].filter {(key,value) in value == "lasto"}
print(appleFilter)


let customFilter = [123:"first",124 : "lasto"].filterCopy {(key,value) in value == "lasto"}
print(customFilter)

let addAll = [1,2,3,4].reduce(0) { (acc, next)  in
    return acc + next
}

let concatWithComma = ["Str1", "Str2", "Str3"].reduce("") { (acc, next)  in
    return acc + "," + next
}


