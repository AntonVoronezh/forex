int tik1,tik11,tik2,tik22,tik3,tik33;
extern double lot_1,lot_2,lot_3;
extern double open = 400;//75
extern double tp = 800;//150
extern double sl = 1;//-1500
extern double hod = 4;
int  Magic_1= 30060041;
int  Magic_2= 30060042;
int  Magic_3= 30060043;
static datetime lastbar;
extern double kolvo_1,kolvo_2,kolvo_3; 
int ticket2_1=5555555555555;
int ticket2_2=5555555555555;
int ticket2_3=5555555555555;
extern double minus_1,minus_2,minus_3;
extern double m_l_1,m_l_2,m_l_3,m_l_4,m_l_5,m_l_6,m_l_7,m_l_8; 
extern double m_ls_1,m_ls_2,m_ls_3,m_ls_4,m_ls_5,m_ls_6,m_ls_7,m_ls_8; 
extern double m_lj_1,m_lj_2,m_lj_3,m_lj_4,m_lj_5,m_lj_6,m_lj_7,m_lj_8;

int init()
{
return(0);
lastbar=Time[Bars-1];
}

int start()
{
int ticket_1 = Last_1();
if (!ticket_1);lot_1 = 0.01;
if (OrderSelect(ticket_1, SELECT_BY_TICKET, MODE_HISTORY));
if (OrderProfit() < 0){
if (ticket2_1!=ticket_1)ticket2_1=ticket_1;
kolvo_1=kolvo_1+1;

     if(kolvo_1==1){m_l_1 = 1000-(1000+OrderProfit());minus_1=m_l_1;}
     if(kolvo_1==2){m_l_2 = 1000-(1000+OrderProfit());minus_1=m_l_1+m_l_2;}
     if(kolvo_1==3){m_l_3 = 1000-(1000+OrderProfit());minus_1=m_l_1+m_l_2+m_l_3;}          
     if(kolvo_1==4){m_l_4 = 1000-(1000+OrderProfit());minus_1=m_l_1+m_l_2+m_l_3+m_l_4;}
     if(kolvo_1==5){m_l_5 = 1000-(1000+OrderProfit());minus_1=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5;}
     if(kolvo_1==6){m_l_6 = 1000-(1000+OrderProfit());minus_1=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5+m_l_6;}
     if(kolvo_1==7){m_l_7 = 1000-(1000+OrderProfit());minus_1=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5+m_l_6+m_l_7;}     
     if(kolvo_1==8){m_l_8 = 1000-(1000+OrderProfit());minus_1=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5+m_l_6+m_l_7+m_l_8;}   
     
lot_1 = NormalizeDouble((minus_1/100)/hod,2);
}

if (OrderProfit() > 0)
{kolvo_1=0;minus_1=0;}
//==================================
int ticket_2 = Last_2();
if (!ticket_2);lot_2 = 0.01;
if (OrderSelect(ticket_2, SELECT_BY_TICKET, MODE_HISTORY));
if (OrderProfit() < 0){
if (ticket2_2!=ticket_2)ticket2_2=ticket_2;
kolvo_2=kolvo_2+1;

     if(kolvo_2==1){m_ls_1 = 1000-(1000+OrderProfit());minus_2=m_ls_1;}
     if(kolvo_2==2){m_ls_2 = 1000-(1000+OrderProfit());minus_2=m_ls_1+m_ls_2;}
     if(kolvo_2==3){m_ls_3 = 1000-(1000+OrderProfit());minus_2=m_ls_1+m_ls_2+m_ls_3;}          
     if(kolvo_2==4){m_ls_4 = 1000-(1000+OrderProfit());minus_2=m_ls_1+m_ls_2+m_ls_3+m_ls_4;}
     if(kolvo_2==5){m_ls_5 = 1000-(1000+OrderProfit());minus_2=m_ls_1+m_ls_2+m_ls_3+m_ls_4+m_ls_5;}
     if(kolvo_2==6){m_ls_6 = 1000-(1000+OrderProfit());minus_2=m_ls_1+m_ls_2+m_ls_3+m_ls_4+m_ls_5+m_ls_6;}
     if(kolvo_2==7){m_ls_7 = 1000-(1000+OrderProfit());minus_2=m_ls_1+m_ls_2+m_ls_3+m_ls_4+m_ls_5+m_ls_6+m_ls_7;}     
     if(kolvo_2==8){m_ls_8 = 1000-(1000+OrderProfit());minus_2=m_ls_1+m_ls_2+m_ls_3+m_ls_4+m_ls_5+m_ls_6+m_ls_7+m_ls_8;} 
     
lot_2 = NormalizeDouble((minus_2/100)/hod,2);

}

if (OrderProfit() > 0)
{kolvo_2=0;minus_2=0;}
//==================================
int ticket_3 = Last_3();
if (!ticket_3);lot_3 = 0.01;
if (OrderSelect(ticket_3, SELECT_BY_TICKET, MODE_HISTORY));
if (OrderProfit() < 0){
if (ticket2_3!=ticket_3)ticket2_3=ticket_3;
kolvo_3=kolvo_3+1;

     if(kolvo_3==1){m_lj_1 = 1000-(1000+OrderProfit());minus_3=m_lj_1;}
     if(kolvo_3==2){m_lj_2 = 1000-(1000+OrderProfit());minus_3=m_lj_1+m_lj_2;}
     if(kolvo_3==3){m_lj_3 = 1000-(1000+OrderProfit());minus_3=m_lj_1+m_lj_2+m_lj_3;}          
     if(kolvo_3==4){m_lj_4 = 1000-(1000+OrderProfit());minus_3=m_lj_1+m_lj_2+m_lj_3+m_lj_4;}
     if(kolvo_3==5){m_lj_5 = 1000-(1000+OrderProfit());minus_3=m_lj_1+m_lj_2+m_lj_3+m_lj_4+m_lj_5;}
     if(kolvo_3==6){m_lj_6 = 1000-(1000+OrderProfit());minus_3=m_lj_1+m_lj_2+m_lj_3+m_lj_4+m_lj_5+m_lj_6;}
     if(kolvo_3==7){m_lj_7 = 1000-(1000+OrderProfit());minus_3=m_lj_1+m_lj_2+m_lj_3+m_lj_4+m_lj_5+m_lj_6+m_lj_7;}     
     if(kolvo_3==8){m_lj_8 = 1000-(1000+OrderProfit());minus_3=m_lj_1+m_lj_2+m_lj_3+m_lj_4+m_lj_5+m_lj_6+m_lj_7+m_lj_8;}   
     
lot_3 = NormalizeDouble((minus_3/100)/hod,2);
}

if (OrderProfit() > 0)
{kolvo_3=0;minus_3=0;}

/*
for (int f1=OrdersTotal()-1; f1>=0; f1--)
{
if(OrderSelect(f1,SELECT_BY_POS,MODE_TRADES))
if (OrderMagicNumber() != Magic_1) continue;
if(OrderCloseTime()==0) 
if(lot_1!=OrderLots())OrderDelete(OrderTicket());
}
for (int f2=OrdersTotal()-1; f2>=0; f2--)
{
if(OrderSelect(f2,SELECT_BY_POS,MODE_TRADES))
if (OrderMagicNumber() != Magic_2) continue;
if(OrderCloseTime()==0) 
if(lot_2!=OrderLots())OrderDelete(OrderTicket());
}
for (int f3=OrdersTotal()-1; f3>=0; f3--)
{
if(OrderSelect(f3,SELECT_BY_POS,MODE_TRADES))
if (OrderMagicNumber() != Magic_3) continue;
if(OrderCloseTime()==0) 
if(lot_3!=OrderLots())OrderDelete(OrderTicket());
}
*/

if (Time[0]>lastbar)
{
lastbar=Time[0]; 
datetime exp = CurTime() + 14400;//
Print(1000-(1000+OrderProfit()));

if(Ask-Bid < 10*Point){ 

if(Hour()>11 && Hour()<13)
            {
if(CountBuy_2()==0){tik2 = OrderSend(Symbol(), OP_BUYSTOP, lot_2, iOpen(NULL,PERIOD_H4,0)+open*Point, 3, iOpen(NULL,PERIOD_H4,0)+sl*Point, iOpen(NULL,PERIOD_H4,0)+tp*Point, "Open",Magic_2,exp);}
if(CountSell_2()==0){tik22 = OrderSend(Symbol(), OP_SELLSTOP, lot_2, iOpen(NULL,PERIOD_H4,0)-open*Point, 3, iOpen(NULL,PERIOD_H4,0)-sl*Point, iOpen(NULL,PERIOD_H4,0)-tp*Point, "Open", Magic_2,exp);}
            }  
if(Hour()>7 && Hour()<9)
            {
if(CountBuy_1()==0){tik1 = OrderSend(Symbol(), OP_BUYSTOP, lot_1, iOpen(NULL,PERIOD_H4,0)+open*Point, 3, iOpen(NULL,PERIOD_H4,0)+sl*Point, iOpen(NULL,PERIOD_H4,0)+tp*Point, "Open",Magic_1,exp);}
if(CountSell_1()==0){tik11 = OrderSend(Symbol(), OP_SELLSTOP, lot_1, iOpen(NULL,PERIOD_H4,0)-open*Point, 3, iOpen(NULL,PERIOD_H4,0)-sl*Point, iOpen(NULL,PERIOD_H4,0)-tp*Point, "Open", Magic_1,exp);}
            }
if(Hour()>15 && Hour()<17)
            {
//if(CountBuy_3()==0){tik1 = OrderSend(Symbol(), OP_BUYSTOP, lot_3, iOpen(NULL,PERIOD_H4,0)+open*Point, 3, iOpen(NULL,PERIOD_H4,0)+sl*Point, iOpen(NULL,PERIOD_H4,0)+tp*Point, "Open",Magic_3,exp);}
//if(CountSell_3()==0){tik11 = OrderSend(Symbol(), OP_SELLSTOP, lot_3, iOpen(NULL,PERIOD_H4,0)-open*Point, 3, iOpen(NULL,PERIOD_H4,0)-sl*Point, iOpen(NULL,PERIOD_H4,0)-tp*Point, "Open", Magic_3,exp);}
            }
          
            
 }
 }           
 }        

     






  
  
int Last_1(int type = -1) 
{
int ticket = -1;
datetime dt = 0;
int cnt = HistoryTotal();

for (int i=0; i < cnt; i++) {
if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;

if (OrderMagicNumber() != Magic_1) continue;
if (type != -1 && OrderType() != type) continue;
if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
if (OrderCloseTime() > dt) {
dt = OrderCloseTime();
ticket = OrderTicket();
}
}
}
return (ticket);
}

int CountSell_1()
  {
   int count=0;
   for(int trade=OrdersTotal()-1;trade>=0; trade--)
     {
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_1)
        {
         if(OrderType()==OP_BUY || OrderType()==OP_SELL)
            count++;
        }
     }

   return(count);
}



int CountBuy_1()
  {
   int count=0;
   for(int trade=OrdersTotal()-1;trade>=0; trade--)
     {
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_1)
        {
         if(OrderType()==OP_BUY || OrderType()==OP_SELL)
            count++;
        }
     }

   return(count);
}

//===========================================

int Last_2(int type = -1) 
{
int ticket = -1;
datetime dt = 0;
int cnt = HistoryTotal();

for (int i=0; i < cnt; i++) {
if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;

if (OrderMagicNumber() != Magic_2) continue;
if (type != -1 && OrderType() != type) continue;
if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
if (OrderCloseTime() > dt) {
dt = OrderCloseTime();
ticket = OrderTicket();
}
}
}
return (ticket);
}

int CountSell_2()
  {
   int count=0;
   for(int trade=OrdersTotal()-1;trade>=0; trade--)
     {
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_2)
        {
         if(OrderType()==OP_BUY || OrderType()==OP_SELL)
            count++;
        }
     }

   return(count);
}



int CountBuy_2()
  {
   int count=0;
   for(int trade=OrdersTotal()-1;trade>=0; trade--)
     {
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_2)
        {
         if(OrderType()==OP_BUY || OrderType()==OP_SELL)
            count++;
        }
     }

   return(count);
}


//===========================================

int Last_3(int type = -1) 
{
int ticket = -1;
datetime dt = 0;
int cnt = HistoryTotal();

for (int i=0; i < cnt; i++) {
if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;

if (OrderMagicNumber() != Magic_3) continue;
if (type != -1 && OrderType() != type) continue;
if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
if (OrderCloseTime() > dt) {
dt = OrderCloseTime();
ticket = OrderTicket();
}
}
}
return (ticket);
}

int CountSell_3()
  {
   int count=0;
   for(int trade=OrdersTotal()-1;trade>=0; trade--)
     {
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_3)
        {
         if(OrderType()==OP_BUY || OrderType()==OP_SELL)
            count++;
        }
     }

   return(count);
}



int CountBuy_3()
  {
   int count=0;
   for(int trade=OrdersTotal()-1;trade>=0; trade--)
     {
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_3)
        {
         if(OrderType()==OP_BUY || OrderType()==OP_SELL)
            count++;
        }
     }

   return(count);
}
