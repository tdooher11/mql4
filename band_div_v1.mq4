
//+------------------------------------------------------------------+
//| Start function           
//To do:
//1.  Trend algorithm
//2.  Manual stop loss
//
//                                        |
//+------------------------------------------------------------------+

extern int Period1=20;
double BBLow,BBMid,BBHigh,BBHigh_div;
double BBLow_prev,BBMid_prev,BBHigh_prev,BBHigh_div_prev;
double prev_bid, prev_ask;
extern double StopLoss = 0.0010;
double TakeProfit = 0.3000;
int count = 0;
int trend=0;//0=netrual,1=up,2=down


int start()
{
       if(AccountBalance()<5000)
       {
         return(0);
       }
         
         BBLow=iBands(NULL,0,Period1,2,0,PRICE_CLOSE,MODE_LOWER,0);
         BBHigh=iBands(NULL,0,Period1,2,0,PRICE_CLOSE,MODE_UPPER,0);
         BBMid=iBands(NULL,0,Period1,2,0,PRICE_CLOSE,MODE_MAIN,0);
         
         BBHigh_div=iBands(NULL,0,Period1,1,0,PRICE_CLOSE,MODE_MAIN,0);
         BBHigh_div_prev=iBands(NULL,0,Period1,1,0,PRICE_CLOSE,MODE_MAIN,1);
         
         
         BBLow_prev=iBands(NULL,0,Period1,2,0,PRICE_CLOSE,MODE_LOWER,1);
         BBHigh_prev=iBands(NULL,0,Period1,2,0,PRICE_CLOSE,MODE_UPPER,1);
         BBMid_prev=iBands(NULL,0,Period1,2,0,PRICE_CLOSE,MODE_MAIN,1);
         
      if(OrdersTotal()<1)
      {  
            for(int i=0; i<20; i++)
            {
               if(iBands(NULL,0,Period1,2,0,PRICE_CLOSE,MODE_MAIN,i)>=iBands(NULL,0,Period1,2,0,PRICE_CLOSE,MODE_MAIN,i+1))
               {
                  trend=1;
               }
            else
            {
               trend=0;
               break;
            }
       }     
      
         //If the price was previously above the upper band and broke back down, sell short
         if(prev_bid>BBHigh_div_prev && Bid <= BBHigh_div && trend==1)
         {
            //OrderSend(Symbol(),OP_SELL,1,NormalizeDouble(Bid,5),2,Ask+StopLoss,Bid-TakeProfit);
            OrderSend(Symbol(),OP_BUY,1,NormalizeDouble(Ask,5),2,Bid-StopLoss,Bid+TakeProfit);
         }
         
      }
      
      if(OrdersTotal()>=1)
      {
           
           if(prev_ask<BBHigh_prev && Ask >= BBHigh)
           {
               for(count=0;count<OrdersTotal();count++)
               {     
                  RefreshRates();
                  OrderSelect(count, SELECT_BY_POS, MODE_TRADES);
                  OrderClose(OrderTicket(),1,Bid,3,Blue);              
                  trend=0;
                  return(0);
               }
           } 
      }
      
      prev_bid=Bid;
      prev_ask=Ask;
}

//+------------------------------------------------------------------+