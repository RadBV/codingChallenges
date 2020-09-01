import UIKit

/*--- Day 1: Not Quite Lisp ---
 Part 1: Santa is trying to deliver presents in a large apartment building, but he can't find the right floor - the directions he got are a little confusing. He starts on the ground floor (floor 0) and then follows the instructions one character at a time.

 An opening parenthesis, (, means he should go up one floor, and a closing parenthesis, ), means he should go down one floor.

 The apartment building is very tall, and the basement is very deep; he will never find the top or bottom floors.

 For example:

 (()) and ()() both result in floor 0.
 ((( and (()(()( both result in floor 3.
 ))((((( also results in floor 3.
 ()) and ))( both result in floor -1 (the first basement level).
 ))) and )())()) both result in floor -3.
 To what floor do the instructions take Santa?*/

/* Part 2: Now, given the same instructions, find the position of the first character that causes him to enter the basement (floor -1). The first character in the instructions has position 1, the second character has position 2, and so on.

 For example:

 ) causes him to enter the basement at character position 1.
 ()()) causes him to enter the basement at character position 5.
 What is the position of the character that causes Santa to first enter the basement?*/

// use a counter to track which floor santa is on.
// use for loop and conditional statements to either tick the counter up or down depending on whether the parens is opening or closing

func notQuiteLisp(input: String) -> String {
    var floorCounter = 0
    var charCounter = 0
    var hasEnteredBasement = false

    for paren in input {
        if paren == "(" {
            floorCounter += 1
        } else if paren == ")" {
            floorCounter -= 1
            if floorCounter == -1 {
                hasEnteredBasement = true
            }
        }
        if !hasEnteredBasement {
            charCounter += 1
        }
    }


    return "Santa is on floor \(floorCounter)." + " \(hasEnteredBasement ? "Santa has entered the basement at position \(charCounter)" : "Santa did not enter the basement.")"
}

print(notQuiteLisp(input: "(())"))
print(notQuiteLisp(input: "(()(()("))
print(notQuiteLisp(input: "))("))
print(notQuiteLisp(input: ")())())"))
print(notQuiteLisp(input: "))((((("))

/*--- Day 2: I Was Told There Would Be No Math ---
 The elves are running low on wrapping paper, and so they need to submit an order for more. They have a list of the dimensions (length l, width w, and height h) of each present, and only want to order exactly as much as they need.

 Fortunately, every present is a box (a perfect right rectangular prism), which makes calculating the required wrapping paper for each gift a little easier: find the surface area of the box, which is 2*l*w + 2*w*h + 2*h*l. The elves also need a little extra paper for each present: the area of the smallest side.

 For example:

 A present with dimensions 2x3x4 requires 2*6 + 2*12 + 2*8 = 52 square feet of wrapping paper plus 6 square feet of slack, for a total of 58 square feet.
 A present with dimensions 1x1x10 requires 2*1 + 2*10 + 2*10 = 42 square feet of wrapping paper plus 1 square foot of slack, for a total of 43 square feet.
 All numbers in the elves' list are in feet. How many total square feet of wrapping paper should they order?*/

/*The elves are also running low on ribbon. Ribbon is all the same width, so they only have to worry about the length they need to order, which they would again like to be exact.

 The ribbon required to wrap a present is the shortest distance around its sides, or the smallest perimeter of any one face. Each present also requires a bow made out of ribbon as well; the feet of ribbon required for the perfect bow is equal to the cubic feet of volume of the present. Don't ask how they tie the bow, though; they'll never tell.

 For example:

 A present with dimensions 2x3x4 requires 2+2+3+3 = 10 feet of ribbon to wrap the present plus 2*3*4 = 24 feet of ribbon for the bow, for a total of 34 feet.
 A present with dimensions 1x1x10 requires 1+1+1+1 = 4 feet of ribbon to wrap the present plus 1*1*10 = 10 feet of ribbon for the bow, for a total of 14 feet.
 How many total feet of ribbon should they order?*/

// seperate the numbers into integers and store them in individual properties.
// store all combinations of multiples from the 3 seperate numbers into an array
//sort the array from smallest to largest and assign the first element to a variable
// create a new array to store all the numbers of the previous array multiplied by two
// reduce the array into answer variable with the sum of all the elements
// add the smallest area variable to the answer variable

//make an array of the length, width and height and sort it from smallest to largest
//add the first two numbers together twice, put in variable 1
//multiply all the numbers in the array, put in variable 2
//add the 2 variables and return it

func IWasToldThereWouldBeNoMath(dimensions: String) -> [Int] {
    let dimensionsArray = dimensions.split(separator: "x")
    guard let length = Int(String(dimensionsArray[0])) else {return [0]}
    guard let width = Int(String(dimensionsArray[1])) else {return [0]}
    guard let height = Int(String(dimensionsArray[2])) else {return [0]}

    let intDimensionsArray = [length,width,height].sorted()
    let ribbonLength = (intDimensionsArray[0] + intDimensionsArray[0] + intDimensionsArray[1] + intDimensionsArray[1])
    let bowLength = length * width * height

    let areaArray = [(length*width),(width*height),(height*length)]
    let smallestArea = areaArray.sorted()[0]

    let answer = areaArray.map {2 * $0}.reduce(0, +) + smallestArea

    return [answer,(bowLength + ribbonLength)]
}

func totalWrappingPaper(list: String) -> String {
    let arrayOfDimensions = list.components(separatedBy: CharacterSet.newlines)
    var totalWrappingPaper = 0
    var totalRibbon = 0

    for dimension in arrayOfDimensions {
        totalWrappingPaper += IWasToldThereWouldBeNoMath(dimensions: dimension)[0]
        totalRibbon += IWasToldThereWouldBeNoMath(dimensions: dimension)[1]
    }

    return "The elves need \(totalWrappingPaper) feet of wrapping paper and \(totalRibbon) feet of ribbon."
}

let input = """
2x3x4
1x1x10
29x13x26
11x11x14
27x2x5
6x10x13
15x19x10
26x29x15
8x23x6
17x8x26
20x28x3
23x12x24
11x17x3
19x23x28
25x2x25
1x15x3
"""

print(totalWrappingPaper(list: input))


/*--- Day 3: Perfectly Spherical Houses in a Vacuum ---
Santa is delivering presents to an infinite two-dimensional grid of houses.

He begins by delivering a present to the house at his starting location, and then an elf at the North Pole calls him via radio and tells him where to move next. Moves are always exactly one house to the north (^), south (v), east (>), or west (<). After each move, he delivers another present to the house at his new location.

However, the elf back at the north pole has had a little too much eggnog, and so his directions are a little off, and Santa ends up visiting some houses more than once. How many houses receive at least one present?

For example:

> delivers presents to 2 houses: one at the starting location, and one to the east.
^>v< delivers presents to 4 houses in a square, including twice to the house at his starting/ending location.
^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.*/

/*The next year, to speed up the process, Santa creates a robot version of himself, Robo-Santa, to deliver presents with him.

Santa and Robo-Santa start at the same location (delivering two presents to the same starting house), then take turns moving based on instructions from the elf, who is eggnoggedly reading from the same script as the previous year.

This year, how many houses receive at least one present?

For example:

^v delivers presents to 3 houses, because Santa goes north, and then Robo-Santa goes south.
^>v< now delivers presents to 3 houses, and Santa and Robo-Santa end up back where they started.
^v^v^v^v^v now delivers presents to 11 houses, with Santa going one direction and Robo-Santa going the other. */

// use a tuple counter to keep track of the x and y positions of santa on this imaginary house grid
//use a dictionary to store the tuple position and how many presents were given OR create an array of tuple positions and convert to a set to get rid of all duplicates, then back into an array


func howManyHouses(input: String) -> Int {
    var santaPosition = (0,0)
    var roboSantaPosition = (0,0)
    var isRealSantasTurn = true
    var positionSet: Set<String> = ["(0, 0)"]
    
    for direction in input {
        
        if direction == "<" {
            
            if isRealSantasTurn {
                santaPosition.0 -= 1
            } else {
                roboSantaPosition.0 -= 1
            }
            
        } else if direction == ">" {
            
            if isRealSantasTurn {
                santaPosition.0 += 1
            } else {
                roboSantaPosition.0 += 1
            }
            
        } else if direction == "^" {
            
            if isRealSantasTurn {
                santaPosition.1 += 1
            } else {
                roboSantaPosition.1 += 1
            }
            
        } else if direction == "v" {
            
            if isRealSantasTurn {
                santaPosition.1 -= 1
            } else {
                roboSantaPosition.1 -= 1
            }
            
        }
        
        let tuplePosition = "(\(isRealSantasTurn ? santaPosition.0: roboSantaPosition.0), \(isRealSantasTurn ? santaPosition.1: roboSantaPosition.1))"
        
        positionSet.insert(tuplePosition)
        
        isRealSantasTurn = !isRealSantasTurn
    }
    
    
    return positionSet.count
    
}

print(howManyHouses(input: ">"))
print(howManyHouses(input: "^>v<"))
print(howManyHouses(input: ">^^v^<>v<<<v<v^>>v"))



