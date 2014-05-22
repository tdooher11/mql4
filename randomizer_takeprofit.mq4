
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
extern double StopLoss = 0.0010;
extern double TakeProfit = 0.0010;
extern int OpenOrders = 1;
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
      if(OrdersTotal()<OpenOrders)
      {      
         random = 1 + 100*MathRand()/32768;
      
         if(random<50)
         {
            //OrderSend(Symbol(),OP_SELL,1,NormalizeDouble(Bid,5),2,Ask+StopLoss,Bid-TakeProfit);
            OrderSend(Symbol(),OP_BUY,1,NormalizeDouble(Ask,5),2,Bid-StopLoss,Ask+TakeProfit);
         }
         else
         {
            OrderSend(Symbol(),OP_SELL,1,NormalizeDouble(Bid,5),2,Ask+StopLoss,Bid-TakeProfit);
         }
      }  
}

//+------------------------------------------------------------------+