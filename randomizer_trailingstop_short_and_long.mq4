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
      
         if(random==25)
         {
            OrderSend(Symbol(),OP_BUY,1,NormalizeDouble(Ask,5),2,Bid-TrailingStop,Ask+TakeProfit);
         }
         if(random==75)
         {
            OrderSend(Symbol(),OP_SELL,1,NormalizeDouble(Bid,5),2,Ask+TrailingStop,Bid-TakeProfit);
         }        
      }  

         for(int cnt=0;cnt<OrdersTotal();cnt++)
         {
            OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
      
            if(Bid-OrderOpenPrice()>TrailingStop&&OrderType()==OP_BUY)
            {
               if(OrderStopLoss()<Bid-TrailingStop)
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Bid-TrailingStop,OrderTakeProfit(),0,Blue);
                  return(0);
               }
            }
            if((OrderOpenPrice()-Ask)>(TrailingStop)&&OrderType()==OP_SELL)
            {
               if(OrderStopLoss()>(Ask+TrailingStop))
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Ask+TrailingStop,OrderTakeProfit(),0,Red);
                  return(0);
               }
            }
         }   
}

//+------------------------------------------------------------------+