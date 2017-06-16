library(dplyr)
library(readr)

allVotes <- readr::read_csv("data/allVotes.csv")
allMK <- readr::read_csv("data/allMK.csv")
MKVotes <- readr::read_csv("data/MKVotes.csv")

allVotes <- allVotes %>% 
  dplyr::select(vote_id:session_id, vote_date, is_elctrnc_vote:total_abstain)

indVotes <-  MKVotes %>% 
  dplyr::select(vote_id, vip_id = kmmbr_id, vote_result:faction_id, reason:remark) %>% 
  dplyr::full_join(., allMK, by = "vip_id") %>% 
  dplyr::select(name = mk_individual_name_eng, 
                first_name =mk_individual_first_name_eng,
                vote_id:remark) %>% 
  dplyr::mutate(vip_id = as.numeric(vip_id)) %>% 
  dplyr::full_join(., allVotes, by = "vote_id")


  
  
  