home_net <- c( "192.168.204.0/24"  )

read.bin.file <- function(filename  ) {
  
  zz <- file("test.bin" ,"rb" )
  while ( length(c <- readBin(zz,integer(),n=1,size = 1)) > 0) {
    print (  c )    
  }

  close(zz)
 # unlink("test.bin")
  return ( c )
  
  
  
}


add_local_remote_to_dataframe <- function( dataframe , ip1 , ip2    ) {
  require(iptools)
  dataframe$local_ip <- ifelse( ip_in_range( dataframe[,ip1] , home_net ) , dataframe[,ip1] , dataframe[,ip2]  )
  dataframe$remote_ip <- ifelse( ip_in_range( dataframe[,ip1] , home_net ) , dataframe[,ip2], dataframe[,ip1]  )
  return ( dataframe )
}

headers_of_bro_file <- function(  file_nm ) {
  field_names <-  scan(file_nm , skip=6 , nlines = 1 , sep="\t" , what="character")
  return (field_names[-1])
}

body_of_bro_file <-  function( file_nm ) {
  data <- read.table( file_nm , skip=8  , header=FALSE )
  return ( data )
}

