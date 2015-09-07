extern int OpenOrders = 20;
extern double lotsize = 1.0;

extern double Percentage = 0.65;
extern double TrailingStop = 0.0160;
extern double TakeProfit = 0.1200;

extern double Percentage2 = 0.35;
extern double TrailingStop2 = 0.0160;
extern double TakeProfit2 = 0.0300;

extern double Percentage3 = 0.35;
extern double TrailingStop3 = 0.0160;
extern double TakeProfit3 = 0.0300;

int count = 0;
int random=0;
extern int seed=1000;

int init()
{
   //Print("Init");
   MathSrand(TimeLocal());  
   return(0);
}

int start()
{
      //Print("Start");
      if(AccountEquity()-AccountBalance()>75000)
      {
         Print("Current profit greater than 75000");
         closeall();
      }
      
      if(AccountBalance()<1000){return(0);}
         
      if(OrdersTotal()<OpenOrders)
      {  
         random = 1 + seed*MathRand()/32768;
         //Print("Random:"+random);
         if(random==25){
            OrderSend(Symbol(),OP_BUY,lotsize,NormalizeDouble(Ask,5),2,Bid-TrailingStop,Ask+TakeProfit,"ordertype1",1);
         }
         if(random==75){
            OrderSend(Symbol(),OP_SELL,lotsize,NormalizeDouble(Bid,5),2,Ask+TrailingStop,Bid-TakeProfit,"ordertype1",1);     
         } 
         if(random==125){
            OrderSend(Symbol(),OP_BUY,lotsize,NormalizeDouble(Ask,5),2,Bid-TrailingStop2,Ask+TakeProfit2,"ordertype2",2);
         }
         if(random==175){
            OrderSend(Symbol(),OP_SELL,lotsize,NormalizeDouble(Bid,5),2,Ask+TrailingStop2,Bid-TakeProfit2,"ordertype2",2);     
         } 
         if(random==225){
            OrderSend(Symbol(),OP_BUY,lotsize,NormalizeDouble(Ask,5),2,Bid-TrailingStop3,Ask+TakeProfit3,"ordertype3",3);
         }
         if(random==275){
            OrderSend(Symbol(),OP_SELL,lotsize,NormalizeDouble(Bid,5),2,Ask+TrailingStop3,Bid-TakeProfit3,"ordertype3",3);     
         }
               
      }  
         
      for(int cnt=0;cnt<OrdersTotal();cnt++)
      {
         OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
         if(OrderMagicNumber()==1)
         {
         if(Bid>OrderOpenPrice()&&OrderType()==OP_BUY)
         {
            if(Bid<OrderOpenPrice()+TrailingStop/Percentage)
            {
               if(OrderStopLoss()<Bid-TrailingStop)
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Bid-TrailingStop,OrderTakeProfit(),0,Blue);
               }
            }
            if(Bid>OrderOpenPrice()+TrailingStop/Percentage)
            {
               if(OrderStopLoss()<Bid-(Bid-OrderOpenPrice()*Percentage))
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Bid-(Bid-OrderOpenPrice())*Percentage,OrderTakeProfit(),0,Blue);
               }
            }
         }
         
         if(Ask<OrderOpenPrice()&&OrderType()==OP_SELL)
         {
            if(Ask>OrderOpenPrice()-TrailingStop/Percentage)
            {
               if(OrderStopLoss()>Ask+TrailingStop)
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Ask+TrailingStop,OrderTakeProfit(),0,Blue);
               }
            }
            if(Ask<OrderOpenPrice()-TrailingStop/Percentage)
            {
               if(OrderStopLoss()>Ask+(OrderOpenPrice()-Ask)*Percentage)
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Ask+(OrderOpenPrice()-Ask)*Percentage,OrderTakeProfit(),0,Blue);
               }
            }
         }
         }
         else if(OrderMagicNumber()==2)
         {
         if(Bid>OrderOpenPrice()&&OrderType()==OP_BUY)
         {
            if(Bid<OrderOpenPrice()+TrailingStop2/Percentage2)
            {
               if(OrderStopLoss()<Bid-TrailingStop2)
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Bid-TrailingStop2,OrderTakeProfit(),0,Blue);
               }
            }
            if(Bid>OrderOpenPrice()+TrailingStop2/Percentage2)
            {
               if(OrderStopLoss()<Bid-(Bid-OrderOpenPrice()*Percentage2))
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Bid-(Bid-OrderOpenPrice())*Percentage2,OrderTakeProfit(),0,Blue);
               }
            }
         }
         
         if(Ask<OrderOpenPrice()&&OrderType()==OP_SELL)
         {
            if(Ask>OrderOpenPrice()-TrailingStop2/Percentage2)
            {
               if(OrderStopLoss()>Ask+TrailingStop2)
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Ask+TrailingStop2,OrderTakeProfit(),0,Blue);
               }
            }
            if(Ask<OrderOpenPrice()-TrailingStop2/Percentage2)
            {
               if(OrderStopLoss()>Ask+(OrderOpenPrice()-Ask)*Percentage2)
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Ask+(OrderOpenPrice()-Ask)*Percentage2,OrderTakeProfit(),0,Blue);
               }
            }
         }
         }
         else if(OrderMagicNumber()==3)
         {
         if(Bid>OrderOpenPrice()&&OrderType()==OP_BUY)
         {
            if(Bid<OrderOpenPrice()+TrailingStop3/Percentage3)
            {
               if(OrderStopLoss()<Bid-TrailingStop3)
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Bid-TrailingStop3,OrderTakeProfit(),0,Blue);
               }
            }
            if(Bid>OrderOpenPrice()+TrailingStop3/Percentage3)
            {
               if(OrderStopLoss()<Bid-(Bid-OrderOpenPrice()*Percentage3))
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Bid-(Bid-OrderOpenPrice())*Percentage3,OrderTakeProfit(),0,Blue);
               }
            }
         }
         
         if(Ask<OrderOpenPrice()&&OrderType()==OP_SELL)
         {
            if(Ask>OrderOpenPrice()-TrailingStop3/Percentage3)
            {
               if(OrderStopLoss()>Ask+TrailingStop3)
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Ask+TrailingStop3,OrderTakeProfit(),0,Blue);
               }
            }
            if(Ask<OrderOpenPrice()-TrailingStop3/Percentage3)
            {
               if(OrderStopLoss()>Ask+(OrderOpenPrice()-Ask)*Percentage3)
               {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Ask+(OrderOpenPrice()-Ask)*Percentage3,OrderTakeProfit(),0,Blue);
               }
            }
         }
         }
     }
}
int closeall()
{

  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
    int type   = OrderType();
    bool result = false;

    switch(type)
    {
      //Close opened long positions
      case OP_BUY       : result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red );
                          break;
      //Close opened short positions
      case OP_SELL      : result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, Red );                    
    }

    if(result == false)
    {
      Alert("Order " , OrderTicket() , " failed to close. Error:" , GetLastError() );
      Sleep(3000);
    }  
  }
  return(0);
}