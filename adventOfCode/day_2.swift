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
