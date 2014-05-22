//+------------------------------------------------------------------+
double TrailingStop = 0.3000;
extern int OpenOrders = 1;
double TakeProfit = 0.3000;
extern int Period_MA1 = 50;
double MA,MA_PREV,prev_bid,prev_ask;
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
         MA=iMA(NULL,0,Period_MA1,0,MODE_EMA,PRICE_CLOSE,0);
         random = 1 + 100*MathRand()/32768;
      
         if(random==25 && Ask > MA)
         {
            OrderSend(Symbol(),OP_BUY,1,NormalizeDouble(Ask,5),2,Bid-TrailingStop,Ask+TakeProfit);
         }
         if(random==75 && Bid < MA)
         {
            OrderSend(Symbol(),OP_SELL,1,NormalizeDouble(Bid,5),2,Ask+TrailingStop,Bid-TakeProfit);
         }        
      }  

         for(int cnt=0;cnt<OrdersTotal();cnt++)
         {
            OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
      
            if(Bid<= MA  && OrderType()==OP_BUY)
            {
               OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
               OrderClose(OrderTicket(),1,Bid,3,Blue);
            }
            if(Ask>= MA && OrderType()==OP_SELL)
            {
                  OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
                  OrderClose(OrderTicket(),1,Ask,3,Blue);
            }
         }
         prev_bid=Bid;
         prev_ask=Ask;
         MA_PREV=MA;
}

//+------------------------------------------------------------------+