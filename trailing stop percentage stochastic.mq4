extern double TrailingStop = 0.0050;
extern int OpenOrders = 1;
extern double Percentage = 0.5;
extern double TakeProfit = 0.9000;
int stoch = 0;
int count = 0;
int random=0;
extern int seed=1000;
bool lasttradelong=true;

int init()
{
   MathSrand(TimeLocal());  
   return(0);
}

int start()
{
      if(AccountBalance()<5000){return(0);}
      stoch=iStochastic(Symbol(),0,14,3,3,MODE_EMA,0,MODE_MAIN,0);  
      if(OrdersTotal()<OpenOrders)
      {  
         random = 1 + seed*MathRand()/32768;     
         if(stoch<20 && lasttradelong==false){
            OrderSend(Symbol(),OP_BUY,1,NormalizeDouble(Ask,5),2,Bid-TrailingStop,Ask+TakeProfit); 
            lasttradelong=true;
         }
         if(stoch>80 && lasttradelong==true){
            OrderSend(Symbol(),OP_SELL,1,NormalizeDouble(Bid,5),2,Ask+TrailingStop,Bid-TakeProfit);
            lasttradelong=false;
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