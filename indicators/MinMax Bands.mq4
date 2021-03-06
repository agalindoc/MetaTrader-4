//+------------------------------------------------------------------+
//|                                                 MinMax Bands.mq4 |
//|                      Copyright © 2021, Alejandro Galindo Cháirez |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2021, Alejandro Galindo Chairez"
#property link      ""
#property version   "1.00"

//---- indicator settings
#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 Blue
#property indicator_color2 Blue
#property indicator_color3 Green
#property indicator_color4 Green

extern ENUM_SERIESMODE Price = MODE_CLOSE;
extern int Band_Period = 144;
extern bool ShowMiddleBands = false;

//---- buffers
double BandUp[];
double BandDown[];
double MidUp[];
double MidDown[];

int init() {
   //---- drawing settings
  SetIndexStyle(0,DRAW_LINE, 2, 1);
  SetIndexStyle(1,DRAW_LINE, 2, 1);
  SetIndexStyle(2,DRAW_LINE, 2, 1);
  SetIndexStyle(3,DRAW_LINE, 2, 1);
  IndicatorDigits(Digits+2);
  SetIndexBuffer(0, BandUp);
  SetIndexBuffer(1, BandDown);
  SetIndexBuffer(2, MidUp);
  SetIndexBuffer(3, MidDown);
  IndicatorShortName("MinMax Bands");
   
  return(0);

}

int start() {

   int counted_bars=IndicatorCounted();   
   int limit,i;
   
   if(counted_bars>0) counted_bars--;
      
   limit=Bars-counted_bars;
   
   for(i=limit-1; i>=0; i--) 
   {
      BandUp[i] = High[iHighest(NULL,0,Price,Band_Period,i)];
      BandDown[i] = Low[iLowest(NULL,0,Price,Band_Period,i)];
      if (ShowMiddleBands)
      {
         MidUp[i] = BandDown[i]+(BandUp[i]-BandDown[i])*0.382;
         MidDown[i] = BandDown[i]+(BandUp[i]-BandDown[i])*0.618;
      }
   }
   return(0);
}
