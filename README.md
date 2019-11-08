# ipsumnizer
source code anonymizer for training purposes

# function

copy ABAP code of an object ( report or class) to an anonymized object.
All methods, routines, constants, parameters, variables will be replaced by a word of some common text (lorem ipsum, Constitution of the United States, bible, movie transcript, ...).

# purpose

training for refactoring and pair programming. 
* analyze code
  * what does the code do?
  * how clean is it?
  * are there some weird programming techniques?
* refactor
  * give readable names
  * modularize 
  * split functionality
* add test classes
  * define unit tests to understand what the code produces
  * write unit tests to make sure it behaves like before
  
# features

* define word list
* import word list
* define objects to be scrambled
 * methods
 * sub routines
 * variables
 * literals
 * constants
* define key words that should not be replaced
 * READ
 * GET
 * CHECK
 * INIT
 * SAVE
* define minimum word length
* eliminate comments
* eliminate descriptions
