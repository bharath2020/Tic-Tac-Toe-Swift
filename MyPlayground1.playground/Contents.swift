//: Playground - noun: a place where people can play

import Cocoa

var index = 100



func digits(var num : Int, totalDigits : Int ) -> [Int] {
    
    var start = 1
    let final = 10 * (totalDigits-1)
    
    var digits:[Int] = [Int]()
    
    var digitIndex : Int = 0
    while (start <= final ){
        
        let temp = num / start
        var digit = temp % 10
    
        digits[ digitIndex ] = digit
        
        digitIndex = digitIndex + 1
        
        start = start *  10
        
    }
    
    return digits
    
}

var digitsArray  = digits(299, 3)
println(digitsArray)
