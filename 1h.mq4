int tik1,tik2;
extern double lot_sell,lot_buy;
extern double open = 50;//75
extern double tp = 100;//150
extern double sl = 1;//-1500
extern double hod = 0.5;
int  Magic_sell= 30060011;
int  Magic_buy= 30060012;
static datetime lastbar;
extern double kolvo_buy = 0; 
extern double kolvo_sell = 0;
int ticket2_buy=5555555555555;
int ticket2_sell=5555555555555;
extern double m_l_1,m_l_2,m_l_3,m_l_4,m_l_5,m_l_6,m_l_7,m_l_8;
extern double m_ls_1,m_ls_2,m_ls_3,m_ls_4,m_ls_5,m_ls_6,m_ls_7,m_ls_8; 
extern double minus_buy =0;
extern double minus_sell =0;

int init()
{
return(0);
lastbar=Time[Bars-1];
}

int start()
{
/*
int ticket_sell = Last_sell();
if (!ticket_sell);lot_sell = 0.01;
if (OrderSelect(ticket_sell, SELECT_BY_TICKET, MODE_HISTORY));

if (OrderProfit() < 0)
{lot_sell = 0.02;}
if (OrderProfit() > 0)
{lot_sell = 0.01;}

////

int ticket_buy = Last_buy();
if (!ticket_buy);lot_buy = 0.01;
if (OrderSelect(ticket_buy, SELECT_BY_TICKET, MODE_HISTORY));

if (OrderProfit() < 0)
{lot_buy = 0.02;}
if (OrderProfit() > 0)
{lot_buy = 0.01;}
*/

int ticket_buy = Last_buy();
if (!ticket_buy);lot_buy = 0.01;
if (OrderSelect(ticket_buy, SELECT_BY_TICKET, MODE_HISTORY));
if (OrderProfit() < 0){
if (ticket2_buy!=ticket_buy)
kolvo_buy=kolvo_buy+1;ticket2_buy=ticket_buy;

     if(kolvo_buy==1){m_l_1 = 1000-(1000+OrderProfit());minus_buy=m_l_1;}
     if(kolvo_buy==2){m_l_2 = 1000-(1000+OrderProfit());minus_buy=m_l_1+m_l_2;}
     if(kolvo_buy==3){m_l_3 = 1000-(1000+OrderProfit());minus_buy=m_l_1+m_l_2+m_l_3;}          
     if(kolvo_buy==4){m_l_4 = 1000-(1000+OrderProfit());minus_buy=m_l_1+m_l_2+m_l_3+m_l_4;}
     if(kolvo_buy==5){m_l_5 = 1000-(1000+OrderProfit());minus_buy=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5;}
     if(kolvo_buy==6){m_l_6 = 1000-(1000+OrderProfit());minus_buy=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5+m_l_6;}
     if(kolvo_buy==7){m_l_7 = 1000-(1000+OrderProfit());minus_buy=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5+m_l_6+m_l_7;}     
     if(kolvo_buy==8){m_l_8 = 1000-(1000+OrderProfit());minus_buy=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5+m_l_6+m_l_7+m_l_8;}      
//
lot_buy = NormalizeDouble((minus_buy/100)/hod+0.01*kolvo_buy,2);
}

if (OrderProfit() > 0)
{kolvo_buy=0;minus_buy=0;}

//Comment("kolvo- ",kolvo,"       minus- ",minus,"        тикет- ",GetLastOrderHist()," " );

int ticket_sell = Last_sell();
if (!ticket_sell);lot_sell = 0.01;
if (OrderSelect(ticket_sell, SELECT_BY_TICKET, MODE_HISTORY));
if (OrderProfit() < 0){
if (ticket2_sell!=ticket_sell)
kolvo_sell=kolvo_sell+1;ticket2_sell=ticket_sell;

     if(kolvo_sell==1){m_ls_1 = 1000-(1000+OrderProfit());minus_sell=m_ls_1;}
     if(kolvo_sell==2){m_ls_2 = 1000-(1000+OrderProfit());minus_sell=m_ls_1+m_ls_2;}
     if(kolvo_sell==3){m_ls_3 = 1000-(1000+OrderProfit());minus_sell=m_ls_1+m_ls_2+m_ls_3;}          
     if(kolvo_sell==4){m_ls_4 = 1000-(1000+OrderProfit());minus_sell=m_ls_1+m_ls_2+m_ls_3+m_ls_4;}
     if(kolvo_sell==5){m_ls_5 = 1000-(1000+OrderProfit());minus_sell=m_ls_1+m_ls_2+m_ls_3+m_ls_4+m_ls_5;}
     if(kolvo_sell==6){m_ls_6 = 1000-(1000+OrderProfit());minus_sell=m_ls_1+m_ls_2+m_ls_3+m_ls_4+m_ls_5+m_ls_6;}
     if(kolvo_sell==7){m_ls_7 = 1000-(1000+OrderProfit());minus_sell=m_ls_1+m_ls_2+m_ls_3+m_ls_4+m_ls_5+m_ls_6+m_ls_7;}     
     if(kolvo_sell==8){m_ls_8 = 1000-(1000+OrderProfit());minus_sell=m_ls_1+m_ls_2+m_ls_3+m_ls_4+m_ls_5+m_ls_6+m_ls_7+m_ls_8;}      
//
lot_sell = NormalizeDouble((minus_sell/100)/hod+0.01*kolvo_sell,2);
}

if (OrderProfit() > 0)
{kolvo_sell=0;minus_sell=0;}


if (Time[0]>lastbar)
{
lastbar=Time[0]; 
datetime exp = CurTime() + 86400;//


if(Ask-Bid < 10*Point){ 

if(Hour()>8 && Hour()<10){
if(CountBuy()==0){tik1 = OrderSend(Symbol(), OP_BUYSTOP, lot_buy, iOpen(NULL,PERIOD_H1,0)+open*Point, 3, iOpen(NULL,PERIOD_H1,0)+sl*Point, iOpen(NULL,PERIOD_H1,0)+tp*Point, "Open",Magic_buy,exp);}
if(CountSell()==0){tik2 = OrderSend(Symbol(), OP_SELLSTOP, lot_sell, iOpen(NULL,PERIOD_H1,0)-open*Point, 3, iOpen(NULL,PERIOD_H1,0)-sl*Point, iOpen(NULL,PERIOD_H1,0)-tp*Point, "Open", Magic_sell,exp);}
            }
 }
 }           
 }        

     






  
  
int Last_sell(int type = -1) 
{
int ticket = -1;
datetime dt = 0;
int cnt = HistoryTotal();

for (int i=0; i < cnt; i++) {
if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;

if (OrderMagicNumber() != Magic_sell) continue;
if (type != -1 && OrderType() != type) continue;
if (OrderType()==OP_SELL) {
if (OrderCloseTime() > dt) {
dt = OrderCloseTime();
ticket = OrderTicket();
}
}
}
return (ticket);
}

int Last_buy(int type = -1) 
{
int ticket = -1;
datetime dt = 0;
int cnt = HistoryTotal();

for (int i=0; i < cnt; i++) {
if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;

if (OrderMagicNumber() != Magic_buy) continue;
if (type != -1 && OrderType() != type) continue;
if (OrderType()==OP_BUY) {
if (OrderCloseTime() > dt) {
dt = OrderCloseTime();
ticket = OrderTicket();
}
}
}
return (ticket);
}


int CountSell()
  {
   int count=0;
   for(int trade=OrdersTotal()-1;trade>=0; trade--)
     {
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_sell)
        {
         if(OrderType()==OP_SELL)
            count++;
        }
     }

   return(count);
}



int CountBuy()
  {
   int count=0;
   for(int trade=OrdersTotal()-1;trade>=0; trade--)
     {
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_buy)
        {
         if(OrderType()==OP_BUY)
            count++;
        }
     }

   return(count);
}