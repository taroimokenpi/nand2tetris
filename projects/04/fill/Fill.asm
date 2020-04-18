// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Define
//@8192
@8192
D=A
@screen_words_size
M=D

(LOOP)
    // キーボードの入力を監視
    (CHECK_PRESS_KEY)
        // 初期化
        @SCREEN     // 16384   RAM[0x4000]
        D=A         // D = RAM[0x4000]
        @position   // 塗りつぶすスクリーン位置
        M=D         // position = RAM[0x4000]
        @i          // roop index
        M=0         // i = 0

        // キーボードの入力監視
        @KBD        // 24576    RAM[0x6000]
        D=M         // D = RAM[0x6000]
        @FILL_SCREEN
        D;JNE      // if RAM[0x6000]!=0 goto CLEAR_SCREEN
        @CLEAR_SCREEN
        0;JMP       // if RAM[0x6000]==0 goto FILL_SCREEN

    // スクリーン塗りつぶし
    (FILL_SCREEN)
        // ループ条件
        @i                  // Load i
        D=M
        @screen_words_size  // Load scrren_size_y
        D=D-M               // i-screen_words_size
        @LOOP
        D;JGE               //if((i-screen_words_size)==0) goto LOOP
        @position
        D=M                 // Load position
        A=D                 // AレジスタがSCREENのメモリ領域を指すように設定
        M=-1                // ワード単位で黒く塗りつぶし(−1=0x11111111)
        A=A+1               // addressをインクリメント
        D=A                 // RAM[address]を指定
        @position
        M=D
        @i
        M=M+1
        @FILL_SCREEN
        0;JMP
    
    // スクリーンをクリア
    (CLEAR_SCREEN)
        // ループ条件
        @i                  // Load i
        D=M
        @screen_words_size  // Load scrren_size_y
        D=D-M               // i-screen_words_size
        @LOOP
        D;JGE               //if((i-screen_words_size)==0) goto LOOP
        @position
        D=M                 // Load position
        A=D                 // AレジスタがSCREENのメモリ領域を指すように設定
        M=0                 // ワード単位で黒く塗りつぶし(−1=0x11111111)
        A=A+1               // addressをインクリメント
        D=A                 // RAM[address]を指定
        @position
        M=D
        @i
        M=M+1
        @CLEAR_SCREEN
        0;JMP
    
    @LOOP
    0;JMP   // 無条件分岐