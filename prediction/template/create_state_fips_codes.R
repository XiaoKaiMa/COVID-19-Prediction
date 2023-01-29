IHME_raw<-read.csv("../data-raw/IHME/2020_05_04/Hospitalization_all_locs.csv",stringsAsFactors = FALSE)

germany_fips_codes<-read.csv("base_germany.csv")
#state_code<-gsub("GM","",germany_fips_codes$V1)
state_name<-c(unique(grep("Baden",IHME_raw$location_name,value = TRUE)),
              unique(grep("Bav",IHME_raw$location_name,value = TRUE)),
              unique(grep("Breme",IHME_raw$location_name,value = TRUE)),
              unique(grep("Hamb",IHME_raw$location_name,value = TRUE)),
              unique(grep("Hesse",IHME_raw$location_name,value = TRUE)),
              unique(grep("Lower",IHME_raw$location_name,value = TRUE)),
              unique(grep("Westpha",IHME_raw$location_name,value = TRUE)),
              unique(grep("Palatinate",IHME_raw$location_name,value = TRUE)),
              unique(grep("Saarland",IHME_raw$location_name,value = TRUE)),
              unique(grep("Schleswig",IHME_raw$location_name,value = TRUE)),
              unique(grep("Branden",IHME_raw$location_name,value = TRUE)),
              unique(grep("Mecklen",IHME_raw$location_name,value = TRUE)),
              unique(grep("Saxony",IHME_raw$location_name,value = TRUE))[2],
              unique(grep("Saxony-Anhalt",IHME_raw$location_name,value = TRUE)),
              unique(grep("Thu",IHME_raw$location_name,value = TRUE)),
              unique(grep("Berlin",IHME_raw$location_name,value = TRUE)))

export_states<-data.frame(state_code=germany_fips_codes$V1,state_name=state_name)
export_germany<-rbind(export_states,c("GM","Germany"))
write.csv(export_germany,"state_codes_germany.csv",row.names = FALSE)


#get files where Germany was predicted
reported_countries<-list()
germany_reported<-rep(NA,length(filepaths))
for(i in 1:length(filepaths))
{
  reported_countries[[i]]<-readRDS(filepaths[i])$Country
  germany_reported[i]<-as.logical(sum(reported_countries[[i]]=="Germany"))
  
}



