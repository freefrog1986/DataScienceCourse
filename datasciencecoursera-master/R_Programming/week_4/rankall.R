rankall <- function(outcome, num = "best") {
        ## Read outcome data
        outcome_file <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        states = unique(outcome_file$State)
        ## Check that outcome are valid
        switch (outcome, "heart attack"  = { col = 11 },
                "heart failure" = { col = 17 },
                "pneumonia"     = { col = 23 },
                stop("invalid outcome"))
        
        outcome_subset = outcome_file[ , c(2, 7, col)]
        names(outcome_subset) = c("Hospital.Name", "State", "Outcome")
                # Don't show warning:
        outcome_subset$Outcome = suppressWarnings(as.numeric(outcome_subset$Outcome)) 
                # Remove NAs:
        outcome_subset = na.omit(outcome_subset)
        ## For each state, find the hospital of the given rank
        rank_in_state <- function(state){
                df = outcome_subset[outcome_subset[, 2] == state, ]
                nhosp = nrow(df)
                # Convert "best" and "worst into numbers
                switch(num, best = {
                        num = 1
                }, worst = {
                        num = nhosp
                })
                if (num > nhosp) {
                        hosp = NA
                }
                
                o = order(df[, "Outcome"], df[, "Hospital.Name"])
                hosp = df[o, ][num, "Hospital.Name"]
                return(c(hosp, state))
        }
        ## Return a data frame with the hospital names and the 
        ## (abbreviated) state name
        
        output = do.call(rbind, lapply(states, rank_in_state))
        output = output[order(output[, 2]), ]
        rownames(output) = output[, 2]
        colnames(output) = c("hospital", "state")
        data.frame(output)
}