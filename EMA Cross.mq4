//+------------------------------------------------------------------+
//|                                                     emaCross.mq4 |
//|                      Copyright © 2010, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2010, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

extern int Period_MA1 = 5;            // Calculated MA period
extern int Period_MA2 = 47;
extern int Period_MA3 = 200;
extern double TrailingStop = 0.005;
extern int stochFactor = 4;
extern int stochParam1=75;
extern int stochParam2=45;
int stochParam3=45;
double TakeProfit = 0.3000;
bool Fact_Up = true;                  // Fact of report that price..
bool Fact_Dn = true;
bool volume_increase = false; 
double MA1;                         // MA value on 0 bar    
double MA2;
double MA3;
double MA1_PREV;
double MA2_PREV;
double MA1shift;
double stoch;
double highPrice=0;
double currentPrice=0;
int cnt = 0;
int lots = 1;

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
{
//----
   Alert("init took place");

//----
   return(0);
}
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
{
//----
   
//----
   return(0);
}
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()                           // Special function start()
{
        
        //Alert(MarketInfo(Symbol(), MODE_STOPLEVEL));
        //Alert(TrailingStop*Point);
//--------------------------------------------------------------------
                                      // Tech. ind. function call
                                      
   if(AccountFreeMargin() < 5000)
   {
      return(0);
   }
                                      
 
                                      
   MA1=iMA(NULL,0,Period_MA1,0,MODE_EMA,PRICE_CLOSE,0); 
   MA2=iMA(NULL,0,Period_MA2,0,MODE_EMA,PRICE_CLOSE,0);
   MA3=iMA(NULL,0,Period_MA3,0,MODE_EMA,PRICE_CLOSE,0);
   MA1shift=iMA(NULL,0,Period_MA1,0,MODE_EMA,PRICE_CLOSE,5);
   
   stochParam1=5*stochFactor;
   stochParam2=3*stochFactor;
   stoch=iStochastic(Symbol(),1,stochParam1,stochParam2,stochParam2,MODE_EMA,0,MODE_MAIN,0);
  
  // stoch=iStochastic(Symbol(),1,stochParam1,stochParam2,stochParam2,MODE_EMA,0,MODE_MAIN,0);
   
   
   if(Volume[0] > Volume[1])
   {
      volume_increase = true;
   }
   
//--------------------------------------------------------------------

   if (MA1>MA2 && MA1_PREV<MA2_PREV && volume_increase == true && OrdersTotal()<1)  
   {
      
     
      //Alert(Ask+TrailingStop);// Alert
      //lots=AccountFreeMargin()/5000;
      
      //Alert(AccountFreeMargin()+",lots="+lots);
      RefreshRates();
   
         OrderSend(Symbol(),OP_BUY,lots,NormalizeDouble(Ask,5),2,Bid-TrailingStop,Bid+TakeProfit);
         volume_increase = false;
         
     
      //Alert("Order opened at:"+Ask);
   }
   
   if (MA1<MA2 && MA1_PREV>MA2_PREV && volume_increase == true && OrdersTotal()<1)  
   {
      //Alert("Bid:"+NormalizeDouble(Bid,5)+",Stop:"+(Ask+TrailingStop));// Alert 
      //lots=AccountFreeMargin()/5000;
      
      //Alert(AccountFreeMargin()+",lots="+lots);
      
      RefreshRates();
      
         OrderSend(Symbol(),OP_SELL,lots,NormalizeDouble(Bid,5),2,Ask+TrailingStop,Ask-TakeProfit);
         volume_increase = false;
      
      //Alert("Order opened at:"+Ask);
   }
   
   
   
//----------------------------------------------------------------------   
   if(OrdersTotal() > 0)
   {
      for(cnt=0;cnt<OrdersTotal();cnt++)
      {
         OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
         
         if(Bid-OrderOpenPrice()>TrailingStop&&OrderType()==OP_BUY)
         {
            if(OrderStopLoss()<Bid-TrailingStop)
            {
                     OrderModify(OrderTicket(),OrderOpenPrice(),Bid-TrailingStop,OrderTakeProfit(),0,Blue);
                     //Alert("Trailing stop modified, new value:"+OrderStopLoss());
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
//--------------------------------------------------------------------
   MA1_PREV = MA1;
   MA2_PREV = MA2;
   return(0);                            // Exit start()
}
//+----------------------------------------------------+