
//+------------------------------------------------------------------+
//| Start function           
//To do:
//1.  Trend algorithm
//2.  Manual stop loss
//
//                                        |
//+------------------------------------------------------------------+

extern double TrailingStop = 0.0050;
extern int OpenOrders = 1;
extern double TakeProfit = 0.3000;
int count = 0;
int random=0;


int start()
{
       if(AccountBalance()<5000)
       {
         return(0);
       }
         
      if(OrdersTotal()<OpenOrders)
      {      
         random = 1 + 100*MathRand()/32768;
      
         if(random==50)
         {
            //OrderSend(Symbol(),OP_SELL,1,NormalizeDouble(Bid,5),2,Ask+StopLoss,Bid-TakeProfit);
            OrderSend(Symbol(),OP_BUY,1,NormalizeDouble(Ask,5),2,Bid-TrailingStop,Bid+TakeProfit);
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