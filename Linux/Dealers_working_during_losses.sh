#!/bin/bash

#Dealers working during times that losses were detected
#Reference time from Player analysis at the time of losses
#0310_win_loss_player_data:05:00:00 AM  -$82,348        Amirah Schneider,Nola Portillo, Mylie Sc$
#0310_win_loss_player_data:08:00:00 AM  -$97,383        Chanelle Tapia, Shelley Dodson , Valenti$
#0310_win_loss_player_data:02:00:00 PM  -$82,348        Jaden Clarkson, Kaidan Sheridan, Mylie S$
#0310_win_loss_player_data:08:00:00 PM  -$65,348        Mylie Schmidt, Trixie Velasquez, Jerome $
#0310_win_loss_player_data:11:00:00 PM  -$88,383        Mcfadden Wasim, Norman Cooper, Mylie Sch$
#0312_win_loss_player_data:05:00:00 AM  -$182,300       Montana Kirk, Alysia Goodman, Halima Lit$
#0312_win_loss_player_data:08:00:00 AM  -$97,383        Rimsha Gardiner,Fern Cleveland, Mylie Sc$
#0312_win_loss_player_data:02:00:00 PM  -$82,348        Mae Hail,  Mylie Schmidt,Ayden Beil     
#0312_win_loss_player_data:08:00:00 PM  -$65,792        Tallulah Rawlings,Josie Dawe, Mylie Schm$
#0312_win_loss_player_data:11:00:00 PM  -$88,229        Vlad Hatfield,Kerys Frazier,Mya Butler, $
#0315_win_loss_player_data:05:00:00 AM  -$82,844        Arjan Guzman,Sommer Mann, Mylie Schmidt 
#0315_win_loss_player_data:08:00:00 AM  -$97,001        Lilianna Devlin,Brendan Lester, Mylie Sc$
#0315_win_loss_player_data:02:00:00 PM  -$182,419        Mylie Schmidt, Corey Huffman

cat 0310_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' | grep '05:00:00 AM' >> Dealers_working_during_losses
cat 0310_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' | grep '08:00:00 AM' >> Dealers_working_during_losses
cat 0310_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' | grep '02:00:00 PM' >> Dealers_working_during_losses
cat 0310_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' | grep '08:00:00 PM' >> Dealers_working_during_losses
cat 0310_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' | grep '11:00:00 PM' >> Dealers_working_during_losses
cat 0312_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' | grep '05:00:00 AM' >> Dealers_working_during_losses
cat 0312_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' | grep '08:00:00 AM' >> Dealers_working_during_losses
cat 0312_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' | grep '02:00:00 PM' >> Dealers_working_during_losses
cat 0312_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' | grep '08:00:00 PM' >> Dealers_working_during_losses
cat 0312_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' | grep '11:00:00 PM' >> Dealers_working_during_losses
cat 0315_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' | grep '05:00:00 AM' >> Dealers_working_during_losses
cat 0315_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' | grep '08:00:00 AM' >> Dealers_working_during_losses
cat 0315_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}' | grep '02:00:00 PM' >> Dealers_working_during_losses

grep 'Billy Jones' Dealers_working_during_losses | wc -l >> Dealers_working_during_losses


