int tik1,tik2;
extern double lot;
extern double open = 300;//75
extern double tp = 600;//150
extern double sl = 1;//-1500
extern double hod = 3;
int  Magic= 30060011;
static datetime lastbar;
extern double kolvo = 0; 
int ticket2=5555555555555;
extern double m_l_1,m_l_2,m_l_3,m_l_4,m_l_5,m_l_6,m_l_7,m_l_8;
extern double minus =0;


int init()
{
return(0);
lastbar=Time[Bars-1];
}

int start()
{

int ticket = GetLastOrderHist();
if (!ticket);lot = 0.02;
if (OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY));
if (OrderProfit() < 0){
if (ticket2!=ticket)
kolvo=kolvo+1;ticket2=ticket;

     if(kolvo==1){m_l_1 = 1000-(1000+OrderProfit());minus=m_l_1;}
     if(kolvo==2){m_l_2 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2;}
     if(kolvo==3){m_l_3 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2+m_l_3;}          
     if(kolvo==4){m_l_4 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2+m_l_3+m_l_4;}
     if(kolvo==5){m_l_5 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5;}
     if(kolvo==6){m_l_6 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5+m_l_6;}
     if(kolvo==7){m_l_7 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5+m_l_6+m_l_7;}     
     if(kolvo==8){m_l_8 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5+m_l_6+m_l_7+m_l_8;}      
//
if(kolvo==1){lot = NormalizeDouble((minus/100)/hod+0.02*kolvo,2);}
else{lot = NormalizeDouble((minus/100)/hod,2);}
}

if (OrderProfit() > 0)
{kolvo=0;minus=0;}



if (Time[0]>lastbar)
{
lastbar=Time[0]; 
datetime exp = CurTime() + 86400;//


if(Ask-Bid < 10*Point){ 

if(Hour()>8 && Hour()<21){
if(CountBuy()==0){tik1 = OrderSend(Symbol(), OP_BUYSTOP, lot, iOpen(NULL,PERIOD_H1,0)+open*Point, 3, iOpen(NULL,PERIOD_H1,0)+sl*Point, iOpen(NULL,PERIOD_H1,0)+tp*Point, "Open",Magic,exp);}
if(CountSell()==0){tik2 = OrderSend(Symbol(), OP_SELLSTOP, lot, iOpen(NULL,PERIOD_H1,0)-open*Point, 3, iOpen(NULL,PERIOD_H1,0)-sl*Point, iOpen(NULL,PERIOD_H1,0)-tp*Point, "Open", Magic,exp);}
            }
 }
 }           
 }        

     






  


int GetLastOrderHist(int type = -1) 
{
int ticket = -1;
datetime dt = 0;
int cnt = HistoryTotal();

for (int i=0; i < cnt; i++) {
if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;

if (OrderMagicNumber() != Magic) continue;
if (type != -1 && OrderType() != type) continue;
if (OrderType()==OP_BUY||OrderType()==OP_SELL) {
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
      if(OrderMagicNumber()==Magic)
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
      if(OrderMagicNumber()==Magic)
        {
         if(OrderType()==OP_BUY)
            count++;
        }
     }

   return(count);
}