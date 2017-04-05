import processing.sound.*;

SawOsc sine;
String[] algorithmArray = {"heapSort","bubble1","bubble2"};

int[] array;
boolean[] selected;
int size = 100;
float maxNum = 1000;
int wdth = 5, space = 1;
int delayTime = 10;
int algorithmNumber = -1;

void setup(){
  size(700,400);
  fill(255);
  noStroke();
  background(0);
  
  array = new int[size];
  selected = new boolean[size];
  
  for (int i=0;i<size;i++)
    array[i] = int(random (maxNum))+1;
  
  if (sine == null) {
  sine = new SawOsc(this);
  }
  else
    sine.stop();
  
  sine.play();
  algorithmNumber = (algorithmNumber+1)%3;
  thread(algorithmArray[0]);
  //thread(algorithmArray[algorithmNumber]);
  
}
void clearSelected() {
  for (int i=0;i<array.length;i++)
    selected[i] = false;
}

boolean sorted() {
  if (array == null)
    return false;
  for (int i=1;i<array.length;i++)
    if (array[i]<array[i-1])
      return false;
  return true;
}

void niceSwap(int i, int j){
   int aux;
   aux = array[i];
   array[i] = array[j];
   array[j] = aux;
   selected[i] = true;
   selected[j] = true;
   sine.freq(max(array[i],array[j])*2);
   delay(delayTime);
   clearSelected(); 
}

void bubble1() {
  int i,aux;
  while (!sorted()){
    for (i=0;i<size-1;i++){
      if (array[i] > array[i+1]){
         niceSwap(i,i+1); 
      }
    }
  }
  sine.stop();
}

void bubble2() {
 int i,j;
 for (i=0;i<array.length;i++){
   for (j=i+1;j<array.length;j++) {
     if (array[i] > array[j]) {
       niceSwap(i,j);
     }
   }
 }
 sine.stop();
}

void heapSort() {
  int i, j, k;
  for (i=0;i<size;i++) {
    j = i;
    while (j>0 && array[j] > array[j/2]) {
      niceSwap(j,j/2);
      j = j/2;
    }
  }
  
  print("!");
  for (i = 0;i<array.length;i++)
    print (array[i] + " ");
 println();
  
  for (int currentSize=size;currentSize>=1;){
    j = 0;
    int child = 1;
    niceSwap(0,currentSize-1);
    currentSize--;
    while (child < currentSize) {
      if (child < currentSize-1 && array[child] < array[child+1]){
        child++;
      }
      if (array[child] > array[j]) {
        niceSwap(j,child);
        j = child;
        child *= 2;
      }
      else
        break;
    }
  }
  
  sine.stop();
  
}

void drawCurrentState() {
   background(0);
   for (int i=0;i<array.length;i++) {
     if (selected[i])
       fill(255,0,0);
     rect(i*(wdth+space),400-(array[i]/maxNum)*400,wdth,400);
     fill(255);
   }
}

void draw() { 
  drawCurrentState();
}

void mousePressed(){
  setup();
}