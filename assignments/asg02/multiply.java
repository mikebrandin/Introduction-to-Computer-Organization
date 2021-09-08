/*
Mike Brandin
CPSC 2310 Lab Section 2
Program Assignment 3
07/16/21

Description:
This program uses binary arithmetic and string manipulation in order to the 
illustrate the steps for binary multiplication and then displaying the output
side-by-side with the decimal equivalent multiplication equation.
*/

import java.util.*;
import java.lang.*;

public class multiply {

  public static void main(String args[]){
    int multiplicand = 0;
    int multiplier = 0;
    int step = 1;
    int lsb = 0;

    boolean invalid = true;
    boolean calculating = true;

    String sum = "";
    String acc = "00000000";
    Character carry = '0';
    String mq;
    Integer result = 0;
    String sresult;

    Scanner input = new Scanner(System.in);

    while (invalid) {//validate input for multiplicand
    System.out.print("multiplicand: ");

      if (input.hasNextInt()) {//check for overflow/non-integer input
          multiplicand = input.nextInt();

          if (multiplicand > 255) {
              System.out.println("Multiplicand cannot be greater than 255");
          }
          else if (multiplicand < 0) {
              System.out.println("Multiplicand cannot be less than 0");
          }
          else{
              break;
          }
      }
      else{
          System.out.println("Please enter a valid integer.");
          input.next();
      }
    }
    while (invalid) {//validate input for multiplier
    System.out.print("multiplier: ");

      if (input.hasNextInt()) {//check for overflow/non-integer input
          multiplier = input.nextInt();

          if (multiplier > 255) {
              System.out.println("Multiplier cannot be greater than 255");
          }
          else if (multiplier < 0) {
              System.out.println("Multiplier cannot be less than 0");
          }
          else{
              break;
          }
      }
      else{
          System.out.println("Please enter a valid integer.");
          input.next();
      }
    }
    //convert to binary
    String binMultiplicand = Integer.toBinaryString(multiplicand);
    String binMultiplier = Integer.toBinaryString(multiplier);
    //convert to 8-bit by padding with zeros
    binMultiplicand = pad8Bit(binMultiplicand);
    binMultiplier = pad8Bit(binMultiplier);
    //initiate the values of the mq and "sum" 
    //which we will use to make acc and the mq one string 
    //NOTE: Carry is not held in the sum
    sum = acc + " " + binMultiplier;
    mq = binMultiplier;

    System.out.println("\nc and acc set to 0");

    Formatter fmt = new Formatter();//fix formatting to match expected output
    fmt.format("%4d", multiplier);

    System.out.println("mq set to multiplier    =" + fmt + " decimal and " + binMultiplier + " binary");

    fmt = new Formatter();//fix formatting to match expected output
    fmt.format("%4d", multiplicand);

    System.out.println("mdr set to multiplicand =" + fmt + " decimal and " + binMultiplicand + " binary");

    while (calculating){//while loop for while the product is calculating
      System.out.println("---------------------------------------------------");
      System.out.println("step " + step + ":   " + carry + " " + sum);
      lsb = sum.charAt(sum.length() - 1) - '0';//get the least significant bit

      if (lsb == 0){//if lsb = 0 add 00000000 (sum is unchanged)
        System.out.println("        +   " + "00000000" + "        ^ no add based on lsb=" + lsb);
        System.out.println("          ----------");
        System.out.println("          " + carry + " " + sum);
      }
      else if (lsb == 1){//if lsb = 1 add the multiplicand to acc
        System.out.println("        +   " + binMultiplicand + "        ^ add based on lsb=" + lsb);
        System.out.println("          ----------");
        result = Integer.parseInt(acc, 2) + Integer.parseInt(binMultiplicand, 2);
        sresult = (Integer.toBinaryString(result));
        if (result > 255){//if there is a carry set carry = 1 and trim the first character from the result
          carry = '1';
          sresult = sresult.substring(1, 9);//possible failure
          result = Integer.parseInt(sresult,2);
        }
        else{//if no carry set carry = 0
          carry = '0';
        }
        sum = pad8Bit(Integer.toBinaryString(result)) + " " + mq;//format string for sum by zero padding the result + " " mq
        System.out.println("          " + carry + " " + sum);
      }
      System.out.println("       >>                     shift right");
      sum = sum.replaceAll(" ", "");//remove zeros from sum

      sum = sum.substring(0,sum.length()-1);//Shift right using string manipulation (NOTE: I did not use the >> operator)
      sum = carry + sum;//add carry to the front after trimming the lsb from the sum

      carry = '0';//new carry is always 0
      acc = sum.substring(0,8);//get acc from the sum
      mq = sum.substring(8,16);//get mq from the sum
      sum = acc + " " + mq;//reformat sum string
      System.out.println("          " + carry + " " + sum);
      if (step == 8){//if we are at last step for 8 bit binary hardware multiplication break from loop
        calculating = false;
      }
      else {//otherwise increment to the next step
        step++; 
      }
    }//calculating

    //Post output while manipulating formatting to match expected output
    System.out.println("---------------------------------------------------");
    System.out.println("check:                 binary   decimal");
    fmt = new Formatter();
    fmt.format("%10d", multiplicand);
    System.out.println("                     " + binMultiplicand  + fmt);
    fmt = new Formatter();
    fmt.format("%7d", multiplier);
    System.out.println("           x         " + binMultiplier + "  x" + fmt);
    System.out.println("             ----------------    ------");
    fmt = new Formatter();
    fmt.format("%10d", multiplicand * multiplier);
    System.out.println("             " + (sum.replaceAll(" ", "")) + fmt);


  }//main

  /*
    Brief description for pad8bit():
    Takes in a string as a parameter and will zero pad the front of the string 
    until the bit length is eight since this is program calculates 8 bit numbers.
    After zeropadding it will return the formatted string.
  */
  static String pad8Bit(String s){
      for (int i = s.length(); i < 8; i++){
        s = "0" + s;
      }
      return s;
  }


}
