extern double TrailingStop = 0.0050;
extern int OpenOrders = 1;
extern double Percentage = 0.5;
double TakeProfit = 0.3000;
int count = 0;
int random=0;
extern int seed=1000;

int init()
{
   MathSrand(TimeLocal());  
   return(0);
}

int start()
{
      if(AccountBalance()<5000){return(0);}
         
      if(OrdersTotal()<OpenOrders)
      {  
         random = 1 + seed*MathRand()/32768;
         //Print("Random:"+random);      
         if(random==25){
            OrderSend(Symbol(),OP_BUY,1,NormalizeDouble(Ask,5),2,Bid-TrailingStop,Ask+TakeProfit);  
         }
         if(random==75){
            OrderSend(Symbol(),OP_SELL,1,NormalizeDouble(Bid,5),2,Ask+TrailingStop,Bid-TakeProfit);    
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