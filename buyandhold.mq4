extern double TrailingStop = 0.0050;
extern int OpenOrders = 1;
extern double Percentage = 0.5;
extern double TakeProfit = 0.0050;
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
         if(random==25){
            OrderSend(Symbol(),OP_BUY,lotsize,NormalizeDouble(Ask,5),2,Bid-5,Ask+5);
         }
         if(random==75){
            OrderSend(Symbol(),OP_SELL,lotsize,NormalizeDouble(Bid,5),2,Ask+5,Bid-5);     
         }        
      }         
 
}

//+------------------------------------------------------------------+