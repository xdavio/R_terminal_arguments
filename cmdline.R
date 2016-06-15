#This script allows passing arguments to R scripts which define both the variable name and assign the given value to it in the following way:
#R --vanilla <script.R N=5 M=4

cmd <- commandArgs() #dump shell arguments
cmd <- cmd[3:length(cmd)] #cut off original parameters

if (!is.na(cmd[1])) {
    foo <- function(x) {
        gregexpr(pattern="=",text=x)[[1]][1]
    }
    cmd.eq <- sapply(cmd,foo) #location of the equals in the cmd array

    assigner <- function(x) {
        a <- substring(cmd[x], 1, cmd.eq[x] - 1)
        b <- substring(cmd[x], cmd.eq[x] + 1, 1000)
        assign(x=a, value=as.numeric(b), envir=.GlobalEnv)
    }
    sapply(1:length(cmd),assigner)
}

#example. create a new R script, paste the code above, and then include
#print(N)
#Then call the script from the terminal
#R --vanilla <cmdline.R N=4
#and verify that 4 gets printed. Remove N=4 and verify that you get an error.
