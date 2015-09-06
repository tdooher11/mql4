extern double TrailingStop = 0.0050;
extern int OpenOrders = 20;
extern double Percentage = 0.5;
extern double TakeProfit = 0.9000;
extern double lotsize = 0.1;
int count = 0;
int random=0;
int seed=1000;
int init(){  MathSrand(TimeLocal());  return(0);}
int start()
{
      //
      //if(AccountBalance()<1000){return(0);}        
      if(OrdersTotal()<OpenOrders)
      {  
         random = 1 + seed*MathRand()/32768;
         if(random==25){
            OrderSend(Symbol(),OP_BUY,lotsize,NormalizeDouble(Ask,5),2,Bid-TrailingStop,Ask+TakeProfit);
         }
         if(random==75){
            OrderSend(Symbol(),OP_SELL,lotsize,NormalizeDouble(Bid,5),2,Ask+TrailingStop,Bid-TakeProfit);     
         }        
      }         
      for(int cnt=0;cnt<OrdersTotal();cnt++)
      {
         OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);     
         if(Bid-OrderOpenPrice()>TrailingStop&&OrderType()==OP_BUY)
         {
            if(OrderStopLoss()<Bid-(Bid-OrderOpenPrice())*Percentage)
            {
               OrderModify(OrderTicket(),OrderOpenPrice(),Bid-(Bid-OrderOpenPrice())*Percentage,OrderTakeProfit(),0,Blue);
               return(0);
            }
         }
         if((OrderOpenPrice()-Ask)>TrailingStop&&OrderType()==OP_SELL)
         {
            if(OrderStopLoss()>Ask+(OrderOpenPrice()-Ask)*Percentage)
            {
               OrderModify(OrderTicket(),OrderOpenPrice(),Ask+(OrderOpenPrice()-Ask)*Percentage,OrderTakeProfit(),0,Red);
               return(0);
            }
         }
     }  
}

//+------------------------------------------------------------------+