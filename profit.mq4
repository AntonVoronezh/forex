int tik1,tik2;
extern double kolvo = 0; 
extern double hod = 3;
extern double lot,lot_new; 
extern double minus2;
extern double minus =0;
int ticket2,minus_last;

int init()
{
return(0);

}
int start()
{

int ticket = GetLastOrderHist();
if (ticket == -1) return (0);lot = 0.01;
if (!OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY)) return (0);
if (OrderProfit() < 0)
if (ticket2!=ticket){
kolvo=kolvo+1;ticket2=ticket;

     if(kolvo==0){lot = 0.01;}
     if(kolvo==1){lot = 0.01;}
     if(kolvo==2){lot = 0.01;}
     if(kolvo==3){lot = 0.01;}
     if(kolvo==4){lot = 0.01;}
     if(kolvo==5){lot = 0.03;}
     if(kolvo==6){lot = 0.07;}          
     if(kolvo==7){lot = 0.15;}
     if(kolvo==8){lot = 0.31;}
     if(kolvo==9){lot = 0.63;}

   
minus_last = 400-(400+OrderProfit());
if(minus_last!=minus) 
minus = minus+minus_last;

}

if (OrderProfit() > 0)
{kolvo=0;
minus=0;}
lot_new = NormalizeDouble((minus/100)/hod,2)+kolvo*0.01;
//Comment(kolvo);
 //if(GetLastOrderHist()<0)Comment("minus");OrderTakeProfit()
//Comment();
Comment("kolvo- ",kolvo,"       minus- ",minus,"        тикет- ",GetLastOrderHist()," " );


}
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
double TP_SELL() {
int ticket = GetLastOrderHist();
if (ticket == -1) return (0);
if (!OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY)) return (0);
if (OrderType()==OP_SELL) {
return (OrderTakeProfit());
}
}
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
double TP_BUY() {
int ticket = GetLastOrderHist();
if (ticket == -1) return (0);
if (!OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY)) return (0);
if (OrderType()==OP_BUY) {
return (NormalizeDouble(OrderTakeProfit(),Digits));
}
}
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
double profit() {
int ticket = GetLastOrderHist();
if (ticket == -1) return (0);
if (!OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY)) return (0);
return (OrderProfit());
}
//////////////////////////////////////////////////////////////////////////////////////NormalizeDouble(frUP + 5*Point,Digits);




int GetLastOrderHist(int type = -1) 
{
int ticket = -1;
datetime dt = 0;
int cnt = HistoryTotal();

for (int i=0; i < cnt; i++) {
if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;



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



int GetLastPositiveOrdersCount() 
{
int PosCnt = 0;
int cnt = OrdersHistoryTotal();
for (int i = cnt-1; i >=0; i--) {

if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
//if (OrderSymbol() != Symbol()) continue;
//if (OrderMagicNumber() != Magic) continue;


int type = OrderType();
if (type != OP_BUY && type != OP_SELL) continue;

if (OrderProfit() < 0) break;

PosCnt++;
}

return (PosCnt);
}