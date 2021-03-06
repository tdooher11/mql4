extern double TrailingStop = 0.013;
extern int OpenOrders = 20;
extern double Percentage = 0.65;
extern double TakeProfit = 0.13;
extern double lotsize = 1;

extern int Period_MA1 = 5;            // Calculated MA period
extern int Period_MA2 = 47;
double MA1;                         // MA value on 0 bar    
double MA2;
double MA1_PREV;
double MA2_PREV;
extern int stochParam1=5;
extern int stochParam2=3;
extern int stochfactor=1;
double stoch;
int difference=0;

int count = 0;
int waitcount = 0;
int random=0;
int seed=1000;
int init(){  MathSrand(TimeLocal());  return(0);}
int start()
{

      MA1=iMA(NULL,0,Period_MA1,0,MODE_EMA,PRICE_CLOSE,0); 
      MA2=iMA(NULL,0,Period_MA2,0,MODE_EMA,PRICE_CLOSE,0);
      stochParam1=stochParam1*stochfactor;
      stochParam2=stochParam2*stochfactor;
      stoch=iStochastic(Symbol(),1,stochParam1,stochParam2,stochParam2,MODE_EMA,0,MODE_MAIN,0);
      //if(AccountBalance()<1000){return(0);}        
      if(OrdersTotal()<OpenOrders)
      {  
         random = 1 + seed*MathRand()/32768;
         if(MA1<MA2 && MA1_PREV>MA2_PREV && stoch <= 20 && waitcount>1000){
            OrderSend(Symbol(),OP_BUY,lotsize,NormalizeDouble(Ask,5),2,Bid-TrailingStop,Ask+TakeProfit);
            waitcount=0;
         }
         if(MA1>MA2 && MA1_PREV<MA2_PREV && stoch >= 80 && waitcount>1000){        
            OrderSend(Symbol(),OP_SELL,lotsize,NormalizeDouble(Bid,5),2,Ask+TrailingStop,Bid-TakeProfit);
            waitcount=0;     
         }        
      } 
          
      MA1_PREV = MA1;
      MA2_PREV = MA2;
      waitcount++;
             
      for(int cnt=0;cnt<OrdersTotal();cnt++)
      {
         OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);     
         if(Bid-OrderOpenPrice()>TrailingStop&&OrderType()==OP_BUY) 
         {
            if(OrderStopLoss()<Bid-(Bid-OrderOpenPrice())*Percentage)
            {
               difference=TimeCurrent()-OrderOpenTime();
	            //Percentage=Percentage*(1-(difference/20000000));       
               OrderModify(OrderTicket(),OrderOpenPrice(),Bid-(Bid-OrderOpenPrice())*Percentage,OrderTakeProfit(),0,Blue);
               return(0);
            }
         }
         if((OrderOpenPrice()-Ask)>TrailingStop&&OrderType()==OP_SELL)
         {
            if(OrderStopLoss()>Ask+(OrderOpenPrice()-Ask)*Percentage)
            {
	           difference=TimeCurrent()-OrderOpenTime();
	          // Percentage=Percentage*(1-(difference/20000000));
               OrderModify(OrderTicket(),OrderOpenPrice(),Ask+(OrderOpenPrice()-Ask)*Percentage,OrderTakeProfit(),0,Red);
               return(0);
            }
         }
     }  
}