
import Foundation

class Test{
    
    private var board:[Int] = []
    
    
    func populateBoard(){
        for _ in 0...9{
            board.append(0)
        }
    }
    
    func testBoard() -> Bool {
        if( board[0] == 0 && board[1] == 0 && board[2] == 0 && board[4]==0){
            return true
        }
        return false
    }
    
    func getBoard() -> [Int]{
        
        var boardArray:[Int] = []
        for pos in 0...board.count-1{
            if board[pos] == 0{
                boardArray.append(0)

            }
        }
        
        return boardArray;
        
    }
    
}

var testObj = Test()
testObj.populateBoard()

let startTime = CFAbsoluteTimeGetCurrent()
for _ in 0...1000{
    testObj.getBoard()
}

let endTime = CFAbsoluteTimeGetCurrent() - startTime

print(endTime)

