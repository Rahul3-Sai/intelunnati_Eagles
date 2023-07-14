module ATM_Machine_TB;
  reg clk;
  reg reset;
  reg [3:0] keypad;
  reg [3:0] card_swipe;
  reg [3:0] withdrawal_amount;
  reg [3:0] deposit_amount;
  wire [7:0] display;
  wire locked;
  wire [7:0] mini_statement;

  ATM_Machine uut (
    .clk(clk),
    .reset(reset),
    .keypad(keypad),
    .card_swipe(card_swipe),
    .withdrawal_amount(withdrawal_amount),
    .deposit_amount(deposit_amount),
    .display(display),
    .locked(locked),
    .mini_statement(mini_statement)
  );

  // Clock generation
  always begin
    clk = ~clk;
    #5; // Half-period delay
  end

  // Testbench stimulus
  initial begin
    clk = 0;
    reset = 1;
    keypad = 4'b0000;
    card_swipe = 4'b0000;
    withdrawal_amount = 4'b0000;
    deposit_amount = 4'b0000;
    #10; // Wait for a few clock cycles

    // Reset the ATM machine
    reset = 0;
    #20; // Wait for a few clock cycles

    // Test case 1: Card swipe and valid PIN entry
    card_swipe = 4'b1010;
    #10;
    keypad = 4'b0000;
    #10;
    keypad = 4'b0001;
    #10;
    keypad = 4'b0010;
    #10;
    keypad = 4'b0011;
    #20;
    card_swipe = 4'b0000;
    #20;

    // Test case 2: Withdrawal
    card_swipe = 4'b1010;
    #10;
    keypad = 4'b0000;
    #10;
    keypad = 4'b0001;
    #10;
    keypad = 4'b0010;
    #10;
    keypad = 4'b0011;
    #20;
    withdrawal_amount = 4'b0100;
    #10;
    keypad = 4'b0000;
    #20;
    withdrawal_amount = 4'b0010;
    #10;
    keypad = 4'b0000;
    #20;
    card_swipe = 4'b0000;
    #20;

    // Test case 3: Deposit
    card_swipe = 4'b1010;
    #10;
    keypad = 4'b0000;
    #10;
    keypad = 4'b0001;
    #10;
    keypad = 4'b0010;
    #10;
    keypad = 4'b0011;
    #20;
    deposit_amount = 4'b0100;
    #10;
    keypad = 4'b0000;
    #20;
    deposit_amount = 4'b0010;
    #10;
    keypad = 4'b0000;
    #20;
    card_swipe = 4'b0000;
    #20;

    // Test case 4: Mini statement
    card_swipe = 4'b1010;
    #10;
    keypad = 4'b0000;
    #10;
    keypad = 4'b0001;
    #10;
    keypad = 4'b0010;
    #10;
    keypad = 4'b0011;
    #20;
    keypad = 4'b1101;
    #20;
    card_swipe = 4'b0000;
    #20;

    // Test case 5: Account lock
    card_swipe = 4'b1010;
    #10;
    keypad = 4'b0000;
    #10;
    keypad = 4'b0001;
    #10;
    keypad = 4'b0010;
    #10;
    keypad = 4'b0011;
    #20;
    keypad = 4'b0000;
    #10;
    keypad = 4'b0000;
    #10;
    keypad = 4'b0000;
    #10;
    keypad = 4'b0000;
    #10;
    keypad = 4'b0000;
    #20;
    card_swipe = 4'b0000;
    #20;

    //$finish; // End simulation
  end
endmodule
