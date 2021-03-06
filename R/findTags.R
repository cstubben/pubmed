## need locus tags from GFF file  values(bpgff)$locus
##  avoid V. cholerae strain tags... VC274080_0898   or VC0395_A2856?
## tag <- paste(prefix, "[0-9]{4}[^0-9_]", sep="")  
# or Helicobacter strain j99 tags -- HP not JHP_   
# txt should be list returned by pmcText or table

findTags <-function(txt, tags, prefix, suffix, notStartingWith, expand=TRUE, digits=4, ...){

   id <- attr(txt, "id")

   if(is.null(id)){
       if(is.list(txt)) id <- attr(txt[[1]], "id")   # list of tables
       if(is.null(id)){
          message("Warning: No id attribute found")
          id <- NA
       }
    }

     ## one or more digits
   tag <- paste(prefix, "[0-9]+", sep="")
 
   y <-  searchPMC(txt, tag, ...)
   if(!is.null(y)){
      message(paste(nrow(y), "matches"))
      y <- parseTags(y, tags, prefix, suffix, notStartingWith, expand, digits )
      ## may not extract any tags if using notStartingWith
      if(nrow(y) == 0){
         y <- NULL
      }else{
         ## add ID
         y <- data.frame(id, y, stringsAsFactors=FALSE)

      }
   }
   y  
}


#
