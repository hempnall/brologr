freegeoip <- function( ip , format = ifelse(length(ip)==1,'list','dataframe'))
{
  if (1 == length(ip))
  {
    # a single IP address
    require(rjson)
    url <- paste(c("http://192.168.99.100:8080/json/", ip ), collapse='')
    ret <- fromJSON(readLines(url, warn=FALSE))
    if (format == 'dataframe')
      ret <- data.frame(t(unlist(ret)))
    return(ret)
  } else {
    ret <- data.frame()
    for (i in 1:length(ip))
    {
      r <- freegeoip(ip[i], format="dataframe")
      ret <- rbind(ret, r)
    }
    return(ret)
  }
} 

as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}

add_geoip_to_dataframe <- function( data  ) {
  
    data <- transform(  data , tx_hosts=as.character(tx_hosts) , rx_hosts=as.character(rx_hosts) )
  
     data$long_tx <- as.numeric.factor( freegeoip( data$tx_hosts  )$longitude ) 
     data$latt_tx <- as.numeric.factor( freegeoip( data$tx_hosts  )$latitude )
     data$long_rx <- as.numeric.factor( freegeoip( data$rx_hosts  )$longitude )
     data$latt_rx <- as.numeric.factor( freegeoip( data$rx_hosts  )$latitude )
     
     
     
     return( data )
   }

add_geoip_to_dataframe_col <- function( data ,col_name ) {
  
  lat_field <- paste(  "lat_" , col_name  , sep="")
  long_field <- paste(  "long_" , col_name , sep=""  )
  
  data[,lat_field] <-     as.numeric.factor( freegeoip( data[, col_name  ]  )$latitude ) 
  data[ , long_field ] <- as.numeric.factor( freegeoip( data[, col_name ] )$longitude )

  return( data )
}




geo_plot <- function(  df ) {
  
}
