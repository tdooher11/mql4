
//+------------------------------------------------------------------+
//| Start function           
//To do:
//1.  Trend algorithm
//2.  Manual stop loss
//
//                                        |
//+------------------------------------------------------------------+

double BBLow,BBMid,BBHigh,BBHigh_div;
double BBLow_prev,BBMid_prev,BBHigh_prev,BBHigh_div_prev;
double prev_bid, prev_ask;
double StopLoss = 0.0020;
double TakeProfit = 0.0300;
double TrailingStop = 0.0050;
int count = 0;
int trend=0;//0=netrual,1=up,2=down
int random=0;


int start()
{
       if(AccountBalance()<5000)
       {
         return(0);
       }
         
      if(OrdersTotal()<1)
      {      
         random = 1 + 100*MathRand()/32768;
      
         if(random==50)
         {
            //OrderSend(Symbol(),OP_SELL,1,NormalizeDouble(Bid,5),2,Ask+StopLoss,Bid-TakeProfit);
            OrderSend(Symbol(),OP_BUY,1,NormalizeDouble(Ask,5),2,Bid-StopLoss,Bid+TakeProfit);
         }
         
      }  
      else
      {
         for(int cnt=0;cnt<OrdersTotal();cnt++)
         {
            OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
      
            if(OrderStopLoss()<Bid-TrailingStop)
            {
                     OrderModify(OrderTicket(),OrderOpenPrice(),Bid-TrailingStop,OrderTakeProfit(),0,Blue);
                     //Alert("Trailing stop modified, new value:"+OrderStopLoss());
                     return(0);
            }
         }
      }    
}

//+------------------------------------------------------------------+