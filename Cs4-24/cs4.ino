#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27,20,4);  // set the LCD address to 0x27 for a 16 chars and 2 line display
#include <Wire.h>
#include <MPU6050.h>
//#include <Wire.h>
//#include <MPU6050.h>

MPU6050 mpu;

//MPU6050 mpu;

void setup() 
{
  lcd.init();                     
  // Print a message to the LCD.
  lcd.backlight();
  Serial.begin(115200);

  Serial.println("Initialize MPU6050");

  while(!mpu.begin(MPU6050_SCALE_2000DPS, MPU6050_RANGE_2G))
  {
    Serial.println("Could not find a valid MPU6050 sensor, check wiring!");
    delay(500);
  }



  
}

void loop()
{
  float temp = mpu.readTemperature();
  lcd.setCursor(0,0);
  lcd.print(" Temp = ");
    lcd.setCursor(6,0);
  lcd.print(temp);
  Serial.println(" *C");
  // Read normalized values 
  Vector normAccel = mpu.readNormalizeAccel();

  // Calculate Pitch & Roll
  int pitch = -(atan2(normAccel.XAxis, sqrt(normAccel.YAxis*normAccel.YAxis + normAccel.ZAxis*normAccel.ZAxis))*180.0)/M_PI;
  int roll = (atan2(normAccel.YAxis, normAccel.ZAxis)*180.0)/M_PI;

  // Output
  Serial.print(" Pitch = ");
  Serial.print(pitch);
  Serial.print(" Roll = ");
  Serial.print(roll);
  
  Serial.println();
  if(roll== -94 or pitch>=1 and pitch<=7 ){
    lcd.setCursor(1,1);
      lcd.print(" Help Me");
      
delay(1000);
lcd.clear();
  }
   if(roll== -94 or pitch>=8 and pitch<=22 ){
    lcd.setCursor(1,1);
      lcd.print(" INEED FOOD");

      
delay(1000);
lcd.clear();
  }
  if(roll== -94 or pitch>=30 and pitch<=60 ){
    lcd.setCursor(1,1);
      lcd.print(" THANKS");
delay(1000);
lcd.clear();
  }
    if(roll== -94 or pitch<=-35 and pitch>=-60 ){
      lcd.setCursor(1,1);
      lcd.print(" INEED BATHROOM");
delay(1000);
lcd.clear();
  }
//  if(roll> 50 && pitch<=20){
//      lcd.print(" Im Fine");
//delay(500);
//lcd.clear();
//  }
//   if(roll< 0&& pitch>=25){
//      lcd.print(" Hello");
//delay(500);
//lcd.clear();
//  }
//   if(roll< 20 || roll> 40  && pitch>=50){
//      lcd.print(" Thanks you");
//delay(500);
//lcd.clear();
//  }
 delay(800);
}