/* The following code was generated by JFlex 1.4.1 on 2/13/11 3:53 PM */

package org.jhol.core.lexer;


/**
 * This class is a scanner generated by 
 * <a href="http://www.jflex.de/">JFlex</a> 1.4.1
 * on 2/13/11 3:53 PM from the specification file
 * <tt>C:/Work/My Projects/Eclipse/jHOLLight/src/org/jhol/core/lexer/Lexer.flex</tt>
 */
class Scanner {

  /** This character denotes the end of file */
  public static final int YYEOF = -1;

  /** initial size of the lookahead buffer */
  private static final int ZZ_BUFFERSIZE = 16384;

  /** lexical states */
  public static final int STRING = 1;
  public static final int YYINITIAL = 0;

  /** 
   * Translates characters to character classes
   */
  private static final char [] ZZ_CMAP = {
     0,  0,  0,  0,  0,  0,  0,  0,  0,  3,  2,  0,  3,  1,  0,  0, 
     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
     3,  0, 36,  0,  0,  0,  0,  0,  7,  8,  0,  0, 11,  0,  0,  0, 
     5,  5,  5,  5,  5,  5,  5,  5,  5,  5, 13, 12,  0,  0,  0,  0, 
     0, 28,  4, 21,  4,  4,  4,  4, 29,  4,  4,  4, 31,  4,  4, 30, 
    35,  4,  4,  4, 14,  4, 20,  4,  4,  4,  4,  9,  6, 10,  0,  5, 
     0, 16, 27,  4,  4, 32,  4,  4, 33, 34,  4,  4,  4, 26, 23, 22, 
    17,  4, 19, 24, 25,  4, 18,  4,  4, 15,  4,  0,  0,  0,  0,  0
  };

  /** 
   * Translates DFA states to action switch labels.
   */
  private static final int [] ZZ_ACTION = zzUnpackAction();

  private static final String ZZ_ACTION_PACKED_0 =
    "\2\0\1\1\2\2\1\3\1\4\1\5\1\6\1\7"+
    "\1\10\1\11\1\12\7\3\1\13\1\14\1\15\15\3"+
    "\1\16\2\3\1\17\5\3\1\20\2\3\1\21\1\3"+
    "\1\22\1\23\1\24\1\25\1\3\1\26\3\3\1\27"+
    "\1\30";

  private static int [] zzUnpackAction() {
    int [] result = new int[61];
    int offset = 0;
    offset = zzUnpackAction(ZZ_ACTION_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackAction(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }


  /** 
   * Translates a state to a row index in the transition table
   */
  private static final int [] ZZ_ROWMAP = zzUnpackRowMap();

  private static final String ZZ_ROWMAP_PACKED_0 =
    "\0\0\0\45\0\112\0\157\0\112\0\224\0\112\0\112"+
    "\0\112\0\112\0\112\0\112\0\112\0\271\0\336\0\u0103"+
    "\0\u0128\0\u014d\0\u0172\0\u0197\0\112\0\u01bc\0\112\0\u01e1"+
    "\0\u0206\0\u022b\0\u0250\0\u0275\0\u029a\0\u02bf\0\u02e4\0\u0309"+
    "\0\u032e\0\u0353\0\u0378\0\u039d\0\224\0\u03c2\0\u03e7\0\224"+
    "\0\u040c\0\u0431\0\u0456\0\u047b\0\u04a0\0\224\0\u04c5\0\u04ea"+
    "\0\224\0\u050f\0\224\0\224\0\224\0\224\0\u0534\0\224"+
    "\0\u0559\0\u057e\0\u05a3\0\224\0\224";

  private static int [] zzUnpackRowMap() {
    int [] result = new int[61];
    int offset = 0;
    offset = zzUnpackRowMap(ZZ_ROWMAP_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackRowMap(String packed, int offset, int [] result) {
    int i = 0;  /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int high = packed.charAt(i++) << 16;
      result[j++] = high | packed.charAt(i++);
    }
    return j;
  }

  /** 
   * The transition table of the DFA
   */
  private static final int [] ZZ_TRANS = zzUnpackTrans();

  private static final String ZZ_TRANS_PACKED_0 =
    "\1\3\1\4\2\5\1\6\2\3\1\7\1\10\1\11"+
    "\1\12\1\13\1\14\1\15\1\16\5\6\1\17\1\20"+
    "\6\6\1\21\1\22\1\6\1\23\3\6\1\24\1\25"+
    "\1\26\1\3\1\0\3\26\1\3\35\26\1\27\47\0"+
    "\1\5\46\0\2\6\10\0\26\6\5\0\2\6\10\0"+
    "\1\6\1\30\20\6\1\31\1\32\2\6\5\0\2\6"+
    "\10\0\2\6\1\33\23\6\5\0\2\6\10\0\10\6"+
    "\1\34\15\6\5\0\2\6\10\0\15\6\1\35\10\6"+
    "\5\0\2\6\10\0\20\6\1\36\5\6\5\0\2\6"+
    "\10\0\24\6\1\37\1\6\5\0\2\6\10\0\2\6"+
    "\1\40\23\6\1\0\1\26\2\0\3\26\1\0\35\26"+
    "\5\0\2\6\10\0\2\6\1\41\1\6\1\42\21\6"+
    "\5\0\2\6\10\0\5\6\1\43\20\6\5\0\2\6"+
    "\10\0\22\6\1\44\3\6\5\0\2\6\10\0\5\6"+
    "\1\45\20\6\5\0\2\6\10\0\11\6\1\46\2\6"+
    "\1\47\11\6\5\0\2\6\10\0\12\6\1\50\13\6"+
    "\5\0\2\6\10\0\21\6\1\51\4\6\5\0\2\6"+
    "\10\0\12\6\1\52\13\6\5\0\2\6\10\0\24\6"+
    "\1\53\1\6\5\0\2\6\10\0\3\6\1\54\22\6"+
    "\5\0\2\6\10\0\2\6\1\55\23\6\5\0\2\6"+
    "\10\0\14\6\1\56\11\6\5\0\2\6\10\0\10\6"+
    "\1\57\15\6\5\0\2\6\10\0\12\6\1\60\13\6"+
    "\5\0\2\6\10\0\15\6\1\61\10\6\5\0\2\6"+
    "\10\0\1\62\25\6\5\0\2\6\10\0\13\6\1\63"+
    "\12\6\5\0\2\6\10\0\5\6\1\64\20\6\5\0"+
    "\2\6\10\0\3\6\1\65\22\6\5\0\2\6\10\0"+
    "\5\6\1\66\20\6\5\0\2\6\10\0\5\6\1\67"+
    "\20\6\5\0\2\6\10\0\13\6\1\70\12\6\5\0"+
    "\2\6\10\0\1\6\1\71\24\6\5\0\2\6\10\0"+
    "\22\6\1\72\3\6\5\0\2\6\10\0\3\6\1\73"+
    "\22\6\5\0\2\6\10\0\14\6\1\74\11\6\5\0"+
    "\2\6\10\0\22\6\1\75\3\6\1\0";

  private static int [] zzUnpackTrans() {
    int [] result = new int[1480];
    int offset = 0;
    offset = zzUnpackTrans(ZZ_TRANS_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackTrans(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      value--;
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }


  /* error codes */
  private static final int ZZ_UNKNOWN_ERROR = 0;
  private static final int ZZ_NO_MATCH = 1;
  private static final int ZZ_PUSHBACK_2BIG = 2;

  /* error messages for the codes above */
  private static final String ZZ_ERROR_MSG[] = {
    "Unkown internal scanner error",
    "Error: could not match input",
    "Error: pushback value was too large"
  };

  /**
   * ZZ_ATTRIBUTE[aState] contains the attributes of state <code>aState</code>
   */
  private static final int [] ZZ_ATTRIBUTE = zzUnpackAttribute();

  private static final String ZZ_ATTRIBUTE_PACKED_0 =
    "\2\0\1\11\1\1\1\11\1\1\7\11\7\1\1\11"+
    "\1\1\1\11\46\1";

  private static int [] zzUnpackAttribute() {
    int [] result = new int[61];
    int offset = 0;
    offset = zzUnpackAttribute(ZZ_ATTRIBUTE_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackAttribute(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }

  /** the input device */
  private java.io.Reader zzReader;

  /** the current state of the DFA */
  private int zzState;

  /** the current lexical state */
  private int zzLexicalState = YYINITIAL;

  /** this buffer contains the current text to be matched and is
      the source of the yytext() string */
  private char zzBuffer[] = new char[ZZ_BUFFERSIZE];

  /** the textposition at the last accepting state */
  private int zzMarkedPos;

  /** the textposition at the last state to be included in yytext */
  private int zzPushbackPos;

  /** the current text position in the buffer */
  private int zzCurrentPos;

  /** startRead marks the beginning of the yytext() string in the buffer */
  private int zzStartRead;

  /** endRead marks the last character in the buffer, that has been read
      from input */
  private int zzEndRead;

  /** number of newlines encountered up to the start of the matched text */
  private int yyline;

  /** the number of characters up to the start of the matched text */
  private int yychar;

  /**
   * the number of characters from the last newline up to the start of the 
   * matched text
   */
  private int yycolumn;

  /** 
   * zzAtBOL == true <=> the scanner is currently at the beginning of a line
   */
  private boolean zzAtBOL = true;

  /** zzAtEOF == true <=> the scanner is at the EOF */
  private boolean zzAtEOF;

  /** denotes if the user-EOF-code has already been executed */
  private boolean zzEOFDone;

  /* user code: */
        StringBuffer string = new StringBuffer();

        private Token lastToken;

        public Token peekToken() throws java.io.IOException {
                if (lastToken != null)
                        return lastToken;
                else
                        return lastToken = get_token();
        }

        public Token nextToken() throws java.io.IOException {
                if (lastToken != null) {
                        Token tmp = lastToken;
                        lastToken = null;
                        return tmp;
                }

                return get_token();
        }


  /**
   * Creates a new scanner
   * There is also a java.io.InputStream version of this constructor.
   *
   * @param   in  the java.io.Reader to read input from.
   */
  Scanner(java.io.Reader in) {
    this.zzReader = in;
  }

  /**
   * Creates a new scanner.
   * There is also java.io.Reader version of this constructor.
   *
   * @param   in  the java.io.Inputstream to read input from.
   */
  Scanner(java.io.InputStream in) {
    this(new java.io.InputStreamReader(in));
  }


  /**
   * Refills the input buffer.
   *
   * @return      <code>false</code>, iff there was new input.
   * 
   * @exception   java.io.IOException  if any I/O-Error occurs
   */
  private boolean zzRefill() throws java.io.IOException {

    /* first: make room (if you can) */
    if (zzStartRead > 0) {
      System.arraycopy(zzBuffer, zzStartRead,
                       zzBuffer, 0,
                       zzEndRead-zzStartRead);

      /* translate stored positions */
      zzEndRead-= zzStartRead;
      zzCurrentPos-= zzStartRead;
      zzMarkedPos-= zzStartRead;
      zzPushbackPos-= zzStartRead;
      zzStartRead = 0;
    }

    /* is the buffer big enough? */
    if (zzCurrentPos >= zzBuffer.length) {
      /* if not: blow it up */
      char newBuffer[] = new char[zzCurrentPos*2];
      System.arraycopy(zzBuffer, 0, newBuffer, 0, zzBuffer.length);
      zzBuffer = newBuffer;
    }

    /* finally: fill the buffer with new input */
    int numRead = zzReader.read(zzBuffer, zzEndRead,
                                            zzBuffer.length-zzEndRead);

    if (numRead < 0) {
      return true;
    }
    else {
      zzEndRead+= numRead;
      return false;
    }
  }

    
  /**
   * Closes the input stream.
   */
  public final void yyclose() throws java.io.IOException {
    zzAtEOF = true;            /* indicate end of file */
    zzEndRead = zzStartRead;  /* invalidate buffer    */

    if (zzReader != null)
      zzReader.close();
  }


  /**
   * Resets the scanner to read from a new input stream.
   * Does not close the old reader.
   *
   * All internal variables are reset, the old input stream 
   * <b>cannot</b> be reused (internal buffer is discarded and lost).
   * Lexical state is set to <tt>ZZ_INITIAL</tt>.
   *
   * @param reader   the new input stream 
   */
  public final void yyreset(java.io.Reader reader) {
    zzReader = reader;
    zzAtBOL  = true;
    zzAtEOF  = false;
    zzEndRead = zzStartRead = 0;
    zzCurrentPos = zzMarkedPos = zzPushbackPos = 0;
    yyline = yychar = yycolumn = 0;
    zzLexicalState = YYINITIAL;
  }


  /**
   * Returns the current lexical state.
   */
  public final int yystate() {
    return zzLexicalState;
  }


  /**
   * Enters a new lexical state
   *
   * @param newState the new lexical state
   */
  public final void yybegin(int newState) {
    zzLexicalState = newState;
  }


  /**
   * Returns the text matched by the current regular expression.
   */
  public final String yytext() {
    return new String( zzBuffer, zzStartRead, zzMarkedPos-zzStartRead );
  }


  /**
   * Returns the character at position <tt>pos</tt> from the 
   * matched text. 
   * 
   * It is equivalent to yytext().charAt(pos), but faster
   *
   * @param pos the position of the character to fetch. 
   *            A value from 0 to yylength()-1.
   *
   * @return the character at position pos
   */
  public final char yycharat(int pos) {
    return zzBuffer[zzStartRead+pos];
  }


  /**
   * Returns the length of the matched text region.
   */
  public final int yylength() {
    return zzMarkedPos-zzStartRead;
  }


  /**
   * Reports an error that occured while scanning.
   *
   * In a wellformed scanner (no or only correct usage of 
   * yypushback(int) and a match-all fallback rule) this method 
   * will only be called with things that "Can't Possibly Happen".
   * If this method is called, something is seriously wrong
   * (e.g. a JFlex bug producing a faulty scanner etc.).
   *
   * Usual syntax/scanner level error handling should be done
   * in error fallback rules.
   *
   * @param   errorCode  the code of the errormessage to display
   */
  private void zzScanError(int errorCode) {
    String message;
    try {
      message = ZZ_ERROR_MSG[errorCode];
    }
    catch (ArrayIndexOutOfBoundsException e) {
      message = ZZ_ERROR_MSG[ZZ_UNKNOWN_ERROR];
    }

    throw new Error(message);
  } 


  /**
   * Pushes the specified amount of characters back into the input stream.
   *
   * They will be read again by then next call of the scanning method
   *
   * @param number  the number of characters to be read again.
   *                This number must not be greater than yylength()!
   */
  public void yypushback(int number)  {
    if ( number > yylength() )
      zzScanError(ZZ_PUSHBACK_2BIG);

    zzMarkedPos -= number;
  }


  /**
   * Contains user EOF-code, which will be executed exactly once,
   * when the end of file is reached
   */
  private void zzDoEOF() throws java.io.IOException {
    if (!zzEOFDone) {
      zzEOFDone = true;
      yyclose();
    }
  }


  /**
   * Resumes scanning until the next regular expression is matched,
   * the end of input is encountered or an I/O-Error occurs.
   *
   * @return      the next token
   * @exception   java.io.IOException  if any I/O-Error occurs
   */
  public Token get_token() throws java.io.IOException {
    int zzInput;
    int zzAction;

    // cached fields:
    int zzCurrentPosL;
    int zzMarkedPosL;
    int zzEndReadL = zzEndRead;
    char [] zzBufferL = zzBuffer;
    char [] zzCMapL = ZZ_CMAP;

    int [] zzTransL = ZZ_TRANS;
    int [] zzRowMapL = ZZ_ROWMAP;
    int [] zzAttrL = ZZ_ATTRIBUTE;

    while (true) {
      zzMarkedPosL = zzMarkedPos;

      boolean zzR = false;
      for (zzCurrentPosL = zzStartRead; zzCurrentPosL < zzMarkedPosL;
                                                             zzCurrentPosL++) {
        switch (zzBufferL[zzCurrentPosL]) {
        case '\u000B':
        case '\u000C':
        case '\u0085':
        case '\u2028':
        case '\u2029':
          yyline++;
          yycolumn = 0;
          zzR = false;
          break;
        case '\r':
          yyline++;
          yycolumn = 0;
          zzR = true;
          break;
        case '\n':
          if (zzR)
            zzR = false;
          else {
            yyline++;
            yycolumn = 0;
          }
          break;
        default:
          zzR = false;
          yycolumn++;
        }
      }

      if (zzR) {
        // peek one character ahead if it is \n (if we have counted one line too much)
        boolean zzPeek;
        if (zzMarkedPosL < zzEndReadL)
          zzPeek = zzBufferL[zzMarkedPosL] == '\n';
        else if (zzAtEOF)
          zzPeek = false;
        else {
          boolean eof = zzRefill();
          zzEndReadL = zzEndRead;
          zzMarkedPosL = zzMarkedPos;
          zzBufferL = zzBuffer;
          if (eof) 
            zzPeek = false;
          else 
            zzPeek = zzBufferL[zzMarkedPosL] == '\n';
        }
        if (zzPeek) yyline--;
      }
      zzAction = -1;

      zzCurrentPosL = zzCurrentPos = zzStartRead = zzMarkedPosL;
  
      zzState = zzLexicalState;


      zzForAction: {
        while (true) {
    
          if (zzCurrentPosL < zzEndReadL)
            zzInput = zzBufferL[zzCurrentPosL++];
          else if (zzAtEOF) {
            zzInput = YYEOF;
            break zzForAction;
          }
          else {
            // store back cached positions
            zzCurrentPos  = zzCurrentPosL;
            zzMarkedPos   = zzMarkedPosL;
            boolean eof = zzRefill();
            // get translated positions and possibly new buffer
            zzCurrentPosL  = zzCurrentPos;
            zzMarkedPosL   = zzMarkedPos;
            zzBufferL      = zzBuffer;
            zzEndReadL     = zzEndRead;
            if (eof) {
              zzInput = YYEOF;
              break zzForAction;
            }
            else {
              zzInput = zzBufferL[zzCurrentPosL++];
            }
          }
          int zzNext = zzTransL[ zzRowMapL[zzState] + zzCMapL[zzInput] ];
          if (zzNext == -1) break zzForAction;
          zzState = zzNext;

          int zzAttributes = zzAttrL[zzState];
          if ( (zzAttributes & 1) == 1 ) {
            zzAction = zzState;
            zzMarkedPosL = zzCurrentPosL;
            if ( (zzAttributes & 8) == 8 ) break zzForAction;
          }

        }
      }

      // store back cached position
      zzMarkedPos = zzMarkedPosL;

      switch (zzAction < 0 ? zzAction : ZZ_ACTION[zzAction]) {
        case 9: 
          { return new Token(TokenType.SEMICOLON);
          }
        case 25: break;
        case 13: 
          { yybegin(YYINITIAL); return new Token(TokenType.STRING, string.toString());
          }
        case 26: break;
        case 7: 
          { return new Token(TokenType.RBRACK);
          }
        case 27: break;
        case 21: 
          { return new Token(TokenType.Tyvar);
          }
        case 28: break;
        case 1: 
          { System.err.println("Illegal character: "+yytext());
          }
        case 29: break;
        case 17: 
          { return new Token(TokenType.Comb);
          }
        case 30: break;
        case 12: 
          { string.append( yytext() );
          }
        case 31: break;
        case 23: 
          { return new Token(TokenType.Theorem);
          }
        case 32: break;
        case 15: 
          { return new Token(TokenType.Abs);
          }
        case 33: break;
        case 20: 
          { return new Token(TokenType.Tyapp);
          }
        case 34: break;
        case 19: 
          { return new Token(TokenType.Pair);
          }
        case 35: break;
        case 10: 
          { return new Token(TokenType.COLON);
          }
        case 36: break;
        case 18: 
          { return new Token(TokenType.List);
          }
        case 37: break;
        case 14: 
          { return new Token(TokenType.Var);
          }
        case 38: break;
        case 3: 
          { return new Token(TokenType.IDENTIFIER, yytext());
          }
        case 39: break;
        case 5: 
          { return new Token(TokenType.RPAR);
          }
        case 40: break;
        case 8: 
          { return new Token(TokenType.COMMA);
          }
        case 41: break;
        case 6: 
          { return new Token(TokenType.LBRACK);
          }
        case 42: break;
        case 24: 
          { return new Token(TokenType.HOLType);
          }
        case 43: break;
        case 4: 
          { return new Token(TokenType.LPAR);
          }
        case 44: break;
        case 11: 
          { yybegin(STRING); string.setLength(0);
          }
        case 45: break;
        case 22: 
          { return new Token(TokenType.Const);
          }
        case 46: break;
        case 16: 
          { return new Token(TokenType.Term);
          }
        case 47: break;
        case 2: 
          { 
          }
        case 48: break;
        default: 
          if (zzInput == YYEOF && zzStartRead == zzCurrentPos) {
            zzAtEOF = true;
            zzDoEOF();
              {     return new Token(TokenType.EOF);
 }
          } 
          else {
            zzScanError(ZZ_NO_MATCH);
          }
      }
    }
  }


}
