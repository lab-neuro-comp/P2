# Studies' module

Let's process many files at once using Protolize!! To achieve that, we will use
this studies' system. A _study_ is a list of actions. Each action will transform 
your dataset, and the final result is what the 

Actions file
------------

The possible actions are found in the `studies/actions.yml` file. Each action is
identified in the map with a string and contains a list. The list is organized as follows:

+ The first item is a description of what this action does.
+ The second item is the function that must be called.
+ The third item is the number of parameters this function needs.