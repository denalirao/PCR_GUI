// March 6 2016
// Tufts Synthetic Biology
// arduino code to control pcr setup
void setup() {
   Serial.begin(9600);

   float denaturing_temp;
   float annealing_temp;
   float extending_temp;
   //   float holding_temp; // not used yet
   int denaturing_time_raw; // convert from minutes:seconds to seconds
   int denaturing_time_seconds;
   int annealing_time_raw;
   int annealing_time_seconds;
   int extending_time_raw;
   int extending_time_seconds;
   int num_cycles;

}

void loop() {
  // for testing/ serial setup
  Serial.println("yo");

  for (cycle_count = 0; cycle_count < num_cycles; cycle_count++){
    // denature
    unsigned long startD = millis();
    while(millis() - startD <= denaturing_time_seconds){
      // go to and maintain denaturing_temp
    }

    // anneal
    unsigned long startD = millis();
    while(millis() - startD <= denaturing_time_seconds){
      // go to and maintain annealing_temp
    }


    // extend
    unsigned long startD = millis();
    while(millis() - startD <= denaturing_time_seconds){
      // go to and maintain extending_temp
    }


  }
  // hold

}
