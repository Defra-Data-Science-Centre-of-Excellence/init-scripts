testing_workspaces <- function(
    my_postfix = "2409", my_mountpoint_name = "NI-Project"){
  
  tryCatch(
    {
      # Test 2.1
      path="/dbfs/mnt/base/unrestricted/source_defra_data_services_platform/dataset_ramsar"
      x = list.files(path=path) # This should pass
      print("Test 2.1 passed.")
    },
    error = function(e){print("Test 2.1 has failed.")},
    warning = function(w){  
      print("We got a warning from 2.1 this is odd!")
    }
  )
  
  tryCatch(
    {
      # Test 2.2
      path="/dbfs/mnt/base/unrestricted/"
      setwd(path)
      A=data.frame(a=1:3, b=5:7)
      write.csv(A, file= paste0("A_", my_postfix, ".csv"))
      print("Test 2.2 worked when it should not.")
    },
    error = function(e){print("Writing failed, so test 2.2 has passed.")},
    warning = function(w){  
      if(grepl(pattern = "Permission denied", x = w)){
        print("Permission denied, so test 2.2 has passed.")
      } else {
        print("We got some unexpected warning for 2.2, this is odd.") 
      }
    }
  )
  
  tryCatch(
    {
      # Test 2.3
      path="/dbfs/mnt/base/restricted/"
      setwd(path)
      B=data.frame(a=1:3, b=5:7) 
      write.csv(A, file= paste0("B_", my_postfix, ".csv")) # This should fail - good!
      print("Test 2.3 worked when it should not.")
    },
    error = function(e){print("Changing directory into base/restricted/ failed, so test 2.3 has passed.")},
    warning = function(w){  
      print("We got a warning from 2.3 this is odd!")
    }
  )
  
  tryCatch(
    { 
      # Test 2.4
      path="/dbfs/mnt/lab/unrestricted/share"
      setwd(path)
      C=data.frame(a=1:3, b=25:27) 
      write.csv(C, file= paste0("C_", my_postfix, ".csv")) # This should pass - good!
      print("Test 2.4 has passed.")
    },
    error = function(e){print("Test 2.4 has failed.")},
    warning = function(w){  
      print("We got a warning from 2.4 this is odd!")
    }
  )
  
  tryCatch(
    { 
      # Test 2.5
      path="/dbfs/mnt/lab/unrestricted/share"
      setwd(path) 
      myC=read.csv( file= paste0("C_", my_postfix, ".csv")) # This should passes 
      print("Test 2.5 has passed.")
    },
    error = function(e){print("Test 2.5 has failed.")},
    warning = function(w){  
      print("We got a warning from 2.5 this is odd!")
    }
  )
  
  tryCatch(
    { 
      # Test 2.6
      path=paste0("/dbfs/mnt/lab/restricted/", my_mountpoint_name , "/")
      setwd(path) 
      D=data.frame(a=31:33, b=25:27)
      write.csv(D, file=paste0("D_", my_postfix, ".csv"))
      print("Test 2.6 has passed.")
    },
    error = function(e){print("Test 2.6 has failed.")},
    warning = function(w){  
      print("We got a warning from 2.6 this is odd!")
    }
  ) 
  
  
  tryCatch(
    { 
      # Test 2.7
      path=paste0("/dbfs/mnt/lab/restricted/", my_mountpoint_name , "/")
      setwd(path) 
      myD=read.csv( file=  paste0("D_", my_postfix, ".csv")) # This should passes
      print("Test 2.7 has passed.")
    },
    error = function(e){print("Test 2.7 has failed.")},
    warning = function(w){  
      print("We got a warning from 2.7 this is odd!")
    }
  )
  
  
  tryCatch(
    { 
      # Test 2.8
      if (my_mountpoint_name != "sos_project"){
        path="/dbfs/mnt/lab/restricted/sos_project/"
      } else { 
        path="/dbfs/mnt/lab/restricted/NI-Project/"
      }
      setwd(path) 
      E=data.frame(a=51:53, b=25:27)
      write.csv(E, file=paste0("E_", my_postfix, ".csv"))  # This should fail 
      print("Test 2.8 worked when it should not.")
    },
    error = function(e){print( paste0("Changing directory into ", path, " failed, so test 2.8 has passed."))},
    warning = function(w){  
      print("We got a warning from 2.8 this is odd!")
    }
  )
  
  tryCatch(
    { 
      # Test 2.9
      # Test 2.8
      if (my_mountpoint_name != "sos_project"){
        path="/dbfs/mnt/lab/restricted/sos_project/"
      } else { 
        path="/dbfs/mnt/lab/restricted/NI-Project/"
      }
      myF=read.csv(file= paste0(path, "rpa_sos_dashb_siti/cars.csv"))  
      print("Test 2.9 worked when it should not.")
    },
    error = function(e){print(paste0("Reading from directory ", path, " failed, so test 2.9 has passed."))},
    warning = function(w){   
      if(grepl(pattern = "No such file or directory", x = w)){
        print("No such file or directory, so test 2.9 has passed.")
      } else {
        print("We got some unexpected warning for 2.9, this is odd.") 
      }
    }
  )
  
  tryCatch(
    { 
      # Test 2.12
      one_csv = read.csv(
        "https://gist.githubusercontent.com/pantelisindefra/b54c4fb86a8c275c63d9cf4b4a152d7f/raw/7021147653de359ec3fda3828cfdf0b36448ab6e/test_csv.csv")
      print("Test 2.12 has passed.")
    },
    error = function(e){print("Test 2.12 has failed.")},
    warning = function(w){  
      print("We got a warning from 2.12 this is odd!")
    }
  ) 
}
