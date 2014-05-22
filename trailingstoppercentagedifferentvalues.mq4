extern double TrailingStop = 0.0050;
extern int OpenOrders = 20;
extern double Percentage = 0.5;
extern double TakeProfit = 0.0400;
extern double lotsize = 0.1;
int count = 0;
int random=0;
int random2=0;
int seed=1000;
extern int trailingstopfactor=1;
extern int takeprofitfactor=1;

int init(){  MathSrand(TimeLocal());  return(0);}
int start()
{
      //if(AccountBalance()<1000){return(0);} 
      //Print("Random:"+random); 
      //Print("Random2:"+random2);
      random = 1 + seed*MathRand()/32768;
      random2 = 2 + seed*MathRand()/32768;         
       
      if(OrdersTotal()<OpenOrders)
      {     
         //Print("Random2:"+random2);
      
         if(250>=random2>0){
         
            trailingstopfactor=1;
            takeprofitfactor=1;
         }else if(500>=random2>250){
            Print("500>=random2>250");
            trailingstopfactor=2;
            takeprofitfactor=2;
         }else if (750>=random2>500){
            trailingstopfactor=3;
            takeprofitfactor=3;
         }else if (1000>=random2>750){
            trailingstopfactor=4;
            takeprofitfactor=4;
         }
      
         if(random==25){
            OrderSend(Symbol(),OP_BUY,lotsize,NormalizeDouble(Ask,5),2,Bid-TrailingStop*trailingstopfactor,Ask+TakeProfit*takeprofitfactor);
            Print("TakeProfit*takeprofitfactor: "+TakeProfit*takeprofitfactor);
            Print("TrailingStop*trailingstopfactor: "+TrailingStop*trailingstopfactor);
         }
         if(random==75){
            OrderSend(Symbol(),OP_SELL,lotsize,NormalizeDouble(Bid,5),2,Ask+TrailingStop*trailingstopfactor,Bid-TakeProfit*takeprofitfactor);
            Print("TakeProfit*takeprofitfactor: "+TakeProfit*takeprofitfactor);
            Print("TrailingStop*trailingstopfactor: "+TrailingStop*trailingstopfactor);     
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