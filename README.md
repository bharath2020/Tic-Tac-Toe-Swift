# Tic-Tac-Toe-Swift
Tic-Tac-Toe with minimax algorithm in Swift. I ported this from Objective-C version of this project to learn nuances or changes that are needed in Swift programming for a person coming from extensive Objective-C background.

Below are summary of the changes I experienced while implementing this project

#1 You don’t have to subclass all your classes from NSObject
#2 Immutability is let, Mutability is var. Always start with ‘let'
#3 Yet another block syntax 
#4 Use === to compare two object pointers
#5 You no longer need NSDictionary to send more than one value. Swift introduces Tuples to return multiple values
#6 Initialize all your variables in the class before calling super init.

For more details, Please check my blog post here http://bharath2020.in/2015/09/19/porting-to-swift-from-objective-c/

