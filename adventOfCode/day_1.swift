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
